<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>删除日报</title>
</head>
<body>
    <%
        String account = (String) session.getAttribute("account");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
            Statement statement = connection.createStatement();

            // 检查当天这个账号是否已经提交过日报并且获取review_number
            String checkSql = "SELECT review_number FROM work_info WHERE account = '" + account + "' AND DATE(work_date) = CURDATE()";
            ResultSet resultSet = statement.executeQuery(checkSql);
            if (resultSet.next()) {
                int reviewNumber = resultSet.getInt("review_number");
                if (reviewNumber == 1) {
                    // 如果review_number为1，显示删除按钮
                    %>
                    <form action="delete_action.jsp" method="post">
                        <input type="hidden" name="account" value="<%=account%>">
                        <input type="submit" value="删除今天的日报">
                    </form>
                    <%
                } else {
                    out.println("日报的review_number不是1，不能删除");
                }
            } else {
                out.println("今天没有写过日报");
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            out.println("数据库操作出错（查询）: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println("加载驱动时出错: " + e.getMessage());
        }
    %>
    <form action="student.jsp">
        <input type="submit" value="返回">
    </form>
</body>
</html>