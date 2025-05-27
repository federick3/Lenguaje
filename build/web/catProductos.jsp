<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String username = (session != null) ? (String) session.getAttribute("usuario") : null;
    String rol = (session != null) ? (String) session.getAttribute("rol") : null;
%>


<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AgroPiura</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/catProductos.css">
        <link rel="stylesheet" href="css/Footer.css">
        <link rel="stylesheet" href="styles.css">


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

                        <c:set var="contador" value="${sessionScope.contador != null ? sessionScope.contador : 0}" />
                        <div class="carrito">
                            <a href="Controlador?accion=VerCarrito">(<label style="color: white">${contador}</label>)
                                <img src="assets/carrito.png" alt="carrito" width="40px">
                            </a>
                        </div>
                    </div>
                </div>
            </nav>  
        </header>
        <section class="hero-section">
            <div class="hero-content">
                <h1>PRODUCTOS</h1>
            </div>
        </section>

        <main>
            <div class="container catProductos">
                <div class="row text-center">
                    <div class="col">
                        <div class="image-container">
                            <img src="assets/cat/agro.png" alt="Agroquimicos" width="250" height="250">
                            <div class="item-text mt-2">
                                <a href="Controlador?accion=FiltrarPorTipoProducto&tipoProducto=5" style="text-decoration: none; color: inherit;">AGROQUÍMICOS</a>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="image-container">
                            <img src="assets/cat/arroz.png" alt="Fertilizante" width="250" height="250">
                            <div class="item-text mt-2">
                                <a href="Controlador?accion=FiltrarPorTipoProducto&tipoProducto=1" style="text-decoration: none; color: inherit;">FERTILIZANTES</a>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="image-container">
                            <img src="assets/cat/tierra.png" alt="Tierra" width="250" height="250">
                            <div class="item-text mt-2">
                                <a href="Controlador?accion=FiltrarPorTipoProducto&tipoProducto=4" style="text-decoration: none; color: inherit;">TIERRA</a>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="image-container">
                            <img src="assets/cat/papa.png" alt="Sistema de Riego" width="250" height="250">
                            <div class="item-text mt-2">
                                <a href="http://localhost:8080/AgroPiura/catRiego.jsp" style="text-decoration: none; color: inherit;">SISTEMA DE RIEGO</a>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="image-container">
                            <img src="assets/cat/tomate.png" alt="Herramientas" width="250" height="250">
                            <div class="item-text mt-2">
                                <a href="http://localhost:8080/AgroPiura/catHerramientas.jsp" style="text-decoration: none; color: inherit;">HERRAMIENTAS</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
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



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>   
    </body>
</html>
