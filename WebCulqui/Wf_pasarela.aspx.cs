//using culqi.net;
//using Newtonsoft.Json;
//using Newtonsoft.Json.Linq;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using WebCulqui.Entity;

//namespace WebCulqui
//{
//    public partial class Wf_pasarela : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            Security security = new Security();
//            security.public_key = "pk_test_PduG6BSK54mJ02va";
//            security.secret_key = "sk_test_z248qw7UKmwaep03";

//            Dictionary<string, object> charge = new Dictionary<string, object>
//            {

//                // {"card_brand", "visa"}

//            };
//            var charge_created = new Charge(security).List(charge);

//        }

//        protected void ButtFinalizar_Click(object sender, EventArgs e)
//        {
//            Security security = new Security();
//            security.public_key = "pk_test_PduG6BSK54mJ02va";
//            security.secret_key = "sk_test_z248qw7UKmwaep03";

//           // var json_token = JObject.Parse(token_created);

//            Dictionary<string, object> metadata = new Dictionary<string, object>
//            {
//                {"id", LabelId.Text}
//            };

//            Dictionary<string, object> charge = new Dictionary<string, object>
//            {
//                {"amount", LabeMonto.Text},
//                {"capture", true},
//                {"currency_code", "PEN"},
//                {"description", LabelDescripcion.Text},
//                //{"email", LabelEmail.Text},
//                {"installments", 0},
//                {"metadata", metadata},
//                //{"source_id",LabeToken.Text}
//                //  {"source_id", (string)json_token["id"]}
//            };

//            string charge_created = new Charge(security).Create(charge);

//            var respcargo = new RespCargo();

//            respcargo = JsonConvert.DeserializeObject<RespCargo>(charge_created);

//            string charge_created2 = new Charge(security).Capture(respcargo.id);

//            LabelResp.Text = respcargo.outcome.user_message;
//            LabelOP.Text = "O.P. : " + respcargo.outcome.code;
//            LabelBrand.Text = respcargo.source.iin.card_brand +" - "+ respcargo.source.iin.card_category;
//            LabelMonto.Text = "S/ " + FormatoNumeroDecimal(respcargo.amount);
//            LabelTarjeta.Text = "N° Tarjeta. : " + respcargo.source.card_number;
//            LabelRefe.Text ="N° Refe. : "+ respcargo.metadata.id;
            

//          //  PanelResp.Visible = true;

//        }

//        private string FormatoNumeroDecimal(int numeroentero)
//        {
//            var deci = numeroentero.ToString().Substring(numeroentero.ToString().Length - 2, 2);

//            var numerodeci = ( double.Parse(numeroentero.ToString().Substring(0, numeroentero.ToString().Length - 2)) + double.Parse(deci) / 100).ToString("0.00");

//            return numerodeci;
//        }
//        private string FormatoNumeroEntero(double numerodecimal)
//        {
//            var deci = numerodecimal.ToString("0.00");

//            deci.Replace(".", "");
//            return deci;
//        }
//    }
//}