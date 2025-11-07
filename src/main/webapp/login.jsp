<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 10px;
            width: 320px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #000000;
            font-weight: 400;
            font-size: 24px;
            text-align: center;
        }

        .login-container h2 span {
            color: #502c64;
            font-weight: bold;
        }

        .login-container h3 {
            font-weight: 400;
            font-size: large;
            text-align: center;
            margin-bottom: 20px;
        }

        .login-container label {
            font-weight: bold;
            font-size: small;
        }

        .login-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #a09e9e;
            border-radius: 5px;
            background-color: #ffffff;
            color: #000000;
        }

        .login-container button {
            width: 100%;
            padding: 10px;
            background-color: #4484b4;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }

        .login-container button:hover {
            background-color: #356699;
            transform: scale(0.98);
        }

        .btn-esqueci {
            margin-top: 5px;
            font-size: 0.9em;
            text-decoration: underline;
            color: #0662ec;
            display: block;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Bem-vindo à <span>UCPEL!</span></h2>
    <h3>Faça seu login</h3>
    <form id="loginForm" method="post">
        <label for="email">Email</label>
        <input type="email" id="email" placeholder="Digite seu e-mail" required />

        <label for="senha">Senha</label>
        <input type="password" id="senha" placeholder="Digite sua senha" required />

        <button type="submit">Entrar</button>
        <a href="#" class="btn-esqueci">Esqueci minha senha</a>
    </form>
</div>

<script>
    document.getElementById("loginForm").addEventListener("submit", async function(e) {
        e.preventDefault(); // previne submit padrão (GET)

        const email = document.getElementById("email").value;
        const senha = document.getElementById("senha").value;

        try {
            const res = await fetch("<%=request.getContextPath()%>/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ email, senha })
            });

            const data = await res.json();

            if (!res.ok) {
                alert(data.erro);
                return;
            }

            alert(`Bem-vindo, ${data.email}!`);
            // Se quiser redirecionar após login:
            // window.location.href = "<%=request.getContextPath()%>/home.jsp";

        } catch (err) {
            console.error(err);
            alert("Erro de conexão com o servidor");
        }
    });
</script>
</body>
</html>
