<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.util.List" %>
    <%@ page import="java.time.format.DateTimeFormatter" %>
      <%@ page import="dao.ConsultaDAO" %>
        <%@ page import="dao.PacienteDAO" %>
          <%@ page import="model.Consulta" %>
            <%@ page import="model.Usuario" %>

              <% Usuario usuarioLogado=(Usuario) session.getAttribute("usuarioLogado"); if (usuarioLogado==null ||
                !"PACIENTE".equalsIgnoreCase(usuarioLogado.getTipo())) { response.sendRedirect("login.jsp"); return; }
                List<Consulta> minhasConsultas = null;
                try {
                PacienteDAO pacienteDAO = new PacienteDAO();
                Long idPaciente = pacienteDAO.getPacienteIdByUsuarioId(usuarioLogado.getId());

                if (idPaciente != null) {
                ConsultaDAO consultaDAO = new ConsultaDAO();
                minhasConsultas = consultaDAO.listarPorPaciente(idPaciente);
                }
                } catch (Exception e) {
                e.printStackTrace();
                }

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                %>

                <!DOCTYPE html>
                <html lang="pt-BR">

                <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>Consultas - HealthConnect</title>
                  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                    rel="stylesheet" />

                  <style>
                    * {
                      margin: 0;
                      padding: 0;
                      box-sizing: border-box;
                      outline: none;
                    }

                    body {
                      font-family: 'Roboto', sans-serif;
                      background: #f4f6f8;
                      color: #333;
                      display: flex;
                      flex-direction: column;
                      min-height: 100vh;
                    }

                    header {
                      background: #ffffff;
                      padding: 15px 40px;
                      display: flex;
                      justify-content: space-between;
                      align-items: center;
                      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                      position: sticky;
                      top: 0;
                      z-index: 100;
                    }

                    .logo {
                      font-size: 22px;
                      font-weight: 700;
                      color: #4FA58F;
                      letter-spacing: -0.5px;
                    }

                    nav a {
                      margin-left: 25px;
                      text-decoration: none;
                      color: #555;
                      font-weight: 500;
                      font-size: 14px;
                      transition: all 0.3s ease;
                    }

                    nav a:hover {
                      color: #4FA58F;
                    }

                    .consultas {
                      padding: 40px 20px;
                      flex: 1;
                      max-width: 1000px;
                      margin: 0 auto;
                      width: 100%;
                    }

                    .consultas h1 {
                      font-size: 28px;
                      color: #2c3e50;
                      margin-bottom: 8px;
                      font-weight: 700;
                    }

                    .consultas p {
                      font-size: 16px;
                      margin-bottom: 30px;
                      color: #7f8c8d;
                    }

                    table {
                      width: 100%;
                      border-collapse: separate;
                      border-spacing: 0;
                      background: #fff;
                      border-radius: 12px;
                      overflow: hidden;
                      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
                      border: 1px solid #eef0f2;
                    }

                    thead {
                      background: #4FA58F;
                      color: #fff;
                    }

                    th {
                      padding: 18px 20px;
                      text-align: left;
                      font-weight: 600;
                      font-size: 14px;
                      text-transform: uppercase;
                      letter-spacing: 0.5px;
                    }

                    td {
                      padding: 18px 20px;
                      text-align: left;
                      border-bottom: 1px solid #f0f0f0;
                      color: #555;
                      font-size: 14px;
                    }

                    tbody tr:last-child td {
                      border-bottom: none;
                    }

                    tbody tr {
                      transition: background-color 0.2s;
                    }

                    tbody tr:hover {
                      background: #f9f9f9;
                    }

                    .status-agendada {
                      color: #27ae60;
                      background-color: #eafaf1;
                      padding: 6px 12px;
                      border-radius: 20px;
                      font-weight: 600;
                      font-size: 12px;
                      display: inline-block;
                    }

                    .status-cancelada {
                      color: #e74c3c;
                      background-color: #fdedec;
                      padding: 6px 12px;
                      border-radius: 20px;
                      font-weight: 600;
                      font-size: 12px;
                      display: inline-block;
                    }

                    footer {
                      background: #2c3e50;
                      color: #ecf0f1;
                      text-align: center;
                      padding: 20px;
                      font-size: 14px;
                      margin-top: auto;
                    }
                  </style>
                </head>

                <body>

                  <header>
                    <div class="logo">HealthConnect</div>
                    <nav>
                      <a href="paciente-main.jsp">Início</a>
                      <a href="lista-profissionais.jsp">Nova Consulta</a>
                      <a href="perfil.jsp">Perfil</a>
                      <a href="logout.jsp" style="color: #e74c3c;">Sair</a>
                    </nav>
                  </header>

                  <section class="consultas">
                    <h1>Olá, <%= usuarioLogado.getNome() %>!</h1>
                    <p>Abaixo estão listadas suas consultas agendadas:</p>

                    <table>
                      <thead>
                        <tr>
                          <th>Data e Hora</th>
                          <th>Profissional</th>
                          <th>Registro</th>
                          <th>Status</th>
                        </tr>
                      </thead>
                      <tbody>
                        <% if (minhasConsultas !=null && !minhasConsultas.isEmpty()) { for (Consulta c :
                          minhasConsultas) { %>
                          <tr>
                            <td>
                              <%= c.getDataHora().format(formatter) %>
                            </td>
                            <td style="font-weight: 500; color: #333;">Dr(a). <%=
                                c.getProfissionalSaude().getUsuario().getNome() %>
                            </td>
                            <td>
                              <%= c.getProfissionalSaude().getRegistro() %>
                            </td>
                            <td>
                              <span class="<%= c.getStatus().equalsIgnoreCase(" CANCELADA") ? "status-cancelada"
                                : "status-agendada" %>">
                                <%= c.getStatus() %>
                              </span>
                            </td>
                          </tr>
                          <% } } else { %>
                            <tr>
                              <td colspan="4" style="text-align:center; padding: 40px; color: #7f8c8d;">
                                Você ainda não tem consultas agendadas.
                              </td>
                            </tr>
                            <% } %>
                      </tbody>
                    </table>
                  </section>

                  <footer>
                    <p>&copy; 2025 HealthConnect - Todos os direitos reservados</p>
                  </footer>

                </body>

                </html>