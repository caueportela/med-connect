package dao;

import connector.PostgresConnector;
import model.Usuario;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO { // <--- Faltava essa linha aqui!

    public Usuario createUsuario(Usuario usuario) throws Exception {
        // SQL ajustado para retornar o ID gerado automaticamente
        String sql = "INSERT into usuario (nome, email, senha, tipo) values (?,?,?,?) RETURNING id";

        PreparedStatement stmt = PostgresConnector.getInstance().prepareStatement(sql);

        stmt.setString(1, usuario.getNome());
        stmt.setString(2, usuario.getEmail());
        stmt.setString(3, usuario.getSenha());
        stmt.setString(4, usuario.getTipo());

        // Usamos executeQuery porque o INSERT agora retorna uma "tabela" com o ID
        ResultSet rs = stmt.executeQuery();

        // Pegamos o ID retornado e colocamos no objeto
        if (rs.next()) {
            usuario.setId(rs.getLong("id"));
        }

        rs.close();
        stmt.close();

        return usuario;
    }

    public Usuario findByEmail(String email) throws Exception {
        String sql = "SELECT * FROM usuario WHERE email = ?";
        PreparedStatement stmt = PostgresConnector.getInstance().prepareStatement(sql);

        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        Usuario usuario = null;

        if(rs.next()) {
            usuario = new Usuario();
            usuario.setId(rs.getLong("id"));
            usuario.setNome(rs.getString("nome"));
            usuario.setEmail(rs.getString("email"));
            usuario.setSenha(rs.getString("senha"));
            usuario.setTipo(rs.getString("tipo"));
        }
        rs.close();
        stmt.close();
        return usuario;
    }

    public Usuario login(String email, String senha) throws Exception {
        if (email == null || senha == null) {
            return null;
        }

        Usuario usuario = findByEmail(email.trim());
        if (usuario == null){
            return null;
        }

        // Logs para debug no console do servidor
        System.out.println("Senha no banco: [" + usuario.getSenha() + "]");
        System.out.println("Senha recebida: [" + senha + "]");

        if (usuario.getSenha() != null && usuario.getSenha().trim().equals(senha.trim())) {
            return usuario;
        }

        return null;
    }

} // <--- Fecha a classe aqui