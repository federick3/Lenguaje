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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="css/Footer.css">       
        <link href="css/carousel.rtl.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif !important;

                background-color: #f4f7fa;
            }

            .container-compra {
                margin-left: 350px;
                margin-top: 50px;
                margin-bottom: 100px;
                max-height: 800px !important;
                max-width: 600px;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: left;
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
            }

            input[type="text"], select, input[type="file"] {
                border: 1px solid #ccc;
                border-radius: 4px;
                transition: border-color 0.3s;
                width: 100%; /* Ajuste del ancho por defecto */
            }

            input[type="text"]:focus, select:focus, input[type="file"]:focus {
                border-color: #007bff;
                outline: none;
            }

            /* Clases para el tamaño individual de los inputs */
            .input-dos-columnas {
                width: calc(50% - 10px); /* Ajusta el ancho para dejar espacio entre columnas */
            }

            .input-completo {
                width: 100%;
            }

            /* Espacio entre columnas */
            .form-row {
                display: flex;
                flex-wrap: wrap;
                gap: 10px; /* Espacio entre columnas */
            }

            button {
                width: 100%;
                background-color: #007bff;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #0056b3;
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
                            <a class="nav-link active" aria-current="page" href="http://localhost:8080/Integrador/home.jsp">INICIO</a>
                            <a class="nav-link" href="http://localhost:8080/Integrador/catProductos.jsp">PRODUCTOS</a>
                            <a class="nav-link" href="http://localhost:8080/Integrador/Nosotros.jsp">NOSOTROS</a>
                            <a class="nav-link" href="http://localhost:8080/Integrador/Contactanos.jsp">CONTÁCTANOS</a>
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
        <main class="container-compra">
            <h2>Ingrese datos para finalizar la compra</h2>
            <form action="Controlador" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="accion" value="FinalizarCompra">

                <div class="form-group">
                    <label for="receptor">Receptor:</label>
                    <input type="text" id="receptor" name="receptor" class="form-control" required>
                </div>


                <!-- Fila 1: tipoDocumento y nDocumento -->
                <div class="form-row">
                    <div class="form-group input-dos-columnas">
                        <label for="tipoDocumento">Tipo de documento:</label>
                        <select id="tipoDocumento" name="tipoDocumento" class="form-control" required>
                            <option value="">Selecciona un tipo de documento</option>
                            <option value="1">DNI</option>
                            <option value="2">RUC</option>
                            <option value="3">Otro</option>
                        </select>
                    </div>
                    <div class="form-group input-dos-columnas">
                        <label for="dni">Número de documento:</label>
                        <input type="text" id="dni" name="dni" class="form-control" required>
                    </div>
                </div>

                <!-- Fila 2: Departamento y Provincia -->
                <div class="form-row">
                    <div class="form-group input-dos-columnas">
                        <label for="departamento">Departamento:</label>
                        <input type="text" id="departamento" name="departamento" class="form-control" required>
                    </div>
                    <div class="form-group input-dos-columnas">
                        <label for="provincia">Provincia:</label>
                        <input type="text" id="provincia" name="provincia" class="form-control" required>
                    </div>
                </div>

                <!-- Fila 3: Distrito y Dirección -->
                <div class="form-row">
                    <div class="form-group input-dos-columnas">
                        <label for="distrito">Distrito:</label>
                        <input type="text" id="distrito" name="distrito" class="form-control" required>
                    </div>
                    <div class="form-group input-dos-columnas">
                        <label for="direccion">Dirección:</label>
                        <input type="text" id="direccion" name="direccion" class="form-control" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="metodoPago">Método de Pago:</label>
                    <select id="metodoPago" name="metodoPago" class="form-control" required>
                        <option value="">Selecciona un método</option>
                        <option value="Yape">Yape: 958623176</option>
                        <option value="Plin">Plin: 958623166</option>
                        <option value="Transferencia Bancaria">Transferencia bancaria: 838-234-24243434567-53</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="comprobante">Comprobante de Pago:</label>
                    <input type="file" id="comprobante" name="comprobante" accept="application/pdf,image/*" class="form-control" required>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-success">Enviar Compra</button>
                </div>
            </form>
            <div class="cart-container">
                <h2>Carrito</h2>

                <!-- Iterating over the cart items -->
                <c:forEach var="carrito" items="${carrito}">
                    <div class="cart-item">
                        <input type="hidden" id="idp" value="${carrito.idProductos}">

                        <div class="item-details">
                            <!-- Product image -->
                            <img src="assets/productos/${carrito.idProductos}.png" alt="${carrito.nombre}" class="product-image">

                            <!-- Product details and price -->
                            <div class="item-description">
                                <p><strong>${carrito.nombre}</strong></p>

                                <!-- Cantidad debajo del nombre del producto -->
                                <div class="quantity-controls">
                                    <button class="btn-minus">-</button>
                                    <input type="number" id="Cantidad" value="${carrito.cantidad}" class="form-control" min="1" style="width: 40px;">
                                    <button class="btn-plus">+</button>
                                    <a href="#" id="btnDelete" class="delete-icon">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </div>

                            <!-- Precio a la derecha -->
                            <div class="item-price">
                                <span>S/. ${carrito.precioCompra}</span>
                            </div>
                        </div>

                        <!-- Subtotal -->
                        <div class="item-subtotal">
                            <span>Subtotal: S/. <span class="subtotal-amount">${carrito.subTotal}</span></span>
                        </div>
                    </div>
                </c:forEach>

                <!-- Cart summary for total -->
                <div class="cart-summary">
                    <h3>Total: <span id="total">S/. ${totalPagar}</span></h3>
                </div>




            </div>
        </main>


        <script>
            document.querySelector('button[type="submit"]').addEventListener('click', function (event) {
            <% if (nombreUsuario == null) { %>
                event.preventDefault(); // Evita que se envíe el formulario
                Swal.fire({
                    icon: 'warning',
                    title: 'Inicie sesión para comprar',
                    text: 'Por favor, inicie sesión para finalizar la compra',
                    confirmButtonText: 'Iniciar sesión'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'InicioSesion.jsp'; // Redirige a la página de inicio de sesión
                    }
                });
            <% }%>
            });
        </script>

        <script>
            document.querySelector("form").addEventListener("submit", function (event) {
                const tipoDocumento = document.getElementById("tipoDocumento").value;
                const numeroDocumento = document.getElementById("dni").value.trim();

                let error = "";

                // Validaciones según tipo de documento
                if (tipoDocumento === "1") { // DNI
                    if (!/^\d{8}$/.test(numeroDocumento)) {
                        error = "El DNI debe contener exactamente 8 números.";
                    }
                } else if (tipoDocumento === "2") { // RUC
                    if (!/^\d{11}$/.test(numeroDocumento)) {
                        error = "El RUC debe contener exactamente 11 números.";
                    }
                } else if (tipoDocumento === "3") { // Otro
                    if (!/^\d{11}$/.test(numeroDocumento)) {
                        error = "El documento ingresado debe contener almenos 11 digitos";
                    }
                } else {
                    error = "Debes seleccionar un tipo de documento.";
                }

                // Si hay un error, prevenir envío y mostrar alerta
                if (error !== "") {
                    event.preventDefault(); // Detiene el envío del formulario
                    alert(error);
                    document.getElementById("dni").focus();
                }
            });
        </script>


        <footer>
            <div style="display: flex; justify-content: space-around; margin: auto;">

                <div style="flex: 1; text-align: center; margin-left: 125px;">
                    <img src="assets/logo.png" alt="AgroPiura" style="max-width: 300px; margin-bottom: 15px;">
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="js/funciones.js" type="text/javascript"></script>


        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>