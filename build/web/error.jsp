<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String codigoError = (String) request.getAttribute("codigoError");
    String mensajeError = (String) request.getAttribute("mensajeError");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Error</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 flex items-center justify-center min-h-screen px-4">
        <div class="text-center">
            <!-- Animación SVG -->
            <div class="relative w-40 h-40 mx-auto mb-6">
                <svg class="absolute inset-0 w-full h-full animate-pulse" viewBox="0 0 100 100" fill="none">
                <circle cx="50" cy="50" r="40" stroke="#f87171" stroke-width="8" fill="none" />
                <circle cx="50" cy="50" r="30" stroke="#fca5a5" stroke-width="4" fill="none" />
                </svg>
                <div class="absolute inset-0 flex items-center justify-center text-red-500 text-5xl font-bold select-none">
                    <span id="errorCode"><%= codigoError != null ? codigoError : "Error"%></span>
                </div>
            </div>

            <h1 id="errorTitle" class="text-3xl font-semibold text-gray-800 mb-2">
                <%= mensajeError != null ? mensajeError : "Ha ocurrido un error inesperado"%>
            </h1>
            <p id="errorMessage" class="text-gray-500 mb-6">
                Por favor, intente nuevamente o contacte al administrador si el problema persiste.
            </p>
            <a href="home.jsp" class="inline-block bg-red-500 hover:bg-red-600 text-white font-medium py-2 px-4 rounded-full transition">Regresar al inicio</a>
        </div>

    </body>
</html>
