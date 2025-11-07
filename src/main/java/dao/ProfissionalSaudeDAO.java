package dao;

import connector.PostgresConnector;
import model.ProfissionalSaude;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ProfissionalSaudeDAO {

    public ProfissionalSaude createProfissionalSaude(ProfissionalSaude ps)throws Exception {
        String sql = "INSERT INTO profissional_saude(usuario_id, registro) VALUES(?,?)";

        PreparedStatement stmt = PostgresConnector.getInstance().prepareStatement(sql);
        stmt.setLong(1, ps.getUsuario().getId());
        stmt.setString(2, ps.getRegistro());
        stmt.executeUpdate();
        stmt.close();

        return ps;
    }
}
