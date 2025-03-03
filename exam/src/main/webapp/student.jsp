<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>操作选择</title>
</head>
<body>
    <form action="" method="get">
        <label><input type="radio" name="operation" value="insert">添加日报</label><br>
        <label><input type="radio" name="operation" value="update">更新日报</label><br>
        <label><input type="radio" name="operation" value="delete">删除日报</label><br>
        <label><input type="radio" name="operation" value="select">浏览日报</label><br>
        <label><input type="radio" name="operation" value="search">查询个人日报</label><br>
        <label><input type="radio" name="operation" value="message">查看消息</label><br>
        <input type="submit" value="执行操作">
    </form>
    <%
        String operation = request.getParameter("operation");
        if (operation!= null) {
            if ("insert".equals(operation)) {
                response.sendRedirect("s_insert.jsp");
            } else if ("update".equals(operation)) {
                response.sendRedirect("s_update.jsp");
            } else if ("delete".equals(operation)) {
                response.sendRedirect("s_delete.jsp");
            } else if ("select".equals(operation)) {
                response.sendRedirect("s_select.jsp");
            } else if ("search".equals(operation)) {
                response.sendRedirect("s_search.jsp");
            } else if ("message".equals(operation)) {
                response.sendRedirect("s_message.jsp");
            }
        }
    %>
</body>
</html>