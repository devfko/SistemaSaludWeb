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
    public class EspecialidadDAO
    {
        #region "PATRON SINGLETON"
        private static EspecialidadDAO daoEspecialidad = null;
        private EspecialidadDAO() { }
        public static EspecialidadDAO getInstance()
        {
            if (daoEspecialidad == null)
            {
                daoEspecialidad = new EspecialidadDAO();
            }
            return daoEspecialidad;
        }
        #endregion

        public List<Especialidad> ListarEspecialidades()
        {
            //Declaramos la lista vacia
            List<Especialidad> lista = new List<Especialidad>();
            MySqlConnection conexion = null;
            MySqlCommand cmd = null;
            MySqlDataReader dr = null;

            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPConsultarEspecialidades";
                cmd.CommandType = CommandType.StoredProcedure;
                conexion.Open();
                dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    Especialidad objEspecialidad = new Especialidad();
                    objEspecialidad.idEspecialidad = Convert.ToInt32(dr["idEspecialidad"].ToString());
                    objEspecialidad.Descripcion = dr["descripcion"].ToString();
                    objEspecialidad.Estado = true;

                    lista.Add(objEspecialidad);
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
