<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LabExe1.aspx.cs" Inherits="Practical_4.LabExe1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="CategoryName" DataValueField="CategoryID">
            </asp:DropDownList>
            <asp:Button ID="Button1" runat="server" Text="Find" />
            <br />
            <br />
            Your Search return :<asp:Label ID="LblResult" runat="server"></asp:Label>
&nbsp;record(s).<br />
            <br />
        </div>

        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource2">
            <ItemTemplate>
                <div>
                <label>Product Name :</label><%#DataBinder.Eval(Container.DataItem,"ProductName") %><br /><label>Unit Price :</label><%#DataBinder.Eval(Container.DataItem,"UnitPrice") %></div>
                <br />
            </ItemTemplate>
        </asp:Repeater>

        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Categories]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [UnitPrice] FROM [Products] WHERE ([CategoryID] = @CategoryID) ORDER BY [ProductID]" >
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
