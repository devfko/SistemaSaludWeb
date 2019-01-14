using CapaAccesoDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaLogicaNegocio
{
    public class CitaLN
    {
        #region "PATRON SINGLETON"
        private static CitaLN objCita = null;
        private CitaLN() { }
        public static CitaLN getInstance()
        {
            if (objCita == null)
            {
                objCita = new CapaLogicaNegocio.CitaLN();
            }
            return objCita;
        }
        #endregion

        public bool RegistrarCita(Cita objCita)
        {
            try
            {
                return CitaDAO.getInstance().RegistrarCita(objCita);
            }catch(Exception ex)
            {
                throw ex;
            }
        }
    }
}
