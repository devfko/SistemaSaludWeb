using CapaAccesoDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaLogicaNegocio
{
    public class HorarioAtencionLN
    {
        #region "PATRON SINGLETON"
        private static HorarioAtencionLN objHorarioAtencion = null;
        private HorarioAtencionLN() { }
        public static HorarioAtencionLN getInstance()
        {
            if (objHorarioAtencion == null)
            {
                objHorarioAtencion = new CapaLogicaNegocio.HorarioAtencionLN();
            }
            return objHorarioAtencion;
        }
        #endregion

        public HorarioAtencion RegistrarHorarioAtencion(HorarioAtencion objHorarioAtencion)
        {
            try
            {
                return HorarioAtencionDAO.getInstance().RegistrarHorarioAtencion(objHorarioAtencion);
            }catch(Exception ex)
            {
                throw ex;
            }
        }
    }
}
