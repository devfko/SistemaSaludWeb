<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="GestionarHorarioMedico.aspx.cs" Inherits="CapaPresentacion.GestionarHorarioMedico" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/timepicker/bootstrap-timepicker.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1 style="text-align: center">GESTIÓN DE HORARIOS MÉDICOS</h1>
    </section>
    <section class="content">
        <!-- FORMULARIO REGISTRO -->
        <div class="row">
            <div class="col-md-3">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title">Datos del Médico</h3>
                    </div>
                    <div class="box-body">
                        <label>Nro Documento Identidad</label>
                        <div class="input-group input-group-sm">
                            <asp:TextBox ID="txtDNI" CssClass="form-control" runat="server" placeholder="Digite el DNI a Buscar"></asp:TextBox>
                            <span class="input-group-btn">
                                <asp:Button ID="btnBuscar" CssClass="btn btn-info btn-flat" runat="server" Text="Buscar" />
                            </span>
                        </div>
                    </div>
                    <div class="box-footer">
                        <asp:HiddenField id="txtIdMedico" runat="server" />
                        <asp:HiddenField id="txtIdHorario" runat="server" />
                        <div class="row form-group">
                            <div class="col-md-5">
                                <strong>Nombres:</strong>
                            </div>
                            <div class="col-md-5">
                                <asp:Label ID="lblNombres" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-md-5">
                                <strong>Apellidos:</strong>
                            </div>
                            <div class="col-md-5">
                                <asp:Label ID="lblApellidos" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-md-5">
                                <strong>Especialidad:</strong>
                            </div>
                            <div class="col-md-5">
                                <asp:Label ID="lblEspecialidad" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title">Horario de Atención</h3>
                    </div>
                    <div class="box-body table table-responsive">
                        <table id="tbl_horarios" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th></th><!--CONTENEDOR DEL ID DEL HORARIO DE ATENCION -->
                                    <th>FECHA DE ATENCIÓN</th>
                                    <th>HORA DE ATENCIÓN</th>
                                </tr>
                            </thead>
                            <tbody id="tbl_body_table">                                
                                <!-- DATA POR MEDIO DE AJAX -->
                            </tbody>
                        </table>
                    </div>
                    <div class="box-footer" style="text-align: center;">
                        <%--<asp:Button ID="btnAgregarHorario" runat="server" CssClass="btn btn-primary" Text="Agregar Horario" />--%>
                        <asp:LinkButton ID="btnAgregarHorario" runat="server" CssClass="btn btn-primary" href="#AgregarHorario"
                            data-toggle="modal">Agregar Horario</asp:LinkButton>
                        <asp:Button ID="btnGuardarHorario" runat="server" CssClass="btn btn-success" Text="Guardar Horario" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="modal fade" id="AgregarHorario" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                    <h3 class="modal-title">
                        <i class="fa fa-clock-o"></i>
                        Agregar Horario
                    </h3>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Fecha:</label>
                        <div class="input-group">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <asp:TextBox ID="txtFecha" CssClass="form-control" data-inputmask="'alias': 'dd/mm/yyyy'"
                                data-mask="" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="bootstrap-timepicker">
                        <div class="form-group">
                            <label>Hora Inicio:</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtHoraInicio" CssClass="form-control timepicker" runat="server"></asp:TextBox>
                                <div class="input-group-addon">
                                    <i class="fa fa-clock-o"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer clearfix">
                    <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-primary" Text="Agregar" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="imodal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                    <h3 class="modal-title">
                        <i class="fa fa-clock-o"></i>
                        Editar Horario
                    </h3>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Fecha:</label>
                        <div class="input-group">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <asp:TextBox ID="txtEditarFecha" CssClass="form-control" data-inputmask="'alias': 'dd/mm/yyyy'"
                                data-mask="" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="bootstrap-timepicker">
                        <div class="form-group">
                            <label>Hora Inicio:</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtEditarHora" CssClass="form-control timepicker" runat="server"></asp:TextBox>
                                <div class="input-group-addon">
                                    <i class="fa fa-clock-o"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer clearfix">
                    <asp:Button ID="btnEditar" runat="server" CssClass="btn btn-primary" Text="Editar" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src="js/plugins/input-mask/jquery.inputmask.js"></script>
    <script src="js/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="js/plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <script src="js/plugins/timepicker/bootstrap-timepicker.min.js"></script>
    <script src="js/plugins/moments/moment.min.js" ></script>
    <script src="js/horariosMedico.js"></script>
</asp:Content>
