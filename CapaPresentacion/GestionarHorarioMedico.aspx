<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="GestionarHorarioMedico.aspx.cs" Inherits="CapaPresentacion.GestionarHorarioMedico" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                        <table id="tbl_pacientes" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th>FECHA DE ATENCIÓN</th>
                                    <th>HORA DE ATENCIÓN</th>
                                    <th>ESTADO</th>
                                </tr>
                            </thead>
                            <tbody id="tbl_body_table">
                                <!-- DATA POR MEDIO DE AJAX -->
                            </tbody>
                        </table>
                    </div>
                    <div class="box-footer" style="text-align:center;">
                        <asp:Button ID="btnAgregarHorario" runat="server" CssClass="btn btn-primary" Text="Agregar Horario" />
                        <asp:Button ID="btnGuardarHorario" runat="server" CssClass="btn btn-success" Text="Guardar Horario" />
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>