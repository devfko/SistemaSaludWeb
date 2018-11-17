using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string pwduser = txtPassword.Text;
            string nombre = "devfko";
            string pass = "12345";

            if(username.Equals(nombre) && pwduser.Equals(pass))
            {
                Response.Write("<script>alert('Login Correcto');</script>");
            }else
            {
                Response.Write("<script>alert('Login Incorrecto');</script>");
            }
        }
    }
}