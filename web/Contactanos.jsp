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
        <title>Contáctanos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/Footer.css">
        <style>
            body {
                font-family: Arial, sans-serif !important;
                background-color: #f4f7fa;
            }
            .container{
                margin-bottom: 100px;
            }
            .formulario-container {
                max-width: 600px;
                margin-right: 50px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding:20px;
            }
            .form-control {
                border: 1px solid #ccc;
                border-radius: 4px;
                transition: border-color 0.3s;
                box-shadow: none;
                margin-bottom: 20px;
            }

            .form-control:focus {
                border-color: #007bff;
                outline: none;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }

            input[type="text"], select, input[type="file"], textarea {
                border: 1px solid #ccc;
                border-radius: 4px;
                transition: border-color 0.3s;
                width: 100%;
            }

            input[type="text"]:focus, select:focus, input[type="file"]:focus, textarea:focus {
                border-color: #007bff;
                outline: none;
            }

            .btn-success{
                border:0;
                background-color: #004b23;
                color:white;
            }


            .mapa {
                margin-top: 15px;
                margin-bottom: 15px;
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
        <div class="container mt-5">
            <div class="row">
                <!-- Formulario -->
                <div class="col-md-6 formulario-container">
                    <form action="Controlador" method="POST">
                        <input type="hidden" name="accion" value="EnviarSolicitud">
                        <label for="nombre">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" class="form-control" required>

                        <label for="empresa">Empresa:</label>
                        <input type="text" id="empresa" name="empresa" class="form-control" required>

                        <label for="ndocumento">DNI o RUC:</label>
                        <input type="text" id="ndocumento" name="ndocumento" class="form-control" required>

                        <label for="email">Email:</label>
                        <input type="text" id="email" name="email" class="form-control" required>

                        <label for="telefono">Teléfono:</label>
                        <input type="text" id="telefono" name="telefono" class="form-control" required>

                        <div class="row">
                            <div class="col">
                                <label for="departamento">Departamento:</label>
                                <input type="text" id="departamento" name="departamento" class="form-control" required>
                            </div>
                            <div class="col">
                                <label for="provincia">Provincia:</label>
                                <input type="text" id="provincia" name="provincia" class="form-control" required>
                            </div>
                            <div class="col">
                                <label for="distrito">Distrito:</label>
                                <input type="text" id="distrito" name="distrito" class="form-control" required>
                            </div>      
                        </div>
                        <label for="tipoCliente">Tipo de cliente:</label>
                        <select id="tipoCliente" name="tipoCliente" class="form-control" required>
                            <option value="">Selecciona un tipo de cliente</option>
                            <option value="Agroindustria">Agroindustria</option>
                            <option value="Distribuidor">Distribuidor</option>
                            <option value="Persona Natural">Persona natural</option>
                            <option value="Estudiante">Estudiante</option>
                        </select>
                        <label for="mensaje">Mensaje:</label>
                        <textarea class="form-control" rows="4" id="mensaje" name="mensaje" placeholder="Mensaje"></textarea>
                        <button type="submit" class="btn btn-success">Enviar solicitud</button>
                    </form>
                </div>

                <!-- Contenedor del mapa -->
                <div class="col-md-6 mapa-container">
                    <!-- Título y datos -->
                    <h2>Ubícanos en</h2>


                    <!-- Mapa -->
                    <div class="mapa">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d15898.361591038396!2d-80.57088683364917!3d-5.007484663666493!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x904a09c464e1c611%3A0x536244894e726b1a!2sagropiura%20SAC!5e0!3m2!1ses-419!2spe!4v1730944396816!5m2!1ses-419!2spe" width="100%" height="300" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>      
                    </div>
                    <p><strong>Teléfono:</strong> +51 958 623 176</p>
                    <p><strong>Email:</strong> contacto@agropiura.com</p>
                </div>
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
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>  
    </body>
</html>
