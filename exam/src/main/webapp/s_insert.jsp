<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加日报</title>
</head>
<body>
    <form action="" method="post">
        <!-- 直接从session获取账号并设置为隐藏域 -->
        <%
            String account = (String) session.getAttribute("account");
        %>
        <input type="hidden" id="account" name="account" value="<%=account%>"><br>
        <label for="time_spent">所花时间：</label><input type="text" id="time_spent" name="time_spent"><br>
        <label for="code_amount">代码量：</label><input type="text" id="code_amount" name="code_amount"><br>
        <label for="blog_amount">博客量：</label><input type="text" id="blog_amount" name="blog_amount"><br>
        <label for="knowledge_points">知识点：</label><input type="text" id="knowledge_points" name="knowledge_points"><br>
        <input type="submit" value="提交日报">
    </form>
    <%
        if ("POST".equals(request.getMethod())) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
                Statement statement = connection.createStatement();

                // 检查当天这个账号是否已经提交过日报
                String checkSql = "SELECT COUNT(*) FROM work_info WHERE account = '" + account + "' AND DATE(work_date) = CURDATE()";
                ResultSet resultSet = statement.executeQuery(checkSql);
                resultSet.next();
                int count = resultSet.getInt(1);
                if (count > 0) {
                    out.println("已经写过日报");
                } else {
                    String time_spent = request.getParameter("time_spent");
                    String code_amount = request.getParameter("code_amount");
                    String blog_amount = request.getParameter("blog_amount");
                    String knowledge_points = request.getParameter("knowledge_points");
                    // 构建插入work_info表的SQL语句
                    String sql = "INSERT INTO work_info (account, time_spent, code_amount, blog_amount, knowledge_points) VALUES ('" + account + "', " + time_spent + ", " + code_amount + ", " + blog_amount + ", '" + knowledge_points + "')";
                    int rowsInserted = statement.executeUpdate(sql);
                    if (rowsInserted > 0) {
                        out.println("成功提交日报");
                    } else {
                        out.println("提交日报失败");
                    }
                }

                statement.close();
                connection.close();
                // 操作完成后跳回student.jsp（这里假设存在student.jsp，如果没有需要修改这个跳转页面）
                if (count > 0) {
                    %>
                    <h2>今日已添加过日报</h2>
                    <form action="student.jsp">
                        <input type="submit" value="结束">
                    </form>
                    <%
                } else {
                    response.sendRedirect("student.jsp");
                }
            } catch (SQLException e) {
                out.println("数据库操作出错（插入）: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println("加载驱动时出错: " + e.getMessage());
            }
        }
    %>
</body>
</html>