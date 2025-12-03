<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - HealthConnect</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #4FA58F 0%, #2E8B57 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #2E8B57;
            margin-bottom: 10px;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
            font-size: 18px;
            font-weight: normal;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
            font-size: 14px;
        }

        .input-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e1e1e1;
            border-radius: 8px;
            font-size: 16px;
            transition: 0.3s;
        }

        .input-group input:focus {
            border-color: #4FA58F;
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #4FA58F;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #2E8B57;
        }

        .links {
            margin-top: 20px;
            font-size: 14px;
        }

        .links a {
            color: #4FA58F;
            text-decoration: none;
        }

        .links a:hover {
            text-decoration: underline;
        }

        /* Mensagem de erro (inicialmente oculta) */
        #msg-erro {
            display: none;
            background-color: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 14px;
            border: 1px solid #ef9a9a;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <div class="logo">HealthConnect</div>
        <h2>Acesse sua conta</h2>

        <div id="msg-erro"></div>

        <form onsubmit="fazerLogin(event)">
            <div class="input-group">
                <label for="email">E-mail</label>
                <input type="email" id="email" name="email" placeholder="seu@email.com" required>
            </div>

            <div class="input-group">
                <label for="senha">Senha</label>
                <input type="password" id="senha" name="senha" placeholder="Sua senha" required>
            </div>

            <button type="submit" id="btn-entrar">Entrar</button>
        </form>

        <div class="links">
            <p>Não tem conta? <a href="cadastro.jsp">Cadastre-se</a></p>
        </div>
    </div>

    <script>
        async function fazerLogin(event) {
            // 1. Impede que o formulário recarregue a página do jeito tradicional
            event.preventDefault();

            const email = document.getElementById("email").value;
            const senha = document.getElementById("senha").value;
            const btn = document.getElementById("btn-entrar");
            const msgErro = document.getElementById("msg-erro");

            // Limpa mensagens anteriores e desabilita botão
            msgErro.style.display = 'none';
            btn.disabled = true;
            btn.innerText = "Entrando...";

            try {
                // 2. Envia os dados para o Servlet via JSON
                const response = await fetch('login', { // O caminho 'login' deve bater com o @WebServlet("/login")
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ email: email, senha: senha })
                });

                const dados = await response.json();

                if (response.ok) {
                    // 3. SUCESSO: Redireciona para a URL que o Servlet mandou
                    // (pode ser paciente-main.jsp ou dashboard-profissional.jsp)
                    window.location.href = dados.redirectUrl;
                } else {
                    // 4. ERRO: Mostra mensagem na tela
                    msgErro.innerText = dados.erro || "Erro ao fazer login";
                    msgErro.style.display = 'block';
                    btn.disabled = false;
                    btn.innerText = "Entrar";
                }

            } catch (error) {
                console.error("Erro na requisição:", error);
                msgErro.innerText = "Erro de conexão com o servidor.";
                msgErro.style.display = 'block';
                btn.disabled = false;
                btn.innerText = "Entrar";
            }
        }
    </script>

</body>
</html>