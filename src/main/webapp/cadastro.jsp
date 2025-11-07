<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Cadastro</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #4484b4;
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
            width: 300px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2, h3 {
            margin-bottom: 20px;
            text-align: center;
        }

        h2 span {
            color: #502c64;
            font-weight: bold;
        }

        input, select, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #a09e9e;
            border-radius: 5px;
        }

        button {
            background-color: #4484b4;
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            transform: scale(0.98);
        }

        #registroDiv {
            display: none;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Cadastro no <span>med connect</span></h2>
    <h3>Preencha os dados</h3>

    <form id="cadastroForm">
        <input type="text" id="nome" placeholder="Nome" required />
        <input type="email" id="email" placeholder="Email" required />
        <input type="password" id="senha" placeholder="Senha" required />

        <select id="tipo" required>
            <option value="">Selecione o tipo</option>
            <option value="paciente">Paciente</option>
            <option value="profissional">Profissional da Saúde</option>
        </select>

        <div id="registroDiv">
            <input type="text" id="registro" placeholder="Registro Profissional" />
        </div>

        <button type="submit">Cadastrar</button>
    </form>

    <p style="text-align:center;">Já tem conta? <a href="login.jsp">Login</a></p>
</div>

<script>
    const tipoSelect = document.getElementById("tipo");
    const registroDiv = document.getElementById("registroDiv");

    tipoSelect.addEventListener("change", () => {
        registroDiv.style.display = tipoSelect.value === "profissional" ? "block" : "none";
    });

    const form = document.getElementById("cadastroForm");
    form.addEventListener("submit", async (e) => {
        e.preventDefault();

        const data = {
            nome: document.getElementById("nome").value,
            email: document.getElementById("email").value,
            senha: document.getElementById("senha").value,
            tipo: document.getElementById("tipo").value,
            registro: document.getElementById("registro").value
        };

        const res = await fetch("cadastro", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(data)
        });

        const result = await res.json();
        if (res.ok) {
            alert(result.mensagem);
            window.location.href = "login.jsp";
        } else {
            alert(result.erro);
        }
    });
</script>
</body>
</html>
