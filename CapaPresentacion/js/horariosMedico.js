//$("#datemask").inputmask("dd/mm/yyyy", { "placeholder": "dd/mm/yyyy" });
$("[data-mask]").inputmask();
$(".timepicker").timepicker({ showInputs: false, showMeridian: false, minuteStep: 30 });

var tabla;

function initDataTable() {
    tabla = $("#tbl_horarios").DataTable();

    tabla.fnSetColumnVis(2, false);
}

initDataTable();

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
                    listarHorarios(data.d.idMedico);
                } else {
                    limpiarMedico();
                    tabla.fnClearTable();
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
                console.log("Exitoso", data.d);
                //Cerramos la ventana modal con JQuery
                $("#AgregarHorario").modal('toggle');
                addRow(data.d);
            }
        });
    } else {
        console.log("Ingrese los datos requeridos");
    }
});

function addRow(obj) {
    var fecha = moment(obj.Fecha).format("DD/MM/YYYY");    
    tabla.fnAddData(
    [
        '<button type="button" value="Modificar" title="Modificar" class="btn btn-primary btn-edit" data-target="#imodal" data-toggle="modal"><i class="fa fa-check-square"></i></button>',
        '<button type="button" value="Eliminar" title="Eliminar" class="btn btn-danger btn-delete" ><i class="fa fa-minus-square"></i></button>',
        obj.idHorarioAtencion,
        fecha,
        obj.Hora.hora
    ]);
}

function listarHorarios(idMedico) {

    var obj = JSON.stringify({ idMedico: idMedico });
    tabla.fnClearTable();

    $.ajax({
        type: "POST",
        url: "GestionarHorarioMedico.aspx/ListarHorarioAtencion",
        data: obj,
        contentType: 'application/json; charset=utf-8',
        error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status + "\n" + xhr.responseText, "\n" + thrownError);
        },
        success: function (data) {
            console.log("Exitoso", data.d);

            for (var i = 0; i < data.d.length; i++) {
                addRow(data.d[i]);
            }            
        }
    });
}

$(document).on('click', '.btn-delete', function (e) {
    e.preventDefault(); //Previene que se realice un PostBack

    var row = $(this).parent().parent()[0];
    var dataRow = tabla.fnGetData(row);
    
    deleteDataAjax(dataRow[2]);
    listarHorarios($("#txtIdMedico").val());    
});

$(document).on('click', '.btn-edit', function (e) {
    e.preventDefault(); //Previene que se realice un PostBack

    var row = $(this).parent().parent()[0];
    var dataRow = tabla.fnGetData(row);
    
    llenarDatosHorario(dataRow);    
});

function llenarDatosHorario(data) {
    $("#txtIdHorario").val(data[2]);
    $("#txtEditarFecha").val(data[3]);
    $("#txtEditarHora").val(data[4]);    
}

$("#btnEditar").on("click", function (e) {
    e.preventDefault();

    var obj = JSON.stringify({
        idmedico: $("#txtIdMedico").val(),
        idhorario: $("#txtIdHorario").val(),
        fecha: $("#txtEditarFecha").val(),
        hora: $("#txtEditarHora").val()
    });

    $.ajax({
        type: "POST",
        url: "GestionarHorarioMedico.aspx/ActualizarHorarioAtencion",
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
            listarHorarios($("#txtIdMedico").val());
            $("#imodal").modal("hide");            
        }
    });
});

function deleteDataAjax(data) {
    var obj = JSON.stringify({ id: JSON.stringify(data) });
    $.ajax({
        type: "POST",
        url: "GestionarHorarioMedico.aspx/EliminarHorarioAtencion",
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
