//$("#datemask").inputmask("dd/mm/yyyy", { "placeholder": "dd/mm/yyyy" });
$("[data-mask]").inputmask();
$(".timepicker").timepicker({ showInputs: false, showMeridian: false, minuteStep: 30 });

$("#btnBuscar").on("click", function (e) {
    e.preventDefault();

    //Obtener los datos del texto de DNI
    var dni = $("#txtDNI").val();
    var obj = JSON.stringify({ dni: dni });

    if (dni.length > 0) {
        //Llamada a AJAX
        $.ajax({
            type: "POST",
            url: "GestionarHorarioMedico.aspx/BuscarMedico",
            data: obj,
            contentType: 'application/json; charset=utf-8',
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
            },
            success: function (data) {                
                console.log("Exitoso");
                console.log(data.d);
                if (data.d !== null) {
                    resultadoMedico(data.d);
                } else {
                    limpiarMedico();
                }
            }
        });
    } else {
        console.log("No ha ingresado el DNI");
    }
});

function resultadoMedico(obj) {
    $("#lblNombres").text(obj.Nombre);
    $("#lblApellidos").text(obj.ApPaterno.concat(" ".concat(obj.apMaterno)));
    $("#lblEspecialidad").text(obj.Especialidad.Descripcion);
    $("#txtIdMedico").val(obj.idMedico);
}

function limpiarMedico(obj) {
    $("#lblNombres").text("");
    $("#lblApellidos").text("");
    $("#lblEspecialidad").text("");
}

$("#btnAgregar").on("click", function (e) {
    e.preventDefault();

    var fecha, hora, idMedico;

    fecha = $("#txtFecha").val();
    hora = $("#txtHoraInicio").val();
    idMedico = $("#txtIdMedico").val();    

    if (fecha.length > 0 && hora.length > 0 && idMedico > 0) {
        var obj = JSON.stringify({ fecha: fecha, hora: hora, idMedico: idMedico });

        $.ajax({
            type: "POST",
            url: "GestionarHorarioMedico.aspx/AgregarHorario",
            data: obj,
            contentType: 'application/json; charset=utf-8',
            error: function (xhr, ajaxOptions, thrownError) {
                console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
            },
            success: function (data) {
                console.log("Exitoso", data);

                //Cerramos la ventana modal con JQuery
                $("#AgregarHorario").modal('toggle');
            }
        });
    } else {
        console.log("Ingrese los datos requeridos");
    }
});