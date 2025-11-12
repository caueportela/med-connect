package controller;

import dao.UsuarioDAO;
import dto.LoginRequestDTO;
import dto.LoginResponseDTO;
import model.Usuario;
import org.json.JSONObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redireciona para a página de login JSP
        response.sendRedirect("login.jsp");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String linha;

        while ((linha = reader.readLine()) != null) {
            sb.append(linha);
        }

        JSONObject json = new JSONObject(sb.toString());
        // entra DTO
        LoginRequestDTO LoginRequest = new LoginRequestDTO(
                json.getString("email"),
                json.getString("senha")
        );
        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario;
        try {
            usuario = dao.login(LoginRequest.getEmail(), LoginRequest.getSenha());
        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("{\"erro\":\"Erro interno no servidor\"}");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (usuario == null) {
            response.setStatus(401);
            response.getWriter().write("{\"erro\":\"Email ou senha incorretos\"}");
            return;
        }

        LoginResponseDTO responseDTO = new LoginResponseDTO(
                usuario.getId(),
                usuario.getEmail(),
                usuario.getTipo()
        );



        JSONObject userJson = new JSONObject();
        userJson.put("id", responseDTO.getId());
        userJson.put("email", responseDTO.getEmail());
        userJson.put("tipo", responseDTO.getTipo());

        response.getWriter().write(userJson.toString());
    }
}
