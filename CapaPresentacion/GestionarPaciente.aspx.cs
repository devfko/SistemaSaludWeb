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
    public partial class frmGestionarPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
            }
        }

        [WebMethod]
        public static List<Paciente> ListarPacientes()
        {
            List<Paciente> Lista = null;
            try
            {
                Lista = PacienteLN.getInstance().listarPacientes();
            }catch(Exception ex)
            {
                Lista = null;
            }

            return Lista;
        }

        [WebMethod]
        public static bool ActualizarDatosPaciente(String id, String direccion)
        {
            Paciente objPaciente = new Paciente()
            {
                IdPaciente = Convert.ToInt32(id),
                Direccion = direccion
            };

            bool respuesta = PacienteLN.getInstance().ActualizarDatoPaciente(objPaciente);

            return respuesta;
        }

        [WebMethod]
        public static bool EliminarDatosPaciente(String id)
        {
            Paciente objPaciente = new Paciente()
            {
                IdPaciente = Convert.ToInt32(id)
            };

            bool respuesta = PacienteLN.getInstance().EliminarDatosPaciente(objPaciente);

            return respuesta;
        }

        private Paciente GetEntity()
        {
            Paciente objPaciente = new Paciente();
            objPaciente.IdPaciente = 0;
            objPaciente.Nombres = txtNombres.Text;
            objPaciente.ApPaterno = txtApellidoUno.Text;
            objPaciente.ApMaterno = txtApellidoDos.Text;
            objPaciente.Edad = Convert.ToInt32(txtEdad.Text);
            objPaciente.Sexo = (cmbSexo.SelectedValue == "Femenino") ? 'F' : 'M'; //Masculio - Femenino
            objPaciente.NroDocumento = txtNroDocumento.Text;
            objPaciente.Telefono = txtTelefono.Text;
            objPaciente.Direccion = txtDireccion.Text;
            objPaciente.Estado = true;

            return objPaciente;
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            //Registro del Paciente
            Paciente objPaciente = GetEntity();
            //Enviamos a la CapaLogicaNegocio
            bool respuesta = PacienteLN.getInstance().RegistrarPaciente(objPaciente);
            if (respuesta == true)
            {
                Response.Write("<script>alert('REGISTRO CORRECTO')</script>");
            }
            else
            {
                Response.Write("<script>alert('REGISTRO INCORRECTO')</script>");
            }
        }
    }
}