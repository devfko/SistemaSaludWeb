using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidades
{
    public class Cita
    {
        public int idCita { get; set; }
        public Medico medico { get; set; }
        public Paciente paciente { get; set; }
        public DateTime FechaReserva { get; set; }
        public String Observacion { get; set; }
        public char EstadoCita { get; set; }
        public String Hora { get; set; }

        public Cita()
        {
            this.paciente = new Paciente();
            this.medico = new Medico();
        }
    }
}
