<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="CapaPresentacion.login" %>

<!DOCTYPE html>

<html class="bg-black" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Acceso Sistema</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" type="text/css" />
    <link href="css/AdminLTE.css" type="text/css" rel="stylesheet" />
</head>
<body class="bg-black">
    <div class="form-box" id="login-box">
        <form id="form1" runat="server">
            <asp:Login ID="LoginUser" runat="server" EnableViewState="false" OnAuthenticate="LoginUser_Authenticate" Width="100%">
                <LayoutTemplate>
                    <div class="header">Iniciar Sesión</div>
                    <div class="body bg-gray">
                        <div class="form-group">
                            <asp:TextBox ID="UserName" runat="server" CssClass="form-control" placeholder="Digite el usuario"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="Password" runat="server" CssClass="form-control" TextMode="Password" placeholder="Digite el password"></asp:TextBox>
                        </div>
                    </div>

                    <div class="footer">
                        <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" CssClass="btn bg-blue-gradient btn-block" />
                    </div>
                </LayoutTemplate>
            </asp:Login>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
