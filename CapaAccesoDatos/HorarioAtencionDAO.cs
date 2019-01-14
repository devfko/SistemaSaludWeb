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

        public bool Actualizar(HorarioAtencion objHorario)
        {
            MySqlConnection conexion = null;
            MySqlCommand cmd = null;
            bool respuesta = false;

            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPActualizarHorarioAtencion";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("prmIdHorario", objHorario.idHorarioAtencion);
                cmd.Parameters.AddWithValue("prmFecha", objHorario.Fecha);
                cmd.Parameters.AddWithValue("prmHora", objHorario.Hora.hora);
                conexion.Open();
                cmd.ExecuteNonQuery();
                respuesta = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conexion.Close();
            }
            return respuesta;
        }

        public bool Eliminar(int idHorarioAtencion)
        {
            MySqlConnection conexion = null;
            MySqlCommand cmd = null;
            bool respuesta = false;

            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPEliminarHorarioAtencion";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("prmIdHorarioAtencion", idHorarioAtencion);
                conexion.Open();
                cmd.ExecuteNonQuery();
                respuesta = true;

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

        public List<HorarioAtencion> Listar(Int32 idMedico)
        {
            //Declaramos la lista vacia
            List<HorarioAtencion> lista = new List<HorarioAtencion>();
            MySqlConnection conexion = null;
            MySqlCommand cmd = null;
            MySqlDataReader dr = null;

            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPConsultarHorarioAtencion";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("prmIdMedico", idMedico);
                conexion.Open();
                dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    HorarioAtencion objHorarioAtencion = new HorarioAtencion();
                    objHorarioAtencion.idHorarioAtencion = Convert.ToInt32(dr["idHorarioAtencion"].ToString());
                    objHorarioAtencion.Fecha = Convert.ToDateTime(dr["fecha"].ToString());
                    objHorarioAtencion.Hora = new Hora()
                    {
                        hora = dr["hora"].ToString()
                    };                    

                    lista.Add(objHorarioAtencion);
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

        public List<HorarioAtencion> ListarHorarioReservas(Int32 idEspecialidad, DateTime Fecha)
        {
            //Declaramos la lista vacia
            List<HorarioAtencion> lista = new List<HorarioAtencion>();
            MySqlConnection conexion = null;
            MySqlCommand cmd = null;
            MySqlDataReader dr = null;

            try
            {
                conexion = Conexion.getInstance().ConexionBD();
                cmd = conexion.CreateCommand();
                cmd.CommandText = "SPConsultarHorarioAtencionFecha";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("prmIdEspecialidad", idEspecialidad);
                cmd.Parameters.AddWithValue("prmFecha", Fecha);
                conexion.Open();
                dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    HorarioAtencion objHorarioAtencion = new HorarioAtencion();
                    Medico objMedico = new Medico();
                    Hora objHora = new Hora();

                    objHora.idHora = Convert.ToInt32(dr["idHora"].ToString());
                    objHora.hora = dr["hora"].ToString();
                    
                    objMedico.idMedico = Convert.ToInt32(dr["idMedico"].ToString());
                    objMedico.Nombre = dr["nombres"].ToString();

                    objHorarioAtencion.Hora = objHora;
                    objHorarioAtencion.Medico = objMedico;
                    objHorarioAtencion.idHorarioAtencion = Convert.ToInt32(dr["idHorarioAtencion"].ToString());
                    objHorarioAtencion.Fecha = Convert.ToDateTime(dr["fecha"].ToString());                    

                    lista.Add(objHorarioAtencion);
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
