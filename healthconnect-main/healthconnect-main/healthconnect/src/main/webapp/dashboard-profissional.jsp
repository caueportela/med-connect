<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.util.List" %>
    <%@ page import="java.time.format.DateTimeFormatter" %>
      <%@ page import="dao.ConsultaDAO" %>
        <%@ page import="dao.ProfissionalSaudeDAO" %>
          <%@ page import="model.Consulta" %>
            <%@ page import="model.Usuario" %>

              <% Usuario usuario=(Usuario) session.getAttribute("usuarioLogado"); if (usuario==null ||
                !"PROFISSIONAL".equalsIgnoreCase(usuario.getTipo())) { response.sendRedirect("login.jsp"); return; }
                List<Consulta> minhasConsultas = null;
                try {
                ProfissionalSaudeDAO profDao = new ProfissionalSaudeDAO();
                Long idProfissional = profDao.getIdByUsuarioId(usuario.getId());

                if (idProfissional != null) {
                ConsultaDAO consultaDAO = new ConsultaDAO();
                minhasConsultas = consultaDAO.listarPorProfissional(idProfissional);
                }
                } catch (Exception e) {
                e.printStackTrace();
                }

                DateTimeFormatter diaFormat = DateTimeFormatter.ofPattern("dd");
                DateTimeFormatter mesAnoFormat = DateTimeFormatter.ofPattern("MMMM yyyy");
                DateTimeFormatter horaFormat = DateTimeFormatter.ofPattern("HH:mm");
                DateTimeFormatter dataCompleta = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                %>

                <!DOCTYPE html>
                <html lang="pt-BR">

                <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>HealthConnect - Painel do Profissional</title>
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
                      background-color: #f4f6f8;
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

                    .dashboard {
                      padding: 40px 20px;
                      flex: 1;
                      max-width: 1200px;
                      margin: 0 auto;
                      width: 100%;
                    }

                    .dashboard-header {
                      text-align: center;
                      margin-bottom: 40px;
                    }

                    .dashboard h1 {
                      font-size: 28px;
                      color: #2c3e50;
                      margin-bottom: 8px;
                      font-weight: 700;
                    }

                    .dashboard p {
                      font-size: 16px;
                      color: #7f8c8d;
                    }

                    .calendar {
                      width: 100%;
                    }

                    .calendar-header h2 {
                      font-size: 20px;
                      margin-bottom: 25px;
                      color: #2c3e50;
                      border-left: 5px solid #4FA58F;
                      padding-left: 15px;
                      font-weight: 600;
                    }

                    .calendar-grid {
                      display: grid;
                      grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                      gap: 25px;
                    }

                    .day {
                      background: #ffffff;
                      border-radius: 12px;
                      padding: 20px;
                      position: relative;
                      display: flex;
                      flex-direction: column;
                      justify-content: space-between;
                      transition: transform 0.3s ease, box-shadow 0.3s ease;
                      border: 1px solid #eef0f2;
                      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
                    }

                    .day:hover {
                      transform: translateY(-5px);
                      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
                      border-color: #4FA58F;
                    }

                    .date-header {
                      display: flex;
                      align-items: baseline;
                      margin-bottom: 15px;
                      padding-bottom: 10px;
                      border-bottom: 1px solid #f0f0f0;
                    }

                    .date-day {
                      font-size: 32px;
                      font-weight: 700;
                      color: #4FA58F;
                      margin-right: 8px;
                      line-height: 1;
                    }

                    .date-month {
                      font-size: 14px;
                      color: #95a5a6;
                      font-weight: 500;
                    }

                    .consultas {
                      flex-grow: 1;
                    }

                    .info-row {
                      margin-bottom: 12px;
                    }

                    .info-time {
                      display: block;
                      font-size: 18px;
                      font-weight: 600;
                      color: #34495e;
                      margin-bottom: 4px;
                    }

                    .info-paciente {
                      display: block;
                      font-size: 15px;
                      color: #555;
                    }

                    .info-motivo {
                      display: block;
                      font-size: 13px;
                      color: #7f8c8d;
                      background-color: #f8f9fa;
                      padding: 6px 10px;
                      border-radius: 6px;
                      margin-top: 8px;
                    }

                    .btn-cancelar {
                      background-color: #fff;
                      color: #e74c3c;
                      border: 1px solid #e74c3c;
                      padding: 10px;
                      border-radius: 6px;
                      cursor: pointer;
                      font-size: 13px;
                      font-weight: 600;
                      width: 100%;
                      margin-top: 15px;
                      transition: all 0.2s;
                      text-transform: uppercase;
                      letter-spacing: 0.5px;
                    }

                    .btn-cancelar:hover {
                      background-color: #e74c3c;
                      color: #fff;
                    }

                    .empty-msg {
                      grid-column: 1 / -1;
                      text-align: center;
                      padding: 60px;
                      background: #fff;
                      border-radius: 12px;
                      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
                    }

                    .empty-msg h3 {
                      color: #2c3e50;
                      font-size: 20px;
                      margin-bottom: 10px;
                    }

                    .empty-msg p {
                      color: #95a5a6;
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
                      <a href="dashboard-profissional.jsp">Minha Agenda</a>
                      <a href="perfil.jsp">Meu Perfil</a>
                      <a href="logout.jsp" style="color: #e74c3c;">Sair</a>
                    </nav>
                  </header>

                  <section class="dashboard">
                    <div class="dashboard-header">
                      <h1>Olá, Dr(a). <%= usuario.getNome() %>
                      </h1>
                      <p>Gerencie seus atendimentos agendados abaixo</p>
                    </div>

                    <div class="calendar">
                      <div class="calendar-header">
                        <h2>Próximas Consultas</h2>
                      </div>

                      <div class="calendar-grid">

                        <% if (minhasConsultas !=null && !minhasConsultas.isEmpty()) { for (Consulta c :
                          minhasConsultas) { %>
                          <div class="day" id="consulta-<%= c.getIdConsulta() %>">
                            <div class="date-header">
                              <span class="date-day">
                                <%= c.getDataHora().format(diaFormat) %>
                              </span>
                              <span class="date-month">/ <%= c.getDataHora().getMonthValue() %></span>
                            </div>

                            <div class="consultas">
                              <div class="info-row">
                                <span class="info-time">
                                  <%= c.getDataHora().format(horaFormat) %>h
                                </span>
                                <span class="info-paciente">
                                  <%= c.getPaciente().getUsuario().getNome() %>
                                </span>
                                <span class="info-motivo">
                                  <%= c.getDescricao() !=null && !c.getDescricao().isEmpty() ? c.getDescricao()
                                    : "Consulta de Rotina" %>
                                </span>
                              </div>

                              <button class="btn-cancelar" onclick="cancelarConsulta(<%= c.getIdConsulta() %>)">
                                Cancelar
                              </button>
                            </div>
                          </div>
                          <% } } else { %>
                            <div class="empty-msg">
                              <h3>Sua agenda está livre</h3>
                              <p>Nenhuma consulta agendada para o próximo período.</p>
                            </div>
                            <% } %>

                      </div>
                    </div>
                  </section>

                  <footer>
                    <p>&copy; 2025 HealthConnect - Sistema de Gestão de Saúde</p>
                  </footer>

                  <script>
                    async function cancelarConsulta(idConsulta) {
                      if (!confirm("Tem certeza que deseja cancelar este atendimento? Esta ação não pode ser desfeita.")) {
                        return;
                      }

                      try {
                        const response = await fetch('cancelar-consulta', {
                          method: 'POST',
                          headers: { 'Content-Type': 'application/json' },
                          body: JSON.stringify({ idConsulta: idConsulta })
                        });

                        const result = await response.json();

                        if (response.ok) {
                          const card = document.getElementById("consulta-" + idConsulta);
                          if (card) {
                            card.style.transition = "all 0.5s ease";
                            card.style.opacity = "0";
                            card.style.transform = "scale(0.9)";
                            setTimeout(() => card.remove(), 500);
                          }
                          // Feedback visual sutil em vez de alert intrusivo pode ser implementado aqui futuramente
                          alert("Consulta cancelada com sucesso.");
                        } else {
                          alert("Erro: " + result.erro);
                        }
                      } catch (error) {
                        console.error(error);
                        alert("Erro de conexão com o servidor.");
                      }
                    }
                  </script>

                </body>

                </html>