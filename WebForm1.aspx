<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Registro.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        #form1 {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }

        h1 {
            margin-top: 0;
        }

        label {
            display: block;
            margin-top: 10px;
        }

        input[type="text"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 5px;
        }

        input[type="radio"] {
            margin-top: 5px;
            margin-right: 5px;
        }

        select {
            width: 100%;
            padding: 5px;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .enviar-button {
            border: none;
            background-color: #04AA6D;
            color: white;
            padding: 14px 28px;
            font-size: 16px;
            cursor: pointer;
            display: inline-block;
            margin: 0 auto;
            transition: background-color 0.3s;
        }

        .enviar-button:hover {
            background-color: #038055;
        }

        .success {
            color: green;
        }
    </style>
    <script type="text/javascript">
        function limpiar_contenido() {
            var inputs = document.querySelectorAll("input[type='text'], input[type='email'], textarea");
            var radios = document.querySelectorAll("input[type='radio']");
            var select = document.getElementById("DropDownListCiudad");

            inputs.forEach(function (input) {
                input.value = "";
            });

            radios.forEach(function (radio) {
                radio.checked = false;
            });

            select.value = 0;

            return false;
        }

        function validar_letras(event) {
            var letras = event.keyCode || event.which;
            if ((letras < 65 || letras > 90) && (letras < 97 || letras > 122)) {
                event.preventDefault();
                alert("Error, solo se permiten letras.");
            }
        }

        function registro() {
            var nombres = document.getElementById("Text1").value;
            var apellidos = document.getElementById("Text2").value;
            var correo = document.getElementById("Text3").value;
            var RadioButtonM = document.getElementById("RadioButtonM").checked;
            var RadioButtonF = document.getElementById("RadioButtonF").checked;
            var DropDownListCiudad = document.getElementById("DropDownListCiudad").value;

            if (nombres === "") {
                alert("Completa el campo de nombres.");
                return false;
            }
            if (apellidos === "") {
                alert("Completa el campo de apellidos.");
                return false;
            }
            if (correo === "") {
                alert("Ingresa tu correo electrónico.");
                return false;
            }
            if (RadioButtonM === false && RadioButtonF === false) {
                alert("No has seleccionado tu sexo.");
                return false;
            }
            if (DropDownListCiudad === "0") {
                alert("Selecciona una ciudad.");
                return false;
            }

            var fecha = new Date();
            var dia = fecha.getDate();
            var mes = fecha.getMonth() + 1;
            var anio = fecha.getFullYear();
            var fechaActual = dia + "/" + mes + "/" + anio;
            alert("Formulario enviado el " + fechaActual);
        }

        function validar_correo() {
            var correo = document.getElementById("Text3").value;
            const direccion = /[a-zA-Z0-9,_-]+\@(unsa)\.(edu\.pe)/;
            var valido = direccion.test(correo);

            if (valido === false) {
                alert("Debes usar un correo de la UNSA.");
                return false;
            } else {
                registro();
            }

            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <h1>REGISTRO DE ALUMNOS:</h1>
        <div>
            <label>Nombres: </label>
            <asp:TextBox ID="Text1" runat="server" onkeypress="validar_letras(event);" required="true"></asp:TextBox>
        </div>
        <div>
            <label>Apellidos: </label>
            <asp:TextBox ID="Text2" runat="server" onkeypress="validar_letras(event);" required="true"></asp:TextBox>
        </div>
        <div>
            <label>Sexo: </label>
            <asp:RadioButton ID="RadioButtonM" runat="server" Text="Masculino" onclick="document.getElementById('RadioButtonF').checked = false;" />
            <asp:RadioButton ID="RadioButtonF" runat="server" Text="Femenino" onclick="document.getElementById('RadioButtonM').checked = false;" />
        </div>
        <div>
            <label>Correo: </label>
            <asp:TextBox ID="Text3" runat="server" type="email" required="true"></asp:TextBox>
        </div>
        <div>
            <label>Dirección: </label>
            <asp:TextBox ID="TextDireccion" runat="server" required="true"></asp:TextBox>
        </div>
        <div>
            <label>Ciudad: </label>
            <asp:DropDownList ID="DropDownListCiudad" runat="server">
                <asp:ListItem Text="Selecciona una ciudad" Value="0"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div>
            <label>Requerimientos: </label>
            <div>
                <asp:TextBox ID="TextRequerimientos" runat="server" TextMode="MultiLine" Rows="4" Columns="50"></asp:TextBox>
            </div>
        </div>
        <div class="button-container">
            <asp:Button ID="Button1" runat="server" Text="Limpiar" OnClientClick="return limpiar_contenido();" CssClass="enviar-button"/>
            <asp:Button ID="ButtonEnviar" runat="server" Text="Enviar" OnClientClick="var a = registro(); return a;" OnClick="ButtonEnviar_Click" CssClass="enviar-button" />
        </div>
        <hr />
        <h2>Datos Registrados:</h2>
        <asp:TextBox ID="TextBoxDatosRegistrados" runat="server" TextMode="MultiLine" Rows="10" Columns="50" ReadOnly="False"></asp:TextBox>        
    </form>
</body>
</html>