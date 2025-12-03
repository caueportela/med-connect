<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.util.List" %>
    <%@ page import="dao.ProfissionalSaudeDAO" %>
      <%@ page import="model.ProfissionalSaude" %>
        <%@ page import="model.Usuario" %>

          <% Usuario usuarioLogado=(Usuario) session.getAttribute("usuarioLogado"); if (usuarioLogado==null) {
            response.sendRedirect("login.jsp"); return; } List<ProfissionalSaude> listaMedicos = null;
            try {
            ProfissionalSaudeDAO dao = new ProfissionalSaudeDAO();
            listaMedicos = dao.listarTodos();
            } catch (Exception e) {
            e.printStackTrace();
            }
            %>

            <!DOCTYPE html>
            <html lang="pt-BR">

            <head>
              <meta charset="UTF-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <title>Agendar com Médico - HealthConnect</title>
              <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                rel="stylesheet" />

              <style>
                /* --- CSS MODERNIZADO (HealthConnect Theme) --- */

                * {
                  margin: 0;
                  padding: 0;
                  box-sizing: border-box;
                  outline: none;
                }

                body {
                  font-family: 'Roboto', sans-serif;
                  background: #f4f6f8;
                  /* Fundo cinza claro padrão */
                  color: #333;
                  display: flex;
                  flex-direction: column;
                  min-height: 100vh;
                }

                /* HEADER - Padronizado (Fundo branco, texto verde/cinza) */
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

                /* Conteúdo Principal */
                .agendamento {
                  padding: 40px 20px;
                  flex: 1;
                  max-width: 1200px;
                  margin: 0 auto;
                  width: 100%;
                  text-align: center;
                }

                .agendamento h1 {
                  font-size: 28px;
                  color: #2c3e50;
                  margin-bottom: 40px;
                  font-weight: 700;
                }

                /* Grid de Cards */
                .profissionais {
                  display: grid;
                  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                  gap: 30px;
                }

                /* Card Estilizado */
                .card {
                  background: #fff;
                  border-radius: 12px;
                  padding: 25px;
                  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
                  border: 1px solid #eef0f2;
                  text-align: left;
                  display: flex;
                  flex-direction: column;
                  justify-content: space-between;
                  transition: transform 0.3s ease, box-shadow 0.3s ease;
                }

                .card:hover {
                  transform: translateY(-5px);
                  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
                  border-color: #4FA58F;
                }

                .card h2 {
                  font-size: 20px;
                  color: #2c3e50;
                  margin-bottom: 8px;
                  font-weight: 600;
                  display: flex;
                  align-items: center;
                }

                /* Pequeno detalhe visual antes do nome */
                .card h2::before {
                  content: '';
                  display: inline-block;
                  width: 4px;
                  height: 18px;
                  background-color: #4FA58F;
                  margin-right: 10px;
                  border-radius: 2px;
                }

                .card p {
                  font-size: 14px;
                  margin-bottom: 15px;
                  color: #7f8c8d;
                  line-height: 1.5;
                }

                .card strong {
                  color: #555;
                }

                /* Input Data Modernizado */
                .input-data {
                  width: 100%;
                  padding: 12px;
                  margin: 15px 0 20px 0;
                  border: 1px solid #e0e0e0;
                  border-radius: 8px;
                  background-color: #f9f9f9;
                  font-family: 'Roboto', sans-serif;
                  font-size: 14px;
                  color: #333;
                  transition: all 0.3s ease;
                }

                .input-data:focus {
                  border-color: #4FA58F;
                  background-color: #fff;
                  box-shadow: 0 0 0 3px rgba(79, 165, 143, 0.15);
                }

                /* Botão Primário */
                .btn {
                  display: block;
                  width: 100%;
                  text-align: center;
                  padding: 14px 0;
                  background: #4FA58F;
                  color: #fff;
                  border-radius: 8px;
                  text-decoration: none;
                  transition: all 0.2s ease;
                  border: none;
                  font-size: 15px;
                  font-weight: 600;
                  cursor: pointer;
                  box-shadow: 0 4px 6px rgba(79, 165, 143, 0.2);
                }

                .btn:hover {
                  background: #3e8e7a;
                  transform: translateY(-2px);
                  box-shadow: 0 6px 12px rgba(79, 165, 143, 0.3);
                }

                .btn:active {
                  transform: translateY(0);
                }

                /* Footer */
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
                  <a href="paciente-main.jsp">Minhas Consultas</a>
                  <a href="perfil.jsp">Perfil</a>
                  <a href="logout.jsp" style="color: #e74c3c;">Sair</a>
                </nav>
              </header>

              <section class="agendamento">
                <h1>Escolha um profissional e agende</h1>

                <div class="profissionais">

                  <% if (listaMedicos !=null && !listaMedicos.isEmpty()) { for (ProfissionalSaude p : listaMedicos) { %>

                    <div class="card">
                      <div>
                        <h2>Dr(a). <%= p.getUsuario().getNome() %>
                        </h2>
                        <p><strong>CRM:</strong>
                          <%= p.get