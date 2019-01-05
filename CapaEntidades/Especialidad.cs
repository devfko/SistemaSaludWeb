namespace CapaEntidades
{
    public class Especialidad
    {
        public int idEspecialidad { get; set; }
        public string Descripcion { get; set; }
        public bool Estado { get; set; }

        public Especialidad() { }

        public Especialidad(int idEspecialidad, string descripcion, bool estado)
        {
            this.idEspecialidad = idEspecialidad;
            this.Descripcion = descripcion;
            this.Estado = estado;
        }
    }
}