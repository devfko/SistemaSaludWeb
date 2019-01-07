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

        [WebMethod]
        public static HorarioAtencion AgregarHorario(String fecha, String hora, String idMedico)
        {
            HorarioAtencion objHorarioAtencion = new HorarioAtencion()
            {
                Fecha = Convert.ToDateTime(fecha),
                Hora = new Hora()
                {
                    hora = hora
                },
                Medico = new Medico()
                {
                    idMedico = Convert.ToInt32(idMedico)
                }
            };

            return HorarioAtencionLN.getInstance().RegistrarHorarioAtencion(objHorarioAtencion);
        }

        [WebMethod]
        public static List<HorarioAtencion> ListarHorarioAtencion(String idMedico)
        {
            return HorarioAtencionLN.getInstance().Listar(Convert.ToInt32(idMedico));
        }

        [WebMethod]
        public static bool EliminarHorarioAtencion(String id)
        {
            return HorarioAtencionLN.getInstance().Eliminar(Convert.ToInt32(id));
        }

        [WebMethod]
        public static bool ActualizarHorarioAtencion(String idmedico, String idhorario, String fecha, String hora)
        {
            Int32 idMedico = Convert.ToInt32(idmedico);
            Int32 idHorario = Convert.ToInt32(idhorario);

            HorarioAtencion objHorario = new HorarioAtencion()
            {
                idHorarioAtencion = idHorario,
                Medico = new Medico()
                {
                    idMedico = idMedico
                },
                Fecha = Convert.ToDateTime(fecha),
                Hora = new Hora()
                {
                    hora= hora
                }
            };

            return HorarioAtencionLN.getInstance().Actualizar(objHorario);
        }
    }
}
