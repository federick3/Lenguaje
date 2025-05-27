<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String username = (session != null) ? (String) session.getAttribute("usuario") : null;
    String rol = (session != null) ? (String) session.getAttribute("rol") : null;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/Footer.css">
    </head>
    <body>
        <header>
            <div class="header-container">
                <div class="logo">
                    <img src="assets/logo.png" alt="AgroPiura">
                </div>
                <div class="contact-info">
                    <p>📞 Número fijo: (073) 284750</p>
                    <p>📱 Celular: 958623176</p>
                    <p>📍 Dirección: Agropiura SAC, XCVG+PR2, Olivares San Fernando</p>
                    <p>R.U.C: 10764501506</p>
                </div>
            </div>
            <nav class="navbar navbar-expand-lg" style="background-color: #004b23;">
                <div class="container-fluid">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse d-flex justify-content-between" id="navbarNavAltMarkup" style="margin-left: 150px;">
                        <div class="navbar-nav mx-auto">
                            <a class="nav-link active" aria-current="page" href="http://localhost:8080/AgroPiura/home.jsp">INICIO</a>
                            <a class="nav-link" href="http://localhost:8080/AgroPiura/catProductos.jsp">PRODUCTOS</a>
                            <a class="nav-link" href="http://localhost:8080/AgroPiura/Nosotros.jsp">NOSOTROS</a>
                            <a class="nav-link" href="http://localhost:8080/AgroPiura/Contactanos.jsp">CONTÁCTANOS</a>
                        </div>

                        <div class="d-flex">
                            <% if (username == null) { %>
                            <li class="nav-item">
                                <a class="btn btn-primary" href="login.jsp">Iniciar sesión</a>
                            </li>
                            <% } else {%>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <%= username%>
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <li><a class="dropdown-item" href="http://localhost:8080/AgroPiura/Controlador?accion=ListarCompras">Mis compras</a></li>

                                    <% if ("administrador".equalsIgnoreCase(rol)) { %>
                                    <li><a class="dropdown-item" href="Controlador?accion=ListarComprasAdmin">Administrar pedidos</a></li>
                                    <li><a class="dropdown-item" href="Controlador?accion=admin">Administrar productos</a></li>
                                    <li><a class="dropdown-item" href="Controlador?accion=ListarSolicitudes">Administrar solicitudes</a></li>
                                        <% } %>

                                    <li><a class="dropdown-item" href="CerrarSesion">Cerrar sesión</a></li>
                                </ul>
                            </li>
                            <% }%>
                        </div>
                    </div>
                </div>
            </nav>  
        </header>
        <div class="container mt-5">
            <h1 class="text-center mb-4">Lista de solicitudes de contacto</h1>
            <div class="text-center mb-4">
                <form action="Controlador" method="get">
                    <input type="hidden" name="accion" value="FiltrarSolicitudes">
                    <button type="submit" name="estado" value="0" class="btn btn-primary">Por revisar</button>
                    <button type="submit" name="estado" value="1" class="btn btn-warning">Revisadas</button>
                    <button type="submit" name="estado" value="2" class="btn btn-danger">Contestada</button>
                    <button type="submit" name="accion" value="ListarSolicitudes" class="btn btn-light">Ver todas las solicitudes</button>
                </form>
            </div>
            <div class="text-center mb-4">
                <form action="Controlador" method="get" class="form-inline">
                    <input type="hidden" name="accion" value="BuscarSolicitudes">
                    <input type="text" name="buscar" placeholder="Buscar por código de solicitud, número de documento, nombre, empresa" class="form-control mr-2">
                    <button type="submit" class="btn btn-primary" style="margin-top:15px">Buscar</button>
                </form>
            </div>

            <c:if test="${not empty s}">
                <c:forEach var="s" items="${s}">
                    <div class="card mb-3">
                        <div class="card-header">
                            ${s.fechaSolicitud}
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Código de solicitud ${s.codSolicitud}</h5>
                            <p class="card-text">Estado: 
                                <c:choose>
                                    <c:when test="${s.estado == 0}">Por revisar</c:when>
                                    <c:when test="${s.estado == 1}">Revisada</c:when>
                                    <c:when test="${s.estado == 2}">Contestada</c:when>
                                    <c:otherwise>Desconocido</c:otherwise>
                                </c:choose>
                            </p>
                            <a href="Controlador?accion=VerDetalleSolicitudAdmin&CodSolicitud=${s.codSolicitud}" class="btn btn-primary">Ver solicitud</a>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
        <footer>
            <div style="display: flex; justify-content: space-around; margin: auto;">

                <div style="flex: 1; text-align: center; margin-left: 125px;">
                    <img src="assets/logo-blanco2.png" alt="AgroPiura" style="max-width: 300px; margin-bottom: 15px;">
                </div>

                <div style="flex: 1; padding: 0 15px;">
                    <h4 style="margin-bottom: 15px;">Contacto</h4>
                    <p style="font-size: 0.9em; line-height: 1.5;">
                        Dirección: Agropiura SAC, XCVG+PR2, Olivares San Fernando.
                    </p>
                    <p style="font-size: 0.9em; margin-top: 10px;">Correo: <a href="mailto:contacto@agropiura.com" style="color: #fff; text-decoration: underline;">contacto@agropiura.com</a></p>
                </div>

                <div style="flex: 1; padding: 0 15px;">
                    <h4 style="margin-bottom: 15px;">Enlaces de interés:</h4>
                    <ul style="list-style-type: none; padding: 0; font-size: 0.9em;">
                        <li><a href="catProductos.jsp" style="text-decoration: none; color: inherit;">❋ Productos</a></li>
                        <li><a href="Nosotros.jsp" style="text-decoration: none; color: inherit;">❋ Nosotros</a></li>
                        <li><a href="Contactanos.jsp" style="text-decoration: none; color: inherit;">❋ Contáctanos</a></li>
                    </ul>

                </div>

                <div style="flex: 1; padding: 0 15px;">
                    <h4 style="margin-bottom: 15px;">Síguenos:</h4>
                    <ul style="list-style-type: none; padding: 0; font-size: 0.9em;">
                        <li>❋ Facebook</li>
                        <li>❋ Instagram</li>
                        <li>❋ LinkedIn</li>
                        <li>❋ YouTube</li>
                    </ul>
                </div>

            </div>
        </footer>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>  
    </body>
</html>
