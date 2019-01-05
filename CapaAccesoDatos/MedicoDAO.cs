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
    public class MedicoDAO
    {
        #region "PATRON SINGLETON"
        private static MedicoDAO daoMedico = null;
        private MedicoDAO() { }
        public static MedicoDAO getInstance()
        {
            if (daoMedico == null)
            {
                daoMedico = new MedicoDAO();
            }
            return daoMedico;
        }
        #endregion

        public Medico BuscarMedico(String dni)
        {
            Medico objMedico = null;
            MySqlConnection conexion = null;
            MySqlCommand cmd = null;
            MySqlDataReader dr = null;
            bool respuesta = false;
            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPBuscarMedico";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("prmDni", dni);
                conexion.Open();
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    //Creamos el objeto Medico
                    objMedico = new Medico()
                    {
                        idMedico = Convert.ToInt32(dr["idMedico"].ToString()),
                        ID = Convert.ToInt32(dr["idEmpleado"].ToString()),
                        Nombre = dr["Nombres"].ToString(),
                        ApPaterno = dr["ApPaterno"].ToString(),
                        apMaterno = dr["apMaterno"].ToString(),
                        Especialidad = new Especialidad()
                        {
                            idEspecialidad = Convert.ToInt32(dr["idEspecialidad"].ToString()),
                            Descripcion=dr["descripcion"].ToString()
                        },
                        Estado= Convert.ToBoolean(Convert.ToInt32(dr["estadoMedico"].ToString()))
                    };

                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {
                conexion.Close();
            }
            return objMedico;
        }
    }
}
