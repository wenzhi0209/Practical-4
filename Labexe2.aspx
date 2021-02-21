<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Labexe2.aspx.cs" Inherits="Practical_4.Labexe2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 356px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>Please Select Staff Name:</td>
                    <td>Please Select Year:</td>
                </tr>
                 <tr>
                    <td>
                        <asp:DropDownList ID="DDLname" runat="server" DataSourceID="SqlDataSource1" DataTextField="staffName" DataValueField="employeeID" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:RadioButtonList ID="RBLyear" runat="server" DataSourceID="SqlDataSource3" DataTextField="year" DataValueField="year"></asp:RadioButtonList>
                    </td>
                </tr>
                 <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" />
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select distinct (LastName+' '+ FirstName) as staffName, employees.employeeID
from Orders
Inner Join Employees On Orders.EmployeeID=Employees.EmployeeID


 
"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DATEPART(year, OrderDate) AS year 
FROM Orders WHERE (EmployeeID = @EmployeeID) 
GROUP BY DATEPART(year, OrderDate)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DDLname" Name="EmployeeID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <asp:Label ID="Lblmsg" runat="server"></asp:Label>
            <br />

           <table>
               <tr>
                   <td>
                       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" DataKeyNames="OrderID" DataSourceID="SqlDataSource4" ForeColor="Black">
                           <Columns>
                               <asp:CommandField ShowSelectButton="True" />
                               <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                               <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" />
                           </Columns>
                           <FooterStyle BackColor="#CCCCCC" />
                           <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                           <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                           <RowStyle BackColor="White" />
                           <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                           <SortedAscendingCellStyle BackColor="#F1F1F1" />
                           <SortedAscendingHeaderStyle BackColor="#808080" />
                           <SortedDescendingCellStyle BackColor="#CAC9C9" />
                           <SortedDescendingHeaderStyle BackColor="#383838" />
                       </asp:GridView>
                       <br />
                       <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="
SELECT DISTINCT Orders.OrderID, Orders.OrderDate FROM Orders WHERE (Orders.EmployeeID = @EmployeeID) AND (DATEPART(year, Orders.OrderDate) = @OrderDate)">
                           <SelectParameters>
                               <asp:ControlParameter ControlID="DDLname" Name="EmployeeID" PropertyName="SelectedValue" />
                               <asp:ControlParameter ControlID="RBLyear" Name="OrderDate" PropertyName="SelectedValue" />
                           </SelectParameters>
                       </asp:SqlDataSource>
                   </td>
                   <td class="auto-style1">
                       <asp:Label ID="orderTotalMsg" runat="server"></asp:Label>
                       <br />
                       <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Products.ProductName, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount, [Order Details].UnitPrice*[Order Details].Quantity*(1-[Order Details].Discount ) AS subprice
FROM 
Orders INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN Products ON [Order Details].ProductID = Products.ProductID

where Orders.orderID= @orderID">
                           <SelectParameters>
                               <asp:ControlParameter ControlID="GridView1" Name="orderID" PropertyName="SelectedValue" />
                           </SelectParameters>
                       </asp:SqlDataSource>
                       <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource2" OnItemDataBound="DataList1_ItemDataBound">
                           <ItemTemplate>
                               ProductName:
                               <asp:Label ID="ProductNameLabel" runat="server" Text='<%# Eval("ProductName") %>' />
                               <br />
                               UnitPrice:
                               <asp:Label ID="UnitPriceLabel" runat="server" Text='<%# Eval("UnitPrice") %>' />
                               <br />
                               Quantity:
                               <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                               <br />
                               Discount:
                               <asp:Label ID="DiscountLabel" runat="server" Text='<%# Eval("Discount") %>' />
                               <br />
                               subprice:
                               <asp:Label ID="subpriceLabel" runat="server" Text='<%# Eval("subprice") %>' />
                               <br />
                               <br />
                           </ItemTemplate>
                       </asp:DataList>
                   </td>
               </tr>
           </table>

        </div>
    </form>
</body>
</html>
