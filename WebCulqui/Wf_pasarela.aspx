<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Wf_pasarela.aspx.cs" Inherits="WebCulqui.Wf_pasarela" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type"   name="viewport" content="charset=utf-8,width=device-width, initial-scale=1.0"/>
    <meta>
    <title>PASARELLA DE PAGO</title>
    
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="https://checkout.culqi.com/v2"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <script>
        Culqi.publicKey = 'pk_test_PduG6BSK54mJ02va';
        //Culqi.init();

     //   Culqi.publicKey = 'pk_test_zIJd7UuclPwxLDPx';
        //Culqi.settings({
        //    title: 'Culqi Store',
        //    currency: 'PEN',
        //    description: 'Polo/remera Culqi lover',
        //    amount: 3500
        //});
        //Culqi.settings({
        //    title: 'Culqi Store',
        //    currency: 'PEN',
        //    description: 'Polo/remera Culqi lover',
        //    amount: 3500
        //});

    </script>


    <script>

        function settings(_title, _currency, _description, _amount) {
            Culqi.settings({
                title: _title,
                currency: _currency,
                description: _description,
                amount: _amount,
                metadata: ''
            });

            Culqi.open();
            e.preventDefault();

        }




        function culqi() {

            if (Culqi.token) { // ¡Token creado exitosamente!
                // Get the token ID:
                var token = Culqi.token;
          
                $("#<%=LabeToken.ClientID%>").val(token.id);
                $("#<%=LabeToken.ClientID%>").attr('readonly', true);
                
                $("#<%=LabelEmail.ClientID%>").val(token.email);
                $("#<%=LabelEmail.ClientID%>").attr('readonly', true);
               // alert('Venta Realizada con Exito');

                
        
                console.log(Culqi)

      $.ajax({
                url: 'https://api.culqi.com/v2/charges',
                data: JSON.stringify({
                    "source_id": Culqi.token.id,
                    "amount":  $("#<%=LabeMonto.ClientID%>").val(),
                    "currency_code": "PEN",
                    "email": Culqi.token.email
                }),
                contentType: "application/json",
                headers: {
                    "Accept": "application/json",
                    "authorization": "Bearer sk_test_z248qw7UKmwaep03"
                },
                error: function (err) {
                    console(err);
                    alert('Lo sentimos, a ocurrido un error');
                },
                dataType: 'json',
                success: function (data) {

                    alert(data.outcome.user_message);
                    
                },
                type: 'POST'
            });

     
     


            } else { // ¡Hubo algún problema!
                // Mostramos JSON de objeto error en consola
                console.log(Culqi.error);
                alert(Culqi.error.mensaje);
            }
        };

        (function ($) {
            $.get = function (key) {
                key = key.replace(/[\[]/, '\\[');
                key = key.replace(/[\]]/, '\\]');
                var pattern = "[\\?&]" + key + "=([^&#]*)";
                var regex = new RegExp(pattern);
                var url = unescape(window.location.href);
                var results = regex.exec(url);
                if (results === null) {
                    return null;
                } else {
                    return results[1];
                }
            }
        })(jQuery);  



    </script>

    <script>
        $(document).ready(function () {

            $('#buyButton').on('click', function (e) {
                // Abre el formulario con las opciones de Culqi.settings
                var tienda = $.get("tienda");
                var moneda = $.get("moneda");
                var servicio = $.get("servicio");
                var valor = $.get("valor");
                var id = $.get("id");

                var valorst = String(valor);
                valorst=valorst.replace(".", "");
                valorst = valorst.replace(",", "");

          var valorentero = valorst;

                //id de operacion
                $("#<%=LabelId.ClientID%>").val(id);
                $("#<%=LabelId.ClientID%>").attr('readonly', true);

                $("#<%=LabelDescripcion.ClientID%>").val(servicio);
                $("#<%=LabelDescripcion.ClientID%>").attr('readonly', true);

                $('#montodecimal').html(valor)
                $("#<%=LabeMonto.ClientID%>").val(valorentero);
                $("#<%=LabeMonto.ClientID%>").attr('readonly', true);
                $("#<%=LabeMonto.ClientID%>").hide();

                settings(tienda, moneda, servicio, valorentero)


                // return false;

            });

            //$('#buyButton').on('click', function (e) {
            //    // Abre el formulario con las opciones de Culqi.settings
            //    Culqi.open();
            //    e.preventDefault();
            //});

        });

    </script>


</head>
<body>
   <form runat="server"  method="POST"  style="width:300px;margin-left:40px;margin-right:40px">
       <asp:Panel ID="PanelInicio" runat="server">
        <table>
            <tr><td colspan="3"><label>  </label></td></tr>
            <tr><td><button class="btn btn-info" type="button" id="buyButton">Validar Tarjeta</button></td></tr>
           

            <tr><td><label>Id tarjeta:</label></td><td>
                <asp:TextBox ID="LabeToken" runat="server" Text="" CssClass="form-control"></asp:TextBox>
   
                                                   </td></tr>
            <tr><td><label>Id Operacion</label></td><td>
                <asp:TextBox ID="LabelId" runat="server" Text=""   CssClass="form-control"></asp:TextBox>
            </td></tr>
            <tr><td><label>Descripcion</label></td><td><asp:TextBox ID="LabelDescripcion" runat="server" Text=""   CssClass="form-control"></asp:TextBox></td></tr>
            <tr><td><label>Monto S/</label></td><td>
                <label id="montodecimal"></label>
            <asp:TextBox ID="LabeMonto" runat="server" Text=""   CssClass="form-control"></asp:TextBox>

                                                </td></tr>
            <tr><td><label>Email</label></td><td> <asp:TextBox ID="LabelEmail" runat="server" Text=""   CssClass="form-control"></asp:TextBox></td></tr>
            <tr><td><label>Direccion</label></td>
                <td>
                    <asp:TextBox ID="TextDireccion"  CssClass="form-control" runat="server"></asp:TextBox>

                </td>

            </tr>
            <tr><td><label>Ciudad</label></td>
                <td>
                    <asp:TextBox ID="TextCiudad" CssClass="form-control" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr><td><label>Nombres</label></td>
                <td>
                   <asp:TextBox ID="TextNombres" CssClass="form-control" runat="server"></asp:TextBox>

                </td></tr>
            <tr><td><label>Apellidos</label></td>
                <td><asp:TextBox ID="TextApellidos" CssClass="form-control" runat="server"></asp:TextBox></td></tr>
           
            <tr><td><label>Telefono</label></td>
                <td><asp:TextBox ID="TextTelefono" CssClass="form-control" runat="server"></asp:TextBox></td>
           
                <td></td>

            </tr>
            <tr><td>
                <asp:Button ID="ButtFinalizar" OnClick="ButtFinalizar_Click" CssClass="btn btn-info" runat="server" Text="Registrar Cobro" /></td></tr>
           </table>
            </asp:Panel>

       <asp:Panel ID="PanelResp" runat="server" Visible="false">
  <table style="text-align:center;">
      <tr><td><strong><asp:Label ID="LabelBrand" runat="server" Text="Label"></asp:Label></strong></td></tr>
       <tr></tr>
      <tr><td> <asp:Label ID="LabelResp" runat="server" Text="Label"></asp:Label></td></tr>
         <tr></tr>
         <tr><td><asp:Label ID="LabelOP" runat="server" Text="Label"></asp:Label></td></tr>
       <tr><td><asp:Label ID="LabelRefe" runat="server" Text="Label"></asp:Label></td></tr>
         <tr><td><asp:Label ID="LabelTarjeta" runat="server" Text="Label"></asp:Label></td></tr>
       <tr><td><asp:Label ID="LabelMonto" runat="server" Text="Label"></asp:Label></td></tr>
  </table>
      
       </asp:Panel>


    </form>
</body>
</html>
