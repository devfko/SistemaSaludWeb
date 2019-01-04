using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.SessionState;
using CapaEntidades;

namespace CapaPresentacion.Custom
{
    public class SessionManager
    {
        #region variables
        private HttpSessionState _currentSession;
        #endregion

        public SessionManager(HttpSessionState session)
        {
            this._currentSession = session;
        }

        #region metodos
        private HttpSessionState CurrentSession
        {
            get { return this._currentSession; }
        }

        public Empleado UserSessionObjeto
        {
            set { CurrentSession["UserSistemaWeb"] = value; }
            get { return (Empleado)CurrentSession["UserSistemaWeb"]; }
        }
        #endregion
    }
}
