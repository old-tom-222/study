<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>浏览日报</title>
</head>
<body>
    <h2>日报信息</h2>
    <table border="1">
        <tr>
            <th>账号</th>
            <th>所花时间</th>
            <th>代码量</th>
            <th>博客量</th>
            <th>知识点</th>
            <th>工作日期</th>
        </tr>
        <%
            // 从session中获取账号
            String account = (String) session.getAttribute("account");
            if (account == null) {
                out.println("未登录，请先登录");
            } else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
                    Statement statement = connection.createStatement();
                    // 查询指定账号的日报信息
                    String sql = "SELECT account, time_spent, code_amount, blog_amount, knowledge_points, work_date FROM work_info WHERE account = '" + account + "'";
                    ResultSet resultSet = statement.executeQuery(sql);
                    while (resultSet.next()) {
                        String acc = resultSet.getString("account");
                        String time_spent = resultSet.getString("time_spent");
                        int code_amount = resultSet.getInt("code_amount");
                        int blog_amount = resultSet.getInt("blog_amount");
                        String knowledge_points = resultSet.getString("knowledge_points");
                        String work_date = resultSet.getString("work_date");
        %>
        <tr>
            <td><%=acc%></td>
            <td><%=time_spent%></td>
            <td><%=code_amount%></td>
            <td><%=blog_amount%></td>
            <td><%=knowledge_points%></td>
            <td><%=work_date%></td>
        </tr>
        <%
                    }
                    resultSet.close();
                    statement.close();
                    connection.close();
                } catch (SQLException e) {
                    out.println("数据库操作出错（查询）: " + e.getMessage());
                } catch (ClassNotFoundException e) {
                    out.println("加载驱动时出错: " + e.getMessage());
                }
            }
        %>
    </table>
    <form action="student.jsp" method="get">
        <input type="submit" value="结束">
    </form>
</body>
</html>