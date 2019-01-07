<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="GestionarReservaCitas.aspx.cs" Inherits="CapaPresentacion.GestionarReservaCitas" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1 align="center">RESERVA DE CITAS</h1>
    </section>
    <section class="content">
        <div class="box-header">
            <h3 align="center" class="box-title">DATOS DEL PACIENTE</h3>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="form-group">
                            <label>DOCUMENTO DE IDENTIDAD</label>
                        </div>
                        <div class="input-group">
                            <asp:TextBox ID="txtDNI" CssClass="form-control" runat="server"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:Button ID="btnBuscar" runat="server" CssClass="btn btn-danger" Text="Buscar" />
                            </div>
                        </div>
                        <br />
                        <div class="form-group">
                            <label>NOMBRES</label>
                            <asp:TextBox ID="txtNombres" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>APELLIDOS</label>
                            <asp:TextBox ID="txtApellidos" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="box box-primary">
                    <br />
                    <div class="box-body">
                        <div class="form-group">
                            <label>TELEFONO</label>
                            <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>EDAD</label>
                            <asp:TextBox ID="txtEdad" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>SEXO</label>
                            <asp:TextBox ID="txtSexo" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <section class="content-header">
            <h3 style="text-align: center">HORARIOS DE ATENCIÓN</h3>
        </section>
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header"></div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label>FECHA</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <asp:TextBox ID="txtFechaAtencion" runat="server" CssClass="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <label>ESPECIALIDAD</label>
                                    <asp:DropDownList ID="ddlEspecialidad" CssClass="form-control" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group" style="text-align: center">
                                    <br />
                                    <asp:Button ID="btnBuscarHorario" runat="server" CssClass="btn btn-danger" Text="Buscar" />
                                </div>
                            </div>
                        </div>                                                
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
