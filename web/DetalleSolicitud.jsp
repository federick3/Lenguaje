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
        <title>Detalles de la Solicitud</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/Footer.css">
        <link rel="stylesheet" href="css/header.css">
        <style>
            .detalle-container {
                margin-top: 50px !important;
                padding: 20px;
                display: flex;
                align-items: flex-start;
                gap: 400px;
                margin-bottom: 50px !important;
            }
            .detalle-info {
                flex: 1;
                margin-left: 350px;
                max-width: 600px;

            }
            .detalle-item {
                padding: 10px 0;
                border-bottom: 1px solid #ddd;
            }
            .detalle-label {
                font-weight: 500;
                color: #555;
            }
            .detalle-value {
                color: #333;
            }
            .detalle-icono {
                margin-top: 100px;
                margin-right: 350px;
                text-align: center;
                max-width: 150px;
            }
            .detalle-icono img {
                width: 200px;
                height: 200px;
                margin-bottom: 10px;
            }
            .detalle-mensaje {
                font-size: 1em;
                color: #666;
            }
        </style>
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
        <div class="detalle-container mt-5">
            <!-- Información de la solicitud -->
            <div class="detalle-info">
                <h2>Detalles de la Solicitud</h2>
                <div class="detalle-item">
                    <span class="detalle-label">Código de solicitud:</span>
                    <span class="detalle-value">${s.codSolicitud}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">Nombre:</span>
                    <span class="detalle-value">${s.nombre}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">Empresa:</span>
                    <span class="detalle-value">${s.empresa}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">DNI o RUC:</span>
                    <span class="detalle-value">${s.nDocumento}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">Email:</span>
                    <span class="detalle-value">${s.email}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">Teléfono:</span>
                    <span class="detalle-value">${s.telefono}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">Departamento:</span>
                    <span class="detalle-value">${s.departamento}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">Provincia:</span>
                    <span class="detalle-value">${s.provincia}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">Distrito:</span>
                    <span class="detalle-value">${s.distrito}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">Tipo de Cliente:</span>
                    <span class="detalle-value">${s.tipoCliente}</span>
                </div>

                <div class="detalle-item">
                    <span class="detalle-label">Mensaje:</span>
                    <span class="detalle-value">${s.mensaje}</span>
                </div>
                <div class="detalle-item">
                    <span class="detalle-label">Estado:</span>
                    <span class="detalle-value">${s.estado}</span>
                </div>
                <div class="detalle-item">
                    <span class="detalle-label">Fecha de la solicitud:</span>
                    <span class="detalle-value">${s.fechaSolicitud}</span>
                </div>
            </div>

            <!-- Ícono de atención al cliente -->
            <div class="detalle-icono">
                <img src="assets/atencion.webp" alt="Atención al Cliente">
                <p class="detalle-mensaje">Su solicitud será contestada a la brevedad mediante el correo proporcionado</p>
            </div>
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
    </body>
</html>
