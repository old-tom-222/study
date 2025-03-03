<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    String account = request.getParameter("account");
    String originalDate = request.getParameter("original_date");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
        Statement statement = connection.createStatement();

        // 更新review_number为2，表示审核通过
        String updateSql = "UPDATE work_info SET review_number = 2 WHERE account = '" + account + "' AND work_date = '" + originalDate + "'";
        int rowsUpdated = statement.executeUpdate(updateSql);
        if (rowsUpdated > 0) {
            out.println("审核操作成功");
        }
        statement.close();
        connection.close();
    } catch (SQLException e) {
        out.println("数据库操作出错（更新）: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        out.println("加载驱动时出错: " + e.getMessage());
    }
%>
<form action="c_report.jsp">
    <input type="submit" value="返回审核页面">
</form>
</body>
</html>