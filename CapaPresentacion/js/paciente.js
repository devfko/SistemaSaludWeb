function addRowDT(data) {
    var tabla;
    $(document).ready(function () {
        tabla = $("#tbl_pacientes").DataTable();

        for (var i = 0; i < data.length; i++) {
            tabla.fnAddData([
                data[i].IdPaciente,
                data[i].Nombres,
                data[i].ApPaterno + " " + data[i].ApMaterno,
                ((data[i].Sexo == 'M') ? "Masculino" : "Femenino"),
                data[i].Edad,
                data[i].Direccion,
                '<button value="Modificar" class="btn btn-primary"><i class="fa fa-square"></i></button>'
            ]);
        }
    });
}

//((data[i].Estado == true) ? 'Activo' : 'Inactivo')

function sendDataAjax() {
    $.ajax({
        type: "POST",
        url: "GestionarPaciente.aspx/ListarPacientes",
        data: {},
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            console.log(data.d);
            addRowDT(data.d);
        }
    });
}


//Invocacion de la funcion de llenado de tabla, al cargar el documento
sendDataAjax();