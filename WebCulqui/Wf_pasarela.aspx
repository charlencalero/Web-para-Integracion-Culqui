﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Wf_pasarela.aspx.cs" Inherits="WebCulqui.Wf_pasarela" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type"   name="viewport" content="charset=utf-8,width=device-width, initial-scale=1.0"/>

    <title>PASARELLA DE PAGO</title>
    
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="https://checkout.culqi.com/v2"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <script>
        Culqi.publicKey = 'pk_test_PduG6BSK54mJ02va';
         
      

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

            if (Culqi.token) {
                // ¡Token creado exitosamente!

                // Get the token ID:
                var token = Culqi.token;
           $("#espere").show(); 
                  $('#buyButton').hide();

                var objmeta = { "idcomprobante":  $("#LabelId").val()}; 

      $.ajax({
                url: 'https://api.culqi.com/v2/charges',
                data: JSON.stringify({
                   
                    "amount": $("#LabeMonto").val(),
                    "capture":true,
                    "currency_code": "PEN",
                    "description": $("#LabelDescripcion").val(),
                    "email": Culqi.token.email,
                    "installments":0,
                    "metadata": objmeta ,
                    "source_id": Culqi.token.id
                }),
                contentType: "application/json",
                headers: {
                    "Accept": "application/json",
                    "authorization": "Bearer sk_test_z248qw7UKmwaep03"
                },
                error: function (err) {
                    console(err.responseText);
                    alert('Lo sentimos, a ocurrido un error');
                },
                dataType: 'json',
                success: function (data) {
                   // console(data.outcome.user_message);
                    $("#espere").hide(); 
                  

                    $("#LabelResp").html(data.outcome.user_message);   
                    $("#LabelOP").html("O.P. : " + data.outcome.code);
                    $("#LabelBrand").html(data.source.iin.card_brand +" - "+ data.source.iin.card_category);
                    $("#LabelMontoCobrado").html("S/ " + data.amount);
                    $("#LabelTarjeta").html("N° Tarjeta. : " + data.source.card_number);
                    $("#LabelRefe").html("N° Refe. : "+ data.metadata.idcomprobante);
                },
                type: 'POST'
            });

        
     


            } else { // ¡Hubo algún problema!
                // Mostramos JSON de objeto error en consola
                console.log(Culqi.error);
                alert(Culqi.error.mensaje);
                  $("#espere").hide(); 
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

            //ocultar valores iniciales
            $("#espere").hide(); 
               $("#LabeMonto").hide();
                $("#LabelDescripcion").hide();
                 $("#LabelId").hide();

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
                $("#LabelId").val(id);
          
                $("#LabelId").hide();

                $("#LabelDescripcion").val(servicio);
               
                 $("#LabelDescripcion").hide();
              
                $("#LabeMonto").val(valorentero);
             
                $("#LabeMonto").hide();

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
   <form runat="server"  method="POST"  style="margin-left:40px;margin-right:40px;margin-top:100px">
      
        <table style="width:100%;text-align:center;">
            <tr><td colspan="3"><label>  </label></td></tr>
            <tr><td><button class="btn btn-info" type="button" id="buyButton">Pagar con CULQI</button></td></tr>
           

            
            <tr><td>
                <input id="LabelId" type="text" />
              
            </td></tr>
            <tr><td>
                <input id="LabelDescripcion" type="text" />
                </td></tr>
            <tr><td>
          <input id="LabeMonto" type="text" />
                                                       </td></tr>
   

   <tr><td><img src="Content/Pago-Tarjeta.gif" id="espere" /></td></tr>   
      <tr><td><strong><label id="LabelBrand"></label></strong></td></tr>
       <tr></tr>
      <tr><td><label id="LabelResp"></label> </td></tr>
         <tr></tr>
         <tr><td><label id="LabelOP"></label></td></tr>
       <tr><td><label id="LabelRefe"></label></td></tr>
         <tr><td><label id="LabelTarjeta"></label></td></tr>
       <tr><td><label id="LabelMontoCobrado"></label></td></tr>
  </table>
      
      


    </form>
</body>
</html>
