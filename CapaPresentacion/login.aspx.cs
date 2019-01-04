using CapaEntidades;
using CapaLogicaNegocio;
using CapaPresentacion.Custom;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //Session["UserSistemaWeb"] = null;
            }
        }

        //protected void LoginUser_Authenticate(object sender, AuthenticateEventArgs e)
        //{
        //    bool auth = Membership.ValidateUser(LoginUser.UserName, LoginUser.Password);

        //    if (auth)
        //    {
        //        Empleado objEmpleado = EmpleadoLN.getInstance().AccesoSistema(LoginUser.UserName, LoginUser.Password);

        //        if (objEmpleado != null)
        //        {
        //            SessionManager = new SessionManager(Session);
        //            SessionManager.UserSessionObjeto = objEmpleado;

        //            FormsAuthentication.RedirectFromLoginPage(LoginUser.UserName, false);
        //            //Response.Write("<script>alert('USUARIO CORRECTO')</script>");
        //            //Response.Redirect("PanelGeneral.aspx");
        //        }
        //        else
        //        {
        //            Response.Write("<script>alert('USUARIO INCORRECTO')</script>");
        //        }
        //    }            
        //}

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            Empleado objEmpleado = EmpleadoLN.getInstance().AccesoSistema(txtUsername.Text, txtPassword.Text);

            if (objEmpleado != null)
            {
                //SessionManager = new SessionManager(Session);
                //SessionManager.UserSessionObjeto = objEmpleado;
                Session["UserSistemaWeb"] = objEmpleado.Usuario.ToString();
                Response.Redirect("~/PanelGeneral.aspx");
            }
            else
            {
                lblMensajeError.Text = "Usuario y/o Contraseña Incorrecto";
            }
        }
    }
}