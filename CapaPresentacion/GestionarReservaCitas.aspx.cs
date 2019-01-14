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
    public partial class GestionarReservaCitas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserSistemaWeb"] == null)
            {
                Response.Redirect("~/login.aspx");
            } else
            {
                if (!IsPostBack)
                {
                    LlenarEspecialidad();
                }
            }
        }

        private void LlenarGridViewHorariosAtencion()
        {
            if (txtFechaAtencion.Text.Equals(string.Empty))
            {
                Response.Write("<script>alert('Ingrese una Fecha Valida')</script>");
                return; //No Hacer Nada
            }

            Int32 idEspecialidad= Convert.ToInt32(ddlEspecialidad.SelectedValue);
            DateTime fechaBusqueda = Convert.ToDateTime(txtFechaAtencion.Text);
            
            List<HorarioAtencion> Lista = HorarioAtencionLN.getInstance().ListarHorarioReservas(idEspecialidad, fechaBusqueda);
            grdHorariosAtencion.DataSource = Lista;
            grdHorariosAtencion.DataBind();
        }

        private void LlenarEspecialidad()
        {
            List<Especialidad> Lista = EspecialidadLN.getInstance().ListarEspecialidades();
            ddlEspecialidad.DataSource = Lista;
            ddlEspecialidad.DataValueField = "idEspecialidad"; //ID DEL REGISTRO
            ddlEspecialidad.DataTextField = "Descripcion"; //TEXTO DEL REGISTRO
            ddlEspecialidad.DataBind();
        }

        [WebMethod]
        public static Paciente BuscarPacienteDNI(String dni)
        {
            return PacienteLN.getInstance().BuscarPacienteDNI(dni);
        }

        protected void btnBuscarHorario_Click(object sender, EventArgs e)
        {
            LlenarGridViewHorariosAtencion();
        }

        protected void btnReservarCita_Click(object sender, EventArgs e)
        {
            bool registroSeleccionado = HorarioAtencionSeleccionado();

            if (!txtIdPaciente.Value.Equals(string.Empty) && registroSeleccionado)
            {
                try
                {
                    Cita objCita = ObtenerCitaSeleccionada();
                    bool response = CitaLN.getInstance().RegistrarCita(objCita);
                    String msj = "";
                    if (response)
                    {
                        msj = "<script>alert('Cita Registrada Correctamente'</script>";
                        
                    }else
                    {
                        msj = "<script>alert('Error al Registrar Cita'</script>";
                    }
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Mensaje Cita",
                            msj, false);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }            
        }

        private bool HorarioAtencionSeleccionado()
        {
            foreach(GridViewRow row in grdHorariosAtencion.Rows)
            {
                CheckBox chkHorario = (row.FindControl("chkSeleccionar") as CheckBox);

                if (chkHorario.Checked)
                {
                    return true;
                }
            }
            return false;
        }

        private Cita ObtenerCitaSeleccionada()
        {
            Cita objCita = new Cita();

            foreach (GridViewRow row in grdHorariosAtencion.Rows)
            {
                CheckBox chkHorario = (row.FindControl("chkSeleccionar") as CheckBox);

                if (chkHorario.Checked)
                {
                    objCita.Hora = (row.FindControl("lblHora") as Label).Text;
                    objCita.FechaReserva = DateTime.Now;
                    objCita.paciente.IdPaciente = Convert.ToInt32(txtIdPaciente.Value);
                    objCita.medico.idMedico = Convert.ToInt32((row.FindControl("txtIdMedico") as HiddenField).Value);
                    break;
                }
            }
            return objCita;
        }
    }
}