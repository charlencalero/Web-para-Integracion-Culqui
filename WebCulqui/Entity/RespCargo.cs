using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebCulqui.Entity
{
    public class Issuer
    {
        public string name { get; set; }
        public string country { get; set; }
        public string country_code { get; set; }
        public object website { get; set; }
        public object phone_number { get; set; }
    }

    public class Iin
    {
        public string @object { get; set; }
        public string bin { get; set; }
        public string card_brand { get; set; }
        public string card_type { get; set; }
        public string card_category { get; set; }
        public Issuer issuer { get; set; }
        public List<int> installments_allowed { get; set; }
    }

    public class Client
    {
        public string ip { get; set; }
        public string ip_country { get; set; }
        public string ip_country_code { get; set; }
        public object browser { get; set; }
        public string device_fingerprint { get; set; }
        public string device_type { get; set; }
    }

    public class Metadata
    {
        public string method { get; set; }
        public string client_ip { get; set; }
        public string secure { get; set; }
        public string url { get; set; }
    }

    public class Source
    {
        public string @object { get; set; }
        public string id { get; set; }
        public string type { get; set; }
        public long creation_date { get; set; }
        public string email { get; set; }
        public string card_number { get; set; }
        public string last_four { get; set; }
        public bool active { get; set; }
        public Iin iin { get; set; }
        public Client client { get; set; }
        public Metadata metadata { get; set; }
    }

    public class Outcome
    {
        public string type { get; set; }
        public string code { get; set; }
        public string merchant_message { get; set; }
        public string user_message { get; set; }
    }

    public class Metadata2
    {
        public string id { get; set; }
    }

    public class FixedFee
    {
    }

    public class VariableFee
    {
        public string currency_code { get; set; }
        public double commision { get; set; }
        public int total { get; set; }
    }

    public class FeeDetails
    {
        public FixedFee fixed_fee { get; set; }
        public VariableFee variable_fee { get; set; }
    }

    public class RespCargo
    {
        public bool duplicated { get; set; }
        public string @object { get; set; }
        public string id { get; set; }
        public long creation_date { get; set; }
        public int amount { get; set; }
        public int amount_refunded { get; set; }
        public int current_amount { get; set; }
        public int installments { get; set; }
        public object installments_amount { get; set; }
        public string currency_code { get; set; }
        public string email { get; set; }
        public string description { get; set; }
        public Source source { get; set; }
        public Outcome outcome { get; set; }
        public double fraud_score { get; set; }
        public bool dispute { get; set; }
        public bool capture { get; set; }
        public string reference_code { get; set; }
        public string authorization_code { get; set; }
        public Metadata2 metadata { get; set; }
        public int total_fee { get; set; }
        public FeeDetails fee_details { get; set; }
        public int total_fee_taxes { get; set; }
        public int transfer_amount { get; set; }
        public bool paid { get; set; }
        public string statement_descriptor { get; set; }
        public object transfer_id { get; set; }
    }
}