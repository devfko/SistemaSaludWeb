using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    //Hacemos herencia Medico de Empleado
    public class Medico : Empleado
    {
        public int idMedico { get; set; }
        public Especialidad Especialidad { get; set; }
        public bool EstadoMedico { get; set; }

        //La sintaxis :base hace herencia del metodo sin parametros de la clase Empleado (Herencia)
        public Medico() : base()
        {
        }

        public Medico(int idMedico, Especialidad Especialidad, bool estado)
            : base(0, new TipoEmpleado(), "", "", "", "", true, "", "", "")
        {
            this.idMedico = idMedico;
            this.Especialidad = Especialidad;
            this.EstadoMedico = estado;
        }

    }
}
