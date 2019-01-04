using CapaPresentacion.Custom;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class PanelGeneral : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserSistemaWeb"] != null)
            //if (SessionManager.UserSessionObjeto != null)
            {
                Response.Write("<script>alert('Bienvenido'" + Session["UserSistemaWeb"].ToString() + ")</script>");
            }
            else
            {
                Response.Redirect("~/login.aspx");
            }
        }
    }
}