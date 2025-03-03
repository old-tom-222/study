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
    	<label><input type="radio" name="operation" value="report">日报审核</label><br>
    	<label><input type="radio" name="operation" value="situation">当天发表情况统计</label><br>
        <label><input type="radio" name="operation" value="message">发送消息</label><br>
        <label><input type="radio" name="operation" value="search">查询日报</label><br>
        <input type="submit" value="执行操作">
    </form>
    <%
        String operation = request.getParameter("operation");
        if (operation!= null) {
        	if ("message".equals(operation)) {
                response.sendRedirect("c_message.jsp");
            } else if ("report".equals(operation)) {
                response.sendRedirect("c_report.jsp");
            } else if ("situation".equals(operation)) {
                response.sendRedirect("c_situation.jsp");
            } else if ("search".equals(operation)) {
                response.sendRedirect("c_search.jsp");
            }
        }
    %>
</body>
</html>