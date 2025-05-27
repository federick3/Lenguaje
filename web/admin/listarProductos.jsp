<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String username = (session != null) ? (String) session.getAttribute("usuario") : null;
    String rol = (session != null) ? (String) session.getAttribute("rol") : null;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Administrar Productos</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="admin.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/Footer.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

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
        <div class="container-fluid"> <!-- Cambia container-xl por container-fluid -->
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2>Administrar <b>Productos</b></h2>
                            </div>
                            <div class="col-sm-6">
                                <a href="#agregarProducto" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Agregar producto</span></a>

                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Foto</th>
                                <th>Id</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Precio</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="producto" items="${productos}">
                                <tr>
                                    <!-- Imagen del producto -->
                                    <td><img src="assets/productos/${producto.idProductos}.png" alt="${producto.nombre}" width="50" height="50"/></td>
                                    <!-- ID del producto -->
                                    <td>${producto.idProductos}</td>
                                    <!-- Nombre del producto -->
                                    <td>${producto.nombre}</td>
                                    <!-- Descripción del producto -->
                                    <td>${producto.descripcion}</td>
                                    <!-- Precio del producto -->
                                    <td class="price">S/. ${producto.precio}</td>

                                    <td>


                                        <a href="#eliminarProducto" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                    </td>   
                                </tr>
                            </c:forEach>


                        </tbody>
                    </table>
                </div>
            </div>        
        </div>
        <!-- Edit Modal HTML -->
        <div id="agregarProducto" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="Controlador" method="POST" enctype="multipart/form-data">
                        <div class="modal-header">						
                            <h4 class="modal-title">Agregar producto</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="tipoProducto">Tipo de producto:</label>
                                <select id="tipoProducto" name="tipoProducto" class="form-control" required>
                                    <option value="">Seleccione un tipo de producto:</option>
                                    <option value="1">Fertilizante</option>
                                    <option value="21">Herramientas - Azadón</option>
                                    <option value="22">Herrmientas - Guantes</option>
                                    <option value="23">Herrmientas - Pala</option>
                                    <option value="23">Herrmientas - Rastrillo</option>
                                    <option value="23">Herrmientas - Tijera de podar</option>
                                    <option value="31">Sistema de riego - Aspersores</option>
                                    <option value="32">Sistema de riego - Manguera</option>
                                    <option value="4">Tierra</option>
                                    <option value="5">Agroquímicos</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Nombre</label>
                                <input type="text" name="txtNom" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label>Descripción</label>
                                <input type="text" name="txtDesc" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Precio</label>
                                <input type="text" name="txtPrecio" class="form-control" required>
                            </div>

                            <!-- Este campo será mostrado u ocultado según la opción seleccionada -->
                            <div id="fichaTecnicaDiv" class="form-group" style="display: none;">
                                <label>Ficha técnica</label>
                                <input type="text" name="txtFicha" class="form-control">
                            </div>

                            <div class="form-group">
                                <label>Foto</label>
                                <input type="file" name="fileFoto" class="form-control" required>
                            </div>					
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                            <input type="submit" name="accion" class="btn btn-success" value="Guardar">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Delete Modal HTML -->
        <div id="eliminarProducto" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form method="post" action="Controlador">
                        <div class="modal-header">						
                            <h4 class="modal-title">Eliminar producto</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>¿Está seguro de que desea eliminar este producto?</p>
                            <p class="text-warning"><small>Esta acción no puede ser revertida.</small></p>
                            <input type="hidden" name="accion" value="Borrar"> <!-- Acción 'Borrar' -->
                            <input type="hidden" name="idProducto" id="idProductoEliminar"> <!-- Campo para almacenar el ID del producto -->
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                            <input type="submit" class="btn btn-danger" value="Eliminar">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/funciones.js" type="text/javascript"></script>
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
        <script>
            document.getElementById("tipoProducto").addEventListener("change", function () {
                var tipoProducto = this.value;
                var fichaTecnicaDiv = document.getElementById("fichaTecnicaDiv");

                // Muestra el campo de "Ficha técnica" si se seleccionan las opciones 1 o 5
                if (tipoProducto == "1" || tipoProducto == "5") {
                    fichaTecnicaDiv.style.display = "block";
                } else {
                    fichaTecnicaDiv.style.display = "none";
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>  
    </body>
</html>