using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidades;
using CapaAccesoDatos;

namespace CapaLogicaNegocio
{
    public class PacienteLN
    {
        #region "PATRON SINGLETON"
        private static PacienteLN objEmpleado = null;
        private PacienteLN() { }
        public static PacienteLN getInstance()
        {
            if (objEmpleado == null)
            {
                objEmpleado = new CapaLogicaNegocio.PacienteLN();
            }
            return objEmpleado;
        }
        #endregion

        public bool RegistrarPaciente(Paciente objPaciente)
        {
            try
            {
                return PacienteDAO.getInstance().RegistrarPaciente(objPaciente);
            }
            catch(Exception ex)
            {
                throw ex;
            }
            
        }

        public Paciente BuscarPacienteDNI(string dni)
        {
            try
            {
                return PacienteDAO.getInstance().BuscarPacienteDNI(dni);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<Paciente> listarPacientes()
        {
            try
            {
                return PacienteDAO.getInstance().ListarPacientes();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public bool ActualizarDatoPaciente(Paciente objPaciente)
        {
            try
            {
                return PacienteDAO.getInstance().ActualizarPaciente(objPaciente);
            }catch(Exception ex)
            {
                throw ex;
            }
        }

        public bool EliminarDatosPaciente(Paciente objPaciente)
        {
            try
            {
                return PacienteDAO.getInstance().EliminarPaciente(objPaciente);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
