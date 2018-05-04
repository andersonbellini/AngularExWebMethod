using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using teste.DAL;



namespace Cockpit_gpx
{
    public partial class angularJS_teste : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod()]
        public static void Salvar(string str_nome_cliente)
        {
            if (!String.IsNullOrEmpty(str_nome_cliente))
            {
                Conexao con = new Conexao();

                string sqlInsert = "INSERT INTO bd_teste.tbl_cliente ";
                sqlInsert = sqlInsert + "(str_nome_cliente, str_ativo)";
                sqlInsert = sqlInsert + "VALUES";
                sqlInsert = sqlInsert + "('"+str_nome_cliente+"', '1')";

                con.Insert("bd_teste", sqlInsert);
            }

        }

        [System.Web.Services.WebMethod()]
        public static void Delete(int num_id)
        {
                Conexao con = new Conexao();

                string sqlDesativaCliente = "UPDATE bd_teste.tbl_cliente ";
                sqlDesativaCliente = sqlDesativaCliente + "set str_ativo = '0' ";
                sqlDesativaCliente = sqlDesativaCliente + "WHERE num_id = '" + num_id.ToString() + "' ";

                con.Update("bd_teste", sqlDesativaCliente);
        }



        [System.Web.Services.WebMethod()]
        public static List<Nomes> PegarLista()
        {
            List<Nomes> nomes = new List<Nomes>();

            //DataSet ds = new DataSet();
            //Conexao con = new Conexao();
            //ds = con.ds("bd_teste", "Select num_id,str_nome_cliente from tbl_cliente where str_ativo='1' ");

            DataSet ds = new Conexao().ds("bd_teste", "Select num_id,str_nome_cliente from tbl_cliente where str_ativo='1' ");

            if (ds != null && ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    nomes.Add(new Nomes(int.Parse(dr["num_id"].ToString()), dr["str_nome_cliente"].ToString())); //Convert para list
                }
            
            }
            
            return nomes;
        }

    }

    public class Nomes
    {
        public int num_id;
        public string str_nome_cliente;

        public Nomes(int _num_id, string _str_nome_cliente)
        {
            num_id = _num_id;
            str_nome_cliente = _str_nome_cliente;
        }
    }

}
