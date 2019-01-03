var tabla, data;

//Agregar Registros a la Tabla
function addRowDT(data) {

    tabla = $("#tbl_pacientes").DataTable();
    tabla.fnClearTable();

    for (var i = 0; i < data.length; i++) {
        tabla.fnAddData([
            data[i].IdPaciente,
            data[i].Nombres,
            data[i].ApPaterno + " " + data[i].ApMaterno,
            ((data[i].Sexo == 'M') ? "Masculino" : "Femenino"),
            data[i].Edad,
            data[i].Direccion,
            '<button type="button" value="Modificar" title="Modificar" class="btn btn-primary btn-edit" data-target="#imodal" data-toggle="modal"><i class="fa fa-check-square"></i></button>' +
            '<button type="button"="Eliminar" title="Eliminar" class="btn btn-danger btn-delete" ><i class="fa fa-minus-square"></i></button>'
        ]);
    }

}

//((data[i].Estado == true) ? 'Activo' : 'Inactivo')

//Funcion de llenado de Listado de Pacientes
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

//Funcion de actualizar los Datos del Paciente
function updateDataAjax() {
    var obj = JSON.stringify({ id: JSON.stringify(data[0]), direccion: $("#txtModalDireccion").val() });
    $.ajax({
        type: "POST",
        url: "GestionarPaciente.aspx/ActualizarDatosPaciente",
        data: obj,
        dataType: "json",
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (response) {
            if (response.d) {
                alert("Registro Actualizado Correctamente");
            } else {
                alert("No Se Pudo Actualizar el Registro");
            }
            $("#imodal").modal("hide");
        }
    });
}

//Funcion de actualizar los Datos del Paciente
function deleteDataAjax(data) {
    var obj = JSON.stringify({ id: JSON.stringify(data) });
    $.ajax({
        type: "POST",
        url: "GestionarPaciente.aspx/EliminarDatosPaciente",
        data: obj,
        dataType: "json",
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (response) {
            if (response.d) {
                alert("Registro Eliminado Correctamente");
            } else {
                alert("No Se Pudo Eliminar el Registro");
            }
        }
    });
}


//Evento clic para boton Actualizar
$(document).on('click', '.btn-edit', function (e) {
    e.preventDefault(); //Previene que se realice un PostBack
    var row = $(this).parent().parent()[0];
    data = tabla.fnGetData(row);
    fillModalData();
});

//Evento click para boton Eliminar
$(document).on('click', '.btn-delete', function (e) {
    e.preventDefault(); //Previene que se realice un PostBack

    var row = $(this).parent().parent()[0];
    var dataRow = tabla.fnGetData(row);

    deleteDataAjax(dataRow[0]);
    
    sendDataAjax();
});

//Lleno los campos de la ventana modal con el registro seleccionado
function fillModalData() {
    $("#txtFullName").val(data[1] + " " + data[2]);
    $("#txtModalDireccion").val(data[5]);
}

//Enviamos la información al servidor
$("#btnActualizar").click(function (e) {
    e.preventDefault();
    updateDataAjax();
});

//Invocacion de la funcion de llenado de tabla, al cargar el documento
sendDataAjax();