<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<meta charset="UTF-8">
<head>
    <title>���� ����</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
</head>
<body>
        <h1>���� ����</h1>
        <p>�����޽��� : <span th:text="${message}"></span></p>
        <p>�����ڵ� : <span th:text="${code}"></span></p>
</body>
</html>