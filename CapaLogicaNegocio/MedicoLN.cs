using CapaAccesoDatos;
using CapaEntidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaLogicaNegocio
{
    public class MedicoLN
    {
        #region "PATRON SINGLETON"
        private static MedicoLN objMedico = null;
        private MedicoLN() { }
        public static MedicoLN getInstance()
        {
            if (objMedico == null)
            {
                objMedico = new CapaLogicaNegocio.MedicoLN();
            }
            return objMedico;
        }
        #endregion

        public Medico BuscarMedidco(String dni)
        {
            try
            {
                return MedicoDAO.getInstance().BuscarMedico(dni);
            }catch(Exception ex)
            {
                throw ex;
            }
        }
    }
}
