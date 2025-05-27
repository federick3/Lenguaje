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
        <link rel="stylesheet" href="css/Footer.css">
        <link href="css/carousel.rtl.css" rel="stylesheet">
        <link rel="stylesheet" href="css/Elegirnos.css">
        <link rel="stylesheet" href="css/ProductosHome.css">
        <link rel="stylesheet" href="styles.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

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

        <main>

            <div id="myCarousel" class="carousel slide mb-6" data-bs-ride="carousel">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="assets/carrusel/1.png" class="d-block w-100" alt="Descripción de la imagen">
                        <div class="container">
                            <div class="carousel-caption text-start">
                                <h1>¿Buscas productos de la mejor calidad?</h1>
                                <p><a class="btn btn-lg btn-primary" href="http://localhost:8080/AgroPiura/catProductos.jsp">Encuéntralos aquí</a></p>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="assets/carrusel/2.png" class="d-block w-100" alt="Descripción de la imagen">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>¿Quiénes somos?</h1>
                                <p><a class="btn btn-lg btn-primary" href="http://localhost:8080/AgroPiura/Nosotros.jsp">Conócenos mejor</a></p>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="assets/carrusel/3.png" class="d-block w-100" alt="Descripción de la imagen">
                        <div class="container">
                            <div class="carousel-caption text-end">
                                <h1>¿Quieres contactarte con nosotros?</h1>
                                <p><a class="btn btn-lg btn-primary" href="http://localhost:8080/AgroPiura/Contactanos.jsp">Hazlo aquí</a></p>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">السابق</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">التالي</span>
                </button>
            </div>

            <div class="elegirnos">
                <div class="elegirnos-contenedor">
                    <strong><p>Tenemos el fertilizante que tu cultivo necesita</p></strong>
                    <h1>¿Por qué elegirnos?</h1>
                    <div class="features">
                        <div class="feature">
                            <div class="feature-icon">R</div>
                            <h3>Respaldo</h3>
                            <p>Somos parte de Equilibra Perú, empresa formada por Grupo Romero y Mitsui</p>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">✓</div>
                            <h3>Productos de Calidad</h3>
                            <p>Tenemos un exigente control de calidad para garantizar un cultivo exitoso.</p>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">🌎</div>
                            <h3>Cobertura</h3>
                            <p>Contamos con distribuidores autorizados a nivel nacional e internacional</p>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">🤝</div>
                            <h3>Alianzas Estratégicas</h3>
                            <p>Con proveedores de insumos y especialidades líderes a nivel global como: ICL, Fertium, etc.</p>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">🧬</div>
                            <h3>Tecnología</h3>
                            <p>Innovamos con productos para ofrecer el mejor rendimiento a tu cultivo</p>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">📞</div>
                            <h3>Servicio al Cliente</h3>
                            <p>Tenemos un equipo de asesores capacitados que te orientarán en el desarrollo y gestión de tu cultivo</p>
                        </div>
                    </div>
                </div>       
            </div>



            <div class="container marketing">
                <div class="titulo">
                    <h1>Nuestros clientes nos respaldan</h1>
                </div>
                <div id="carouselReseñas" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <div class="d-flex justify-content-center">
                                <div class="col-lg-4 text-center mx-4">
                                    <img src="assets/hombre.png" alt="Hombre" class="bd-placeholder-img rounded-circle usuario-icono" width="200" height="200">
                                    <h2 class="fw-normal">Usuario</h2>
                                    <p>Buenazo todo lo que venden acá. Compré fertilizantes para mis paltos y ya se nota la diferencia. Además, me explicaron cómo usar todo bien. Súper recomendado, volveré sin duda.</p>
                                </div>
                                <div class="col-lg-4 text-center mx-4">
                                    <img src="assets/mujer.png" alt="Mujer" class="bd-placeholder-img rounded-circle usuario-icono" width="200" height="200">
                                    <h2 class="fw-normal">Usuario</h2>
                                    <p>Es la mejor tienda de productos agrícolas en Piura. Tienen una gran variedad de insumos y me encanta la rapidez con la que gestionan los pedidos. Mis cultivos han mejorado desde que empecé a comprar aquí. ¡Totalmente recomendable!</p>
                                </div>
                                <div class="col-lg-4 text-center mx-4">
                                    <img src="assets/hombre.png" alt="Hombre" class="bd-placeholder-img rounded-circle usuario-icono" width="200" height="200">
                                    <h2 class="fw-normal">Usuario</h2>
                                    <p>Todo perfecto. Tienen de todo y los precios están bien para la calidad. Me ayudaron a elegir lo que necesitaba para mis tomates. Gente chévere, muy atentos.</p>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="d-flex justify-content-center">
                                <div class="col-lg-4 text-center mx-4">
                                    <img src="assets/mujer.png" alt="Mujer" class="bd-placeholder-img rounded-circle usuario-icono" width="200" height="200">
                                    <h2 class="fw-normal">Usuario</h2>
                                    <p>Los insumos que compré fueron increíbles. ¡Los resultados en mis cultivos son notables! Gracias por el excelente servicio.</p>
                                </div>
                                <div class="col-lg-4 text-center mx-4">
                                    <img src="assets/hombre.png" alt="Hombre" class="bd-placeholder-img rounded-circle usuario-icono" width="200" height="200">
                                    <h2 class="fw-normal">Usuario</h2>
                                    <p>Servicio al cliente excelente. Me ayudaron en todo momento y los productos son de primera calidad. Recomendadísimo.</p>
                                </div>
                                <div class="col-lg-4 text-center mx-4">
                                    <img src="assets/mujer.png" alt="Mujer" class="bd-placeholder-img rounded-circle usuario-icono" width="200" height="200">
                                    <h2 class="fw-normal">Usuario</h2>
                                    <p>Me gusta mucho la variedad que tienen. Encuentro todo lo que necesito para mis proyectos agrícolas en un solo lugar.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselReseñas" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Anterior</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselReseñas" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Siguiente</span>
                    </button>
                </div>
            </div>






            <!-- Products Section -->
            <div class="products-section">
                <div class="container">
                    <h2>Algunos de nuestros productos</h2>
                    <div class="products">
                        <div class="product-card">
                            <img src="assets/productos/1.png" alt="Producto 1">
                            <h3>AMINOTERRA PLUS ZN</h3>
                            <a href="http://localhost:8080/AgroPiura/Controlador?accion=VerProducto&idProductos=1">
                                <button>LEER MÁS</button>
                            </a>
                        </div>
                        <div class="product-card">
                            <img src="assets/productos/7.png" alt="Producto 2">
                            <h3>FERTILIZANTE</h3>
                            <a href="http://localhost:8080/AgroPiura/Controlador?accion=VerProducto&idProductos=7">
                                <button>LEER MÁS</button>
                            </a>
                        </div>
                        <div class="product-card">
                            <img src="assets/productos/3.png" alt="Producto 3">
                            <h3>BIOAMINO-L</h3>
                            <a href="http://localhost:8080/AgroPiura/Controlador?accion=VerProducto&idProductos=3">
                                <button>LEER MÁS</button>
                            </a>
                        </div>
                        <div class="product-card">
                            <img src="assets/productos/8.png" alt="Producto 4">
                            <h3>UREA</h3>
                            <a href="http://localhost:8080/AgroPiura/Controlador?accion=VerProducto&idProductos=8">
                                <button>LEER MÁS</button>
                            </a>
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
