using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;


namespace Practical_4
{
    public partial class Labexe2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (RBLyear.SelectedValue == "")
                RBLyear.SelectedIndex = 0;

            SqlConnection connDb;
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString + ";integrated security = true; MultipleActiveResultSets = true";
            connDb = new SqlConnection(strConn);
            connDb.Open();
            
         
            string sql = "SELECT SUM([Order Subtotals].Subtotal) as total FROM Orders INNER JOIN[Order Subtotals] ON Orders.OrderID = [Order Subtotals].OrderID WHERE(Orders.EmployeeID = @EmployeeID) AND(DATEPART(year, Orders.OrderDate) = @OrderDate)";
            SqlCommand cmd = new SqlCommand(sql, connDb);
            cmd.Parameters.AddWithValue("@EmployeeID", DDLname.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@OrderDate", RBLyear.SelectedValue.ToString());
            double TotalSales = double.Parse(cmd.ExecuteScalar().ToString());
            connDb.Close();

           
            Lblmsg.Text = "Sales Order by " + DDLname.SelectedItem.ToString() + " in the year of " + RBLyear.SelectedItem.ToString()+ " Grand total sales is "+TotalSales;
            
        }

        protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
        {

            SqlConnection connDb;
            string strConn = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString + ";integrated security = true; MultipleActiveResultSets = true";
            connDb = new SqlConnection(strConn);
            connDb.Open();

            double TotalPrice = 0;
            string sql = "SELECT SUM([Order Details].UnitPrice*[Order Details].Quantity*(1-[Order Details].Discount ) )AS subprice FROM Orders INNER JOIN[Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN Products ON[Order Details].ProductID = Products.ProductID where Orders.orderID = @orderID";
            SqlCommand cmd = new SqlCommand(sql, connDb);
            cmd.Parameters.AddWithValue("@orderID", GridView1.SelectedValue.ToString());
            TotalPrice = (double)cmd.ExecuteScalar();
            connDb.Close();

            orderTotalMsg.Text = "Total Sales for Order Id : " + GridView1.SelectedValue.ToString() + " =$ " + TotalPrice.ToString("0.00");
        }
    }
}