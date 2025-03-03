<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>查询个人日报</title>
</head>
<body>
    <form action="" method="post">
        <!-- 从session获取账号并设置为隐藏域 -->
        <%
            String account = (String) session.getAttribute("account");
        %>
        <input type="hidden" id="account" name="account" value="<%=account%>"><br>
        <label for="query_date">查询日期（格式：yyyy - MM - dd）：</label><input type="text" id="query_date" name="query_date"><br>
        <input type="submit" value="查询">
    </form>
    <%
        if ("POST".equals(request.getMethod())) {
            String queryDate = request.getParameter("query_date");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
                Statement statement = connection.createStatement();

                // 修改查询语句，使用DATE()函数提取日期部分进行比较
                String sql = "SELECT * FROM work_info WHERE account = '" + account + "' AND DATE(work_date) = '" + queryDate + "'";
                ResultSet resultSet = statement.executeQuery(sql);

                if (resultSet.next()) {
                    out.println("<h2>查询到的日报信息：</h2>");
                    out.println("<table border='1'>");
                    out.println("<tr><th>账号</th><th>所花时间</th><th>代码量</th><th>博客量</th><th>知识点</th><th>工作日期</th></tr>");
                    String acc = resultSet.getString("account");
                    String time_spent = resultSet.getString("time_spent");
                    int code_amount = resultSet.getInt("code_amount");
                    int blog_amount = resultSet.getInt("blog_amount");
                    String knowledge_points = resultSet.getString("knowledge_points");
                    String work_date = resultSet.getString("work_date");
                    out.println("<tr>");
                    out.println("<td>" + acc + "</td>");
                    out.println("<td>" + time_spent + "</td>");
                    out.println("<td>" + code_amount + "</td>");
                    out.println("<td>" + blog_amount + "</td>");
                    out.println("<td>" + knowledge_points + "</td>");
                    out.println("<td>" + work_date + "</td>");
                    out.println("</tr>");
                    out.println("</table>");
                } else {
                    out.println("未查询到该日期的日报信息");
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
    <form action="student.jsp">
        <input type="submit" value="返回">
    </form>
</body>
</html>