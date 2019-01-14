$("[data-mask]").inputmask();

$("#btnBuscar").on("click", function (e) {
    e.preventDefault();

    var dni = $("#txtDNI").val();

    if (dni.length > 0) {
        BuscarPacienteDNI(dni);
    } else {
        console.log("Digite el DNI a Buscar");
    }
    
});

function BuscarPacienteDNI(dni) {

    var obj = JSON.stringify({ dni: dni });
    limpiarDatosPaciente();
    $.ajax({
        type: "POST",
        url: "GestionarReservaCitas.aspx/BuscarPacienteDNI",
        data: obj,
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            if (data.d == null) {
                alert('No Existe el Paciente con el DNI ' + dni);                
            } else {
                llenarDatosPaciente(data.d);                
            }                     
        }
    });
}

function llenarDatosPaciente(data){
    $("#txtNombres").val(data.Nombres);
    $("#txtApellidos").val(data.ApPaterno + " " + data.ApMaterno);
    $("#txtTelefono").val(data.Telefono);
    $("#txtEdad").val(data.Edad);
    $("#txtSexo").val((data.Sexo == 'M') ? 'Masculino' : 'Femenino');
    $("#txtIdPaciente").val(data.IdPaciente);    
}

function limpiarDatosPaciente() {
    $("#txtNombres").val("");
    $("#txtApellidos").val("");
    $("#txtTelefono").val("");
    $("#txtEdad").val("");
    $("#txtSexo").val("");
    $("#txtIdPaciente").val("0");
}