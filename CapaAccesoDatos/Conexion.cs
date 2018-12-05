using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaAccesoDatos
{
    public class Conexion
    {
        #region "PATRON SINGLETON"
        private static Conexion conexion = null;
        private Conexion() { }
        public static Conexion getInstance()
        {
            if(conexion == null)
            {
                conexion = new Conexion();
            }
            return conexion;
        }
        #endregion

        public MySqlConnection ConexionBD()
        {
            MySqlConnectionStringBuilder builder = new MySqlConnectionStringBuilder();
            builder.Server = "localhost";
            builder.UserID = "root";
            builder.Password = "";
            builder.Database = "dbclinica_web";

            //SqlConnection conexion = new SqlConnection();
            //conexion.ConnectionString = "server=localhost;Database=dbclinica_web;user=root;password=;";
            MySqlConnection conexion = new MySqlConnection(builder.ToString());
            return conexion;            
        }
    }
}
