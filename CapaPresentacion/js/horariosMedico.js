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
                resultadoMedico(data.d);
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
}