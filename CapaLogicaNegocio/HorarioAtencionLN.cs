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

        public List<HorarioAtencion> Listar(Int32 idMedico)
        {
            try
            {
                return HorarioAtencionDAO.getInstance().Listar(idMedico);
            }catch(Exception ex)
            {
                throw ex;
            }
        }

        public bool Eliminar(int idHorarioAtencion)
        {
            try
            {
                return HorarioAtencionDAO.getInstance().Eliminar(idHorarioAtencion);
            }catch(Exception ex)
            {
                throw ex;
            }
        }

        public bool Actualizar(HorarioAtencion objHorario)
        {
            try
            {
                return HorarioAtencionDAO.getInstance().Actualizar(objHorario);
            }catch(Exception ex)
            {
                throw ex;
            }
        }
    }
}
