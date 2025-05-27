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
        <link rel="stylesheet" href="css/Footer.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/header.css">
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
            <h1 class="text-center mb-4">Lista de compras</h1>
            <div class="text-center mb-4">
                <form action="Controlador" method="get">
                    <input type="hidden" name="accion" value="FiltrarCompras">
                    <button type="submit" name="estado" value="0" class="btn btn-info">Pago en revisión</button>
                    <button type="submit" name="estado" value="1" class="btn btn-success">Pago verificado</button>
                    <button type="submit" name="estado" value="2" class="btn btn-warning">Preparando pedido</button>
                    <button type="submit" name="estado" value="3" class="btn btn-primary">Pedido enviado</button>
                    <button type="submit" name="estado" value="4" class="btn btn-secondary">Pedido recibido</button>
                    <button type="submit" name="estado" value="5" class="btn btn-danger">Pago rechazado</button>
                    <button type="submit" name="accion" value="ListarComprasAdmin" class="btn btn-light">Ver todas las compras</button>
                </form>
            </div>
            <div class="text-center mb-4">
                <form action="Controlador" method="get" class="form-inline">
                    <input type="hidden" name="accion" value="BuscarCompras">
                    <input type="text" name="buscar" placeholder="Buscar por usuario, código de compra o número de documento" class="form-control mr-2">
                    <button type="submit" class="btn btn-primary" style="margin-top:15px">Buscar</button>
                </form>
            </div>

            <c:if test="${not empty compras}">
                <c:forEach var="compra" items="${compras}">
                    <div class="card mb-3">
                        <div class="card-header">
                            ${compra.fechaCompra}
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">Código de compra: ${compra.codCompra}</h5>
                            <p class="card-text">Total: S/. ${compra.total}</p>
                            <p class="card-text">Estado: 
                                <c:choose>
                                    <c:when test="${compra.estado == 0}">
                                        Pago en revisión
                                    </c:when>
                                    <c:when test="${compra.estado == 1}">
                                        Pago verificado
                                    </c:when>
                                    <c:when test="${compra.estado == 2}">
                                        Preparando pedido
                                    </c:when>
                                    <c:when test="${compra.estado == 3}">
                                        Pedido enviado
                                    </c:when>
                                    <c:when test="${compra.estado == 4}">
                                        Pedido recibido
                                    </c:when>
                                    <c:when test="${compra.estado == 5}">
                                        Pago rechazado
                                    </c:when>
                                    <c:otherwise>
                                        Desconocido
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="Controlador?accion=VerDetalleCompraAdmin&CodCompra=${compra.codCompra}" class="btn btn-primary">Ver Compra</a>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>

        <footer style="margin-top: 100px;">
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>  
    </body>
</html>
