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
        <title>Nosotros | AGROPIURA</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                font-family: 'Arial', sans-serif !important;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
                color: #333;
            }
            .container {
                max-width: 1200px;
                margin: auto;
                padding: 20px;
            }

            .carousel-item {
                height: 200px; /* Altura fija para todas las imágenes del carrusel */
                background-size: cover;
                background-position: center;
            }

            .carousel-caption {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                text-align: center;
                color: white;
                font-size: 2rem;
            }

            .about-section {
                display: flex;
                align-items: center;
                gap: 20px;
                margin: 40px 0;
            }
            .about-section img {
                max-width: 50%;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .about-text {
                flex: 1;
                text-align: justify;
            }
            .about-text h2 {
                color: #007b3f;
                font-size: 2em;
                margin-bottom: 10px;
            }
            .section .content {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 20px;
            }
            /* Animación para la entrada de las cards */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Animación para la entrada de las cards */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Animación inicial para las cards */
            .card {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                padding: 20px;
                flex: 1;
                max-width: 30%;
                text-align: center;
                opacity: 0; /* Comienza invisible */
                animation: fadeInUp 0.8s ease forwards;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            /* Efecto "hover" para las cards */
            .card:hover {
                transform: translateY(-20px); /* Se levanta más al hacer hover */
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3); /* Sombra más pronunciada */
            }

            /* Retraso para cada card para hacer un efecto escalonado */
            .card:nth-child(1) {
                animation-delay: 0s;
            }
            .card:nth-child(2) {
                animation-delay: 0.2s;
            }
            .card:nth-child(3) {
                animation-delay: 0.4s;
            }

            .card img {
                width: 100px;
                height: 100px;
                margin: 0 auto 15px auto;
                display: block;
            }
            .card h3 {
                color: #007b3f;
                margin-bottom: 10px;
            }
            .card p, .card ul {
                font-size: 1em;
                color: #555;
                text-align: justify;
            }
            .card ul {
                list-style: none;
                padding: 0;
            }
            .card ul li {
                font-size: 0.9em;
                margin-bottom: 5px;
            }

            .carousel-caption{
                font-size: 3.5em;
                margin: 0;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);

            }
            @media (max-width: 768px) {
                .about-section {
                    flex-direction: column;
                    text-align: center;
                }
                .about-section img {
                    max-width: 100%;
                }
                .card {
                    max-width: 100%;
                }
            }
        </style>
        <link rel="stylesheet" href="css/Footer.css">
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
        <div class="container">
            <!-- Carrusel Hero -->
            <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000" data-bs-pause="false">
                <div class="carousel-inner">
                    <div class="carousel-item active" style="background-image: url('assets/granja.jpg');">
                        <div class="carousel-caption">
                            <h1>Conoce AGROPIURA</h1>
                        </div>
                    </div>
                    <div class="carousel-item" style="background-image: url('assets/pasto.jpg');">
                        <div class="carousel-caption">
                            <h1>Conoce AGROPIURA</h1>
                        </div>
                    </div>
                    <div class="carousel-item" style="background-image: url('assets/trigo.jpg');">
                        <div class="carousel-caption">
                            <h1>Conoce AGROPIURA</h1>
                        </div>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>



            <!-- ¿Quiénes somos? -->
            <section class="about-section">
                <img src="assets/n1.jpg" alt="Imagen de AGROPIURA">
                <div class="about-text">
                    <h2>¿Quiénes somos?</h2>
                    <p>En <strong>AGROPIURA</strong>, nos dedicamos a la producción y comercialización de productos agrícolas de alta calidad, comprometidos con la sostenibilidad y el bienestar de nuestros consumidores. Nuestra pasión por la agricultura nos impulsa a cultivar con excelencia, garantizando que cada producto que llega a su mesa cumpla con los más altos estándares de frescura y sabor.</p>
                </div>
            </section>

            <!-- Misión, Visión y Valores -->
            <section class="section">
                <div class="content">
                    <div class="card">
                        <img src="assets/mision.png" alt="Misión">
                        <h3>Misión</h3>
                        <p>Proporcionar productos agrícolas de calidad superior, promoviendo prácticas sostenibles que protejan el medio ambiente y beneficien a nuestros agricultores.</p>
                    </div>
                    <div class="card">
                        <img src="assets/vision.png" alt="Visión">
                        <h3>Visión</h3>
                        <p>Ser la empresa líder en el sector agrícola, reconocida por nuestra innovación y compromiso con la calidad.</p>
                    </div>
                    <div class="card">
                        <img src="assets/valores.png" alt="Valores">
                        <h3>Valores</h3>
                        <ul>
                            <li><strong>Calidad:</strong> Productos que superen expectativas.</li>
                            <li><strong>Sostenibilidad:</strong> Protección del medio ambiente.</li>
                            <li><strong>Transparencia:</strong> Comunicación honesta.</li>
                            <li><strong>Innovación:</strong> Mejora continua.</li>
                            <li><strong>Compromiso:</strong> Apoyo a nuestros agricultores.</li>
                        </ul>
                    </div>
                </div>
            </section>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
