using CapaEntidades;
using CapaLogicaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class GestionarHorarioMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserSistemaWeb"] == null)
            {
                Response.Redirect("~/login.aspx");
            }
        }

        [WebMethod]
        public static Medico BuscarMedico(String dni)
        {
            return MedicoLN.getInstance().BuscarMedidco(dni);
        }
    }
}