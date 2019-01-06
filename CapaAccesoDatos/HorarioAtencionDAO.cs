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
    public class HorarioAtencionDAO
    {
        #region "PATRON SINGLETON"
        private static HorarioAtencionDAO daoHorarioAtencion = null;
        private HorarioAtencionDAO() { }
        public static HorarioAtencionDAO getInstance()
        {
            if (daoHorarioAtencion == null)
            {
                daoHorarioAtencion = new HorarioAtencionDAO();
            }
            return daoHorarioAtencion;
        }
        #endregion

        public HorarioAtencion RegistrarHorarioAtencion(HorarioAtencion objHorarioAtencion)
        {
            MySqlConnection conexion = null;
            MySqlCommand cmd = null;
            MySqlDataReader dr = null;
            HorarioAtencion objHorario = null;
            bool respuesta = false;
            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPRegistrarHorarioAtencion";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("prmIdMedico", objHorarioAtencion.Medico.idMedico);
                cmd.Parameters.AddWithValue("prmHora", objHorarioAtencion.Hora.hora);
                cmd.Parameters.AddWithValue("prmFecha", objHorarioAtencion.Fecha);
                conexion.Open();
                dr = cmd.ExecuteReader();
                
                if (dr.Read())
                {
                    objHorario = new HorarioAtencion()
                    {
                        idHorarioAtencion = Convert.ToInt32(dr["idHorarioAtencion"].ToString()),
                        Fecha = Convert.ToDateTime(dr["fecha"].ToString()),
                        Hora = new Hora()
                        {
                            idHora = Convert.ToInt32(dr["idHora"].ToString()),
                            hora = dr["hora"].ToString()
                        },
                        Estado = Convert.ToBoolean(Convert.ToInt32(dr["estado"].ToString()))
                    };
                }
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
            return objHorario;
        }
    }
}
