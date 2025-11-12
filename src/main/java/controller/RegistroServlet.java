package controller;

import dao.UsuarioDAO;
import dto.RegistroRequestDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Usuario;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/cadastro")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Lê o corpo JSON do request
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String linha;
        while ((linha = reader.readLine()) != null) {
            sb.append(linha);
        }

        JSONObject json = new JSONObject(sb.toString());

        // Cria DTO
        RegistroRequestDTO requestDTO = new RegistroRequestDTO(
                json.getString("nome"),
                json.getString("email"),
                json.getString("senha"),
                json.getString("tipo"),
                json.optString("registro") // retorna "" se não existir
        );

        // Valida registro para profissionais
        if (!requestDTO.getTipo().equalsIgnoreCase("paciente")) {
            if (requestDTO.getRegistro() == null || requestDTO.getRegistro().isEmpty()) {
                response.setStatus(400);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"erro\":\"Registro profissional é obrigatório para não pacientes\"}");
                return;
            }
        }

        // Cria objeto Usuario para persistir no banco
        Usuario usuario = new Usuario();
        usuario.setNome(requestDTO.getNome());
        usuario.setEmail(requestDTO.getEmail());
        usuario.setSenha(requestDTO.getSenha());
        usuario.setTipo(requestDTO.getTipo());
        // Se quiser guardar o registro, adicione campo no model e no DAO

        UsuarioDAO dao = new UsuarioDAO();
        try {
            dao.createUsuario(usuario);
        } catch (Exception e) {
            response.setStatus(500);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"erro\":\"Erro interno no servidor\"}");
            e.printStackTrace();
            return;
        }

        // Retorna resposta de sucesso
        response.setStatus(201);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"mensagem\":\"Cadastro realizado com sucesso!\"}");
    }
}
