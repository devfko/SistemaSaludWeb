using CapaEntidades;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAccesoDatos
{
    public class CitaDAO
    {
        #region "PATRON SINGLETON"
        private static CitaDAO daoCita = null;
        private CitaDAO() { }
        public static CitaDAO getInstance()
        {
            if (daoCita == null)
            {
                daoCita = new CitaDAO();
            }
            return daoCita;
        }
        #endregion

        public bool RegistrarCita(Cita objCita)
        {
            MySqlConnection conexion = null;
            MySqlCommand cmd = null;
            bool respuesta = false;
            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPRegistrarCita";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("prmIdMedico", objCita.medico.idMedico);
                cmd.Parameters.AddWithValue("prmIdPaciente", objCita.paciente.IdPaciente);
                cmd.Parameters.AddWithValue("prmFechaReserva", objCita.FechaReserva);
                cmd.Parameters.AddWithValue("prmHora", objCita.Hora);
                conexion.Open();
                int filas = cmd.ExecuteNonQuery();
                if (filas > 0) respuesta = true;
            }
            catch (Exception ex)
            {
                respuesta = false;
                throw ex;
            }
            finally
            {
                conexion.Close();
            }

            return respuesta;
        }
    }
}
