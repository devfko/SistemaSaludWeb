using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CapaEntidades;
using System.Data.SqlClient;
using System.Data;
using MySql.Data.MySqlClient;

namespace CapaAccesoDatos
{
    public class PacienteDAO
    {
        #region "PATRON SINGLETON"
        private static PacienteDAO daoPaciente = null;
        private PacienteDAO() { }
        public static PacienteDAO getInstance()
        {
            if (daoPaciente == null)
            {
                daoPaciente = new PacienteDAO();
            }
            return daoPaciente;
        }
        #endregion

        public bool RegistrarPaciente(Paciente objPaciente)
        {            
            MySqlConnection conexion = null;            
            MySqlCommand cmd = null;
            bool respuesta = false;
            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPRegistrarPaciente";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("prmNombres", objPaciente.Nombres);
                cmd.Parameters.AddWithValue("prmApellidoUno", objPaciente.ApPaterno);
                cmd.Parameters.AddWithValue("prmApellidoDos", objPaciente.ApMaterno);
                cmd.Parameters.AddWithValue("prmEdad", objPaciente.Edad);
                cmd.Parameters.AddWithValue("prmSexo", objPaciente.Sexo);
                cmd.Parameters.AddWithValue("prmNroDocumento", objPaciente.NroDocumento);
                cmd.Parameters.AddWithValue("prmDireccion", objPaciente.Direccion);
                cmd.Parameters.AddWithValue("prmTelefono", objPaciente.Telefono);
                cmd.Parameters.AddWithValue("prmEstado", objPaciente.Estado);
                conexion.Open();
                int filas = cmd.ExecuteNonQuery();
                if (filas > 0) respuesta = true;
            }
            catch(Exception ex)
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

        public List<Paciente> ListarPacientes()
        {
            //Declaramos la lista vacia
            List<Paciente> lista = new List<Paciente>();
            MySqlConnection conexion = null;
            MySqlCommand cmd = null;
            MySqlDataReader dr = null;

            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPConsultarPacientes";
                cmd.CommandType = CommandType.StoredProcedure;
                conexion.Open();
                dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    Paciente objPaciente = new Paciente();
                    objPaciente.IdPaciente = Convert.ToInt32(dr["idPaciente"].ToString());
                    objPaciente.Nombres = dr["nombres"].ToString();
                    objPaciente.ApPaterno = dr["apPaterno"].ToString();
                    objPaciente.ApMaterno = dr["apMaterno"].ToString();
                    objPaciente.Edad = Convert.ToInt32(dr["edad"].ToString());
                    objPaciente.Sexo = Convert.ToChar(dr["sexo"].ToString());
                    objPaciente.NroDocumento = dr["nroDocumento"].ToString();
                    objPaciente.Direccion = dr["direccion"].ToString();
                    objPaciente.Estado = true;

                    lista.Add(objPaciente);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conexion.Close();
            }
            return lista;
        }
    }
}
