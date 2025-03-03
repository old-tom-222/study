<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>日报展示</title>
</head>
<body>
    <%
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date now = new Date();
        String today = sdf.format(now);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
            Statement statement = connection.createStatement();

            // 查询所有日报（这里假设work_info表中有日期字段work_date）
            String querySql = "SELECT * FROM work_info";
            ResultSet resultSet = statement.executeQuery(querySql);
    %>
    <form action="grade_action.jsp">
        <select name="account">
            <%
                while (resultSet.next()) {
                    String account = resultSet.getString("account");
                    String workDate = resultSet.getString("work_date");
                    if (workDate!= null && workDate.substring(0, 10).equals(today)) {
            %>
            <option value="<%=account%>"><%=account%></option>
            <%
                    }
                }
            %>
        </select>
        <input type="submit" value="选择账号进行操作">
    </form>
    <%
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            out.println("数据库操作出错（查询）: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println("加载驱动时出错: " + e.getMessage());
        }
    %>
    <form action="teacher.jsp">
        <input type="submit" value="返回">
    </form>
</body>
</html>