package com.lenguaje.controller;

import com.lenguaje.model.Carrito;
import com.lenguaje.model.Compra;
import com.lenguaje.model.CompraDAO;
import com.lenguaje.model.DetalleCompra;
import com.lenguaje.model.Producto;
import com.lenguaje.model.ProductoDAO;
import com.lenguaje.model.Solicitud;
import com.lenguaje.model.SolicitudDAO;
import com.lenguaje.model.detalleCompraDAO;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class Controlador extends HttpServlet {

    ProductoDAO pdao = new ProductoDAO();
    Producto p = new Producto();
    detalleCompraDAO detalleDAO = new detalleCompraDAO();
    CompraDAO compraDAO = new CompraDAO();
    SolicitudDAO solicitudDAO = new SolicitudDAO();
    List<Producto> productos = new ArrayList<>();
    List<Carrito> listaCarrito = new ArrayList<>();
    List<Compra> compras = new ArrayList<>();

    int item;
    double totalPagar = 0.0;
    int cantidad = 1;
    int idp;
    Carrito car = new Carrito();
    String idProductosStr;
    String tipoProductoStr;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        productos = pdao.listar();

        // Obtener la sesión y el contador del carrito
        HttpSession session = request.getSession();
        Integer contador = (Integer) session.getAttribute("contador");
        if (contador == null) {
            contador = 0; // Inicializar el contador si es null
        }

        switch (accion) {
            case "ComprarProducto":
                totalPagar = 0.0;  // Reiniciar el total
                idProductosStr = request.getParameter("idProductos");
                tipoProductoStr = request.getParameter("tipoProducto"); // Obtener el tipo de producto

                if (idProductosStr != null && !idProductosStr.isEmpty()) {
                    idp = Integer.parseInt(idProductosStr);
                    p = pdao.listarId(idp);

                    boolean productoExistente = false; // Variable para verificar si el producto ya está en el carrito

                    // Recorremos el carrito para verificar si ya existe el producto
                    for (Carrito c : listaCarrito) {
                        if (c.getIdProductos() == p.getIdProductos()) {
                            // Si el producto ya está, aumentamos la cantidad
                            c.setCantidad(c.getCantidad() + 1);
                            c.setSubTotal(c.getCantidad() * c.getPrecioCompra());
                            productoExistente = true;  // Marcamos que el producto ya está en el carrito
                        }
                    }
                    // Si el producto no existe en el carrito, lo agregamos como nuevo
                    if (!productoExistente) {
                        item++;
                        car = new Carrito();
                        car.setItem(item);
                        car.setIdProductos(p.getIdProductos());
                        car.setNombre(p.getNombre());
                        car.setPrecioCompra(p.getPrecio());
                        car.setCantidad(cantidad);
                        car.setSubTotal(cantidad * p.getPrecio());
                        listaCarrito.add(car);
                        contador++; // Incrementar el contador al agregar un producto nuevo
                    }

                    // Calcular el total a pagar sumando los subtotales
                    for (Carrito c : listaCarrito) {
                        totalPagar += c.getSubTotal();
                    }

                    // Actualizar el contador en la sesión
                    session.setAttribute("contador", contador);
                }

                // Volver a aplicar el filtro después de comprar
                if (tipoProductoStr != null && !tipoProductoStr.isEmpty()) {
                    request.setAttribute("productos", pdao.listarPorTipoProducto(Integer.parseInt(tipoProductoStr)));
                } else {
                    request.setAttribute("productos", productos);
                }

                request.setAttribute("carrito", listaCarrito);
                request.setAttribute("totalPagar", totalPagar);
                request.getRequestDispatcher("verCarrito.jsp").forward(request, response);
                break;

            case "AgregarCarrito":
                totalPagar = 0.0;  // Reiniciar el total
                idProductosStr = request.getParameter("idProductos");
                tipoProductoStr = request.getParameter("tipoProducto"); // Obtener el tipo de producto

                // Si tipoProducto es nulo o está vacío, asignamos un valor por defecto
                if (tipoProductoStr == null || tipoProductoStr.isEmpty()) {
                    tipoProductoStr = "1"; // Por defecto, tipoProducto = 1 (ajusta según tu necesidad)
                }

                if (idProductosStr != null && !idProductosStr.isEmpty()) {
                    idp = Integer.parseInt(idProductosStr);
                    p = pdao.listarId(idp);

                    boolean productoExistente = false;  // Variable para verificar si el producto ya está en el carrito

                    // Recorremos el carrito para verificar si ya existe el producto
                    for (Carrito c : listaCarrito) {
                        if (c.getIdProductos() == p.getIdProductos()) {
                            // Si el producto ya está, aumentamos la cantidad
                            c.setCantidad(c.getCantidad() + 1);
                            c.setSubTotal(c.getCantidad() * c.getPrecioCompra());
                            productoExistente = true;  // Marcamos que el producto ya está en el carrito
                            break;
                        }
                    }

                    // Si el producto no existe en el carrito, lo agregamos como nuevo
                    if (!productoExistente) {
                        item++;
                        car = new Carrito();
                        car.setItem(item);
                        car.setIdProductos(p.getIdProductos());
                        car.setNombre(p.getNombre());
                        car.setPrecioCompra(p.getPrecio());
                        car.setCantidad(cantidad);
                        car.setSubTotal(cantidad * p.getPrecio());
                        listaCarrito.add(car);
                        contador++; // Incrementar el contador al agregar un producto nuevo
                    }

                    // Calcular el total a pagar sumando los subtotales
                    for (Carrito c : listaCarrito) {
                        totalPagar += c.getSubTotal();
                    }

                    // Actualizar el contador en la sesión
                    session.setAttribute("contador", contador);
                }

                // Aplicar el filtro de productos por tipo
                request.setAttribute("productos", pdao.listarPorTipoProducto(Integer.parseInt(tipoProductoStr)));

                // Mantener el filtro en la redirección
                request.getRequestDispatcher("index.jsp?tipoProducto=" + tipoProductoStr).forward(request, response);
                break;

            case "Delete":
                int idproducto = Integer.parseInt(request.getParameter("idp"));
                for (int i = 0; i < listaCarrito.size(); i++) {
                    if (listaCarrito.get(i).getIdProductos() == idproducto) { // Comparación directa para int
                        listaCarrito.remove(i); // Elimina el producto del carrito
                        contador--; // Decrementa el contador
                        break; // Detiene el ciclo una vez que se encuentra el producto
                    }
                }

                // Recalcular el total después de eliminar el producto
                totalPagar = 0.0;
                for (Carrito c : listaCarrito) {
                    totalPagar += c.getSubTotal();
                }

                // Actualiza el contador y el carrito en la sesión
                session.setAttribute("contador", contador);
                session.setAttribute("carrito", listaCarrito);

                // Envía los datos actualizados de vuelta a la vista
                request.setAttribute("totalPagar", totalPagar);
                request.setAttribute("carrito", listaCarrito);

                // Redirige a la vista del carrito
                request.getRequestDispatcher("verCarrito.jsp").forward(request, response);
                break;

            case "VerProducto":
                try {
                int idProducto = Integer.parseInt(request.getParameter("idProductos"));
                Producto producto = pdao.listarId(idProducto);

                if (producto.getIdProductos() == 0) {
                    throw new IllegalArgumentException("Producto no encontrado");
                }

                request.setAttribute("producto", producto);
                request.setAttribute("contador", contador); // Mostrar el contador en la vista
                request.getRequestDispatcher("verProducto.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            break;

            case "VerCarrito":
                request.setAttribute("carrito", listaCarrito);
                request.setAttribute("totalPagar", totalPagar);
                request.getRequestDispatcher("verCarrito.jsp").forward(request, response);
                break;

            case "ActualizarCantidad":
                int idpro = Integer.parseInt(request.getParameter("idp"));
                int cant = Integer.parseInt(request.getParameter("Cantidad"));

                double subtotal = 0.0;
                // Actualizar la cantidad y subtotal del producto
                for (int i = 0; i < listaCarrito.size(); i++) {
                    if (listaCarrito.get(i).getIdProductos() == idpro) {
                        listaCarrito.get(i).setCantidad(cant);
                        subtotal = listaCarrito.get(i).getPrecioCompra() * cant;
                        listaCarrito.get(i).setSubTotal(subtotal);
                    }
                }

                // Recalcular el total general del carrito
                totalPagar = 0.0;
                for (Carrito c : listaCarrito) {
                    totalPagar += c.getSubTotal();
                }

                // Enviar subtotal y total como respuesta
                response.setContentType("application/json");
                response.getWriter().write("{\"subtotal\": " + subtotal + ", \"totalPagar\": " + totalPagar + "}");
                break;

            case "admin":
                productos = pdao.listar();  // Obtener la lista de productos
                request.setAttribute("productos", productos);  // Pasar la lista de productos a la vista
                request.getRequestDispatcher("admin/listarProductos.jsp").forward(request, response);
                break;

            case "Guardar":
                InputStream inputStream = null;
                try {
                    int tipoProducto = Integer.parseInt(request.getParameter("tipoProducto"));
                    String nom = request.getParameter("txtNom");
                    Double precio = Double.parseDouble(request.getParameter("txtPrecio"));
                    String ficha = request.getParameter("txtFicha");
                    String desc = request.getParameter("txtDesc");
                    Part part = request.getPart("fileFoto"); // Obtener archivo
                    inputStream = part.getInputStream(); // Obtener el InputStream del archivo subido

                    Producto p = new Producto();
                    p.setTipoProducto(tipoProducto);
                    p.setNombre(nom);
                    p.setDescripcion(desc);
                    p.setPrecio(precio);
                    p.setLink(ficha);

                    // Agregar el producto y obtener el ID generado
                    int idProducto = pdao.agregar(p); // Ahora esto devuelve el ID correcto
                    if (idProducto != -1) { // Verifica que el ID es válido
                        String nombreFoto = idProducto + ".png";
                        String ruta = getServletContext().getRealPath("/assets/productos/" + nombreFoto);

                        // Guardar la imagen
                        File archivo = new File(ruta);
                        if (inputStream != null) {
                            try (FileOutputStream outputStream = new FileOutputStream(archivo)) {
                                byte[] buffer = new byte[1024];
                                int bytesRead;
                                while ((bytesRead = inputStream.read(buffer)) != -1) {
                                    outputStream.write(buffer, 0, bytesRead);
                                }
                                System.out.println("Imagen guardada: " + archivo.getAbsolutePath());
                            }
                        } else {
                            System.out.println("El InputStream es nulo. No se puede guardar la imagen.");
                        }
                    } else {
                        System.out.println("Error al obtener el ID del producto.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
                request.setAttribute("productos", productos);
                response.sendRedirect("Controlador?accion=admin");
                break;

            case "Borrar":
                String idProductoStr = request.getParameter("idProducto");

                if (idProductoStr != null && !idProductoStr.isEmpty()) {
                    int idProductoEliminar = Integer.parseInt(idProductoStr);
                    pdao.eliminar(idProductoEliminar);
                } else {
                    System.out.println("El valor de idProducto es nulo o vacío.");
                }

                response.sendRedirect("Controlador?accion=admin");
                break;

            case "FiltrarPorTipoProducto":
                tipoProductoStr = request.getParameter("tipoProducto");
                if (tipoProductoStr != null && !tipoProductoStr.isEmpty()) {
                    int tipoProducto = Integer.parseInt(tipoProductoStr);
                    productos = pdao.listarPorTipoProducto(tipoProducto); // Método que crearemos en el DAO
                }
                request.setAttribute("productos", productos);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;

            case "FinalizarCompra":
                inputStream = null;
                int idCompraGenerada = 0;
                try {
                    // Obtener parámetros del formulario
                    String receptor = request.getParameter("receptor");
                    String direccion = request.getParameter("direccion");
                    String metodoPago = request.getParameter("metodoPago");
                    int numDocumento = Integer.parseInt(request.getParameter("dni"));
                    int tipoDocumento = Integer.parseInt(request.getParameter("tipoDocumento"));
                    String departamento = request.getParameter("departamento");
                    String provincia = request.getParameter("provincia");
                    String distrito = request.getParameter("distrito");

                    // Calcular el total del carrito
                    double totalPagar = 0.0;
                    for (Carrito c : listaCarrito) {
                        totalPagar += c.getSubTotal();
                    }

                    // Obtener el usuario actual de la sesión
                    session = request.getSession();
                    String user = (String) session.getAttribute("nombreUsuario");

                    // Generar un código único para la compra (CodCompra)
                    String codCompra = generarCodigoCompra();

                    // Obtener el archivo del comprobante
                    Part part = request.getPart("comprobante"); // Obtener archivo
                    inputStream = part.getInputStream(); // Obtener el InputStream del archivo subido

                    // Crear objeto Compra
                    Compra compra = new Compra();
                    compra.setUser(user);
                    compra.setTotal(String.valueOf(totalPagar));
                    compra.setReceptor(receptor);
                    compra.setDireccion(direccion);
                    compra.setMetodoPago(metodoPago);
                    compra.setCodCompra(codCompra);
                    compra.setDepartamento(departamento);
                    compra.setProvincia(provincia);
                    compra.setDistrito(distrito);
                    compra.setTipoDocumento(tipoDocumento);
                    compra.setnDocumento(numDocumento);

                    // Guardar la compra en la base de datos y obtener el ID generado
                    idCompraGenerada = compraDAO.agregar(compra);

                    if (idCompraGenerada != -1) { // Si la compra se guardó correctamente
                        // Usar codCompra como nombre para la foto del comprobante
                        String nombreFoto = codCompra + ".png"; // Guardar con codCompra como nombre de archivo
                        String ruta = getServletContext().getRealPath("/assets/comprobantes/" + nombreFoto); // Obtener la ruta completa

                        // Guardar la imagen en el servidor
                        File archivo = new File(ruta);
                        if (inputStream != null) {
                            try (FileOutputStream outputStream = new FileOutputStream(archivo)) {
                                byte[] buffer = new byte[1024];
                                int bytesRead;
                                while ((bytesRead = inputStream.read(buffer)) != -1) {
                                    outputStream.write(buffer, 0, bytesRead);
                                }
                                System.out.println("Imagen guardada: " + archivo.getAbsolutePath());
                            }
                        } else {
                            System.out.println("El InputStream es nulo. No se puede guardar la imagen.");
                        }
                    } else {
                        System.out.println("Error al guardar la compra.");
                    }

                    // Guardar detalles de la compra
                    detalleCompraDAO detalleCompraDAO = new detalleCompraDAO();
                    for (Carrito c : listaCarrito) {
                        DetalleCompra detalle = new DetalleCompra();
                        detalle.setIdCompra(idCompraGenerada);
                        detalle.setIdProductos(c.getIdProductos());
                        detalle.setPrecio(String.valueOf(c.getPrecioCompra()));
                        detalle.setCantidad(c.getCantidad());
                        detalle.setNombre(c.getNombre());
                        detalleCompraDAO.agregar(detalle);
                    }

                    // Obtener la fecha de compra después de la inserción
                    Compra compraGuardada = compraDAO.obtenerCompraPorCodigo(codCompra); // Obtener la compra basada en el código de compra

                    // Pasar la fecha de compra al JSP
                    request.setAttribute("fecha", compraGuardada.getFechaCompra());

                    // Limpiar carrito
                    listaCarrito.clear();
                    session.setAttribute("contador", 0);
                    session.setAttribute("total", 0);

                    // Obtener detalles de la compra
                    List<DetalleCompra> detalles = detalleCompraDAO.obtenerDetallesPorCompraId(idCompraGenerada);
                    request.setAttribute("detalles", detalles);

                    request.setAttribute("id_transaccion", compraGuardada.getCodCompra());
                    request.setAttribute("estado", compraGuardada.getEstado());
                    request.setAttribute("total", compraGuardada.getTotal());
                    request.setAttribute("fecha", compraGuardada.getFechaCompra());
                    request.setAttribute("receptor", compraGuardada.getReceptor());
                    request.setAttribute("tipo", compraGuardada.getTipoDocumento());
                    request.setAttribute("ndocumento", compraGuardada.getnDocumento());
                    request.setAttribute("metodo", compraGuardada.getMetodoPago());
                    request.setAttribute("depa", compraGuardada.getDepartamento());
                    request.setAttribute("provincia", compraGuardada.getProvincia());
                    request.setAttribute("distrito", compraGuardada.getDistrito());
                    request.setAttribute("direccion", compraGuardada.getDireccion());

                    request.getRequestDispatcher("DetalleCompra.jsp").forward(request, response);

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error al finalizar la compra: " + e.getMessage());
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                } finally {
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
                break;
            case "VerDetalleCompraAdmin":
                try {
                String CodCompra = request.getParameter("CodCompra");
                Compra compraGuardada = compraDAO.obtenerCompraPorCodigo(CodCompra);
                List<DetalleCompra> detalles = detalleDAO.obtenerDetallesPorCodCompra(CodCompra);
                request.setAttribute("detalles", detalles);
                request.setAttribute("id_transaccion", compraGuardada.getCodCompra());
                request.setAttribute("estado", compraGuardada.getEstado());
                request.setAttribute("total", compraGuardada.getTotal());
                request.setAttribute("fecha", compraGuardada.getFechaCompra());
                request.setAttribute("receptor", compraGuardada.getReceptor());
                request.setAttribute("tipo", compraGuardada.getTipoDocumento());
                request.setAttribute("ndocumento", compraGuardada.getnDocumento());
                request.setAttribute("metodo", compraGuardada.getMetodoPago());
                request.setAttribute("depa", compraGuardada.getDepartamento());
                request.setAttribute("provincia", compraGuardada.getProvincia());
                request.setAttribute("distrito", compraGuardada.getDistrito());
                request.setAttribute("direccion", compraGuardada.getDireccion());
                request.getRequestDispatcher("admin/DetalleCompraAdmin.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            break;

            case "ListarCompras":
                session = request.getSession();
                String user = (String) session.getAttribute("nombreUsuario");
                compras = compraDAO.obtenerCompraPorUser(user);
                request.setAttribute("compras", compras);
                request.getRequestDispatcher("MisCompras.jsp").forward(request, response);
                break;

            case "VerDetalleCompra":
                try {
                String CodCompra = request.getParameter("CodCompra");
                Compra compraGuardada = compraDAO.obtenerCompraPorCodigo(CodCompra);
                List<DetalleCompra> detalles = detalleDAO.obtenerDetallesPorCodCompra(CodCompra);
                request.setAttribute("detalles", detalles);
                request.setAttribute("id_transaccion", compraGuardada.getCodCompra());
                request.setAttribute("estado", compraGuardada.getEstado());
                request.setAttribute("total", compraGuardada.getTotal());
                request.setAttribute("fecha", compraGuardada.getFechaCompra());
                request.setAttribute("receptor", compraGuardada.getReceptor());
                request.setAttribute("tipo", compraGuardada.getTipoDocumento());
                request.setAttribute("ndocumento", compraGuardada.getnDocumento());
                request.setAttribute("metodo", compraGuardada.getMetodoPago());
                request.setAttribute("depa", compraGuardada.getDepartamento());
                request.setAttribute("provincia", compraGuardada.getProvincia());
                request.setAttribute("distrito", compraGuardada.getDistrito());
                request.setAttribute("direccion", compraGuardada.getDireccion());
                request.getRequestDispatcher("DetalleCompra.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            break;

            case "ListarComprasAdmin":
                compras = compraDAO.obtenerCompras();
                request.setAttribute("compras", compras);
                request.getRequestDispatcher("admin/listarCompras.jsp").forward(request, response);
                break;

            case "VerDetalleSolicitudAdmin":
    try {
                String codSolicitud = request.getParameter("CodSolicitud");

                // Obtener los detalles de la solicitud usando el código de solicitud
                Solicitud solicitudGuardada = solicitudDAO.obtenerSolicitudPorCodigo(codSolicitud);

                // Verifica si la solicitud fue encontrada
                if (solicitudGuardada != null) {

                    // Establecer los atributos para la vista JSP
                    request.setAttribute("s", solicitudGuardada);

                    // Atributos generales de la solicitud
                    request.setAttribute("codSolicitud", solicitudGuardada.getCodSolicitud());
                    request.setAttribute("nombre", solicitudGuardada.getNombre());
                    request.setAttribute("empresa", solicitudGuardada.getEmpresa());
                    request.setAttribute("ndocumento", solicitudGuardada.getnDocumento());
                    request.setAttribute("email", solicitudGuardada.getEmail());
                    request.setAttribute("telefono", solicitudGuardada.getTelefono());
                    request.setAttribute("departamento", solicitudGuardada.getDepartamento());
                    request.setAttribute("provincia", solicitudGuardada.getProvincia());
                    request.setAttribute("distrito", solicitudGuardada.getDistrito());
                    request.setAttribute("tipoCliente", solicitudGuardada.getTipoCliente());
                    request.setAttribute("mensaje", solicitudGuardada.getMensaje());
                    request.setAttribute("estado", solicitudGuardada.getEstado());
                    request.setAttribute("fechaSolicitud", solicitudGuardada.getFechaSolicitud());

                    // Redirigir a la página de detalles de la solicitud
                    request.getRequestDispatcher("admin/DetalleSolicitudAdmin.jsp").forward(request, response);
                } else {
                    // Si la solicitud no se encuentra en la base de datos
                    request.setAttribute("error", "Solicitud no encontrada.");
                    request.getRequestDispatcher("admin/error.jsp").forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            break;

            case "ActualizarEstadoPedido":
    try {
                String CodCompra = request.getParameter("id_transaccion");
                int nuevoEstado = Integer.parseInt(request.getParameter("nuevoEstado"));

                boolean actualizado = compraDAO.actualizarEstado(CodCompra, nuevoEstado);

                if (actualizado) {
                    // Redirigir o actualizar la vista con un mensaje de éxito
                    request.setAttribute("mensaje", "Estado actualizado correctamente.");
                } else {
                    request.setAttribute("mensaje", "No se pudo actualizar el estado.");
                }

                // Volver a cargar la vista de detalles de la compra
                Compra compraGuardada = compraDAO.obtenerCompraPorCodigo(CodCompra);
                List<DetalleCompra> detalles = detalleDAO.obtenerDetallesPorCodCompra(CodCompra);
                request.setAttribute("detalles", detalles);
                request.setAttribute("id_transaccion", compraGuardada.getCodCompra());
                request.setAttribute("estado", compraGuardada.getEstado());
                request.setAttribute("total", compraGuardada.getTotal());
                request.setAttribute("fecha", compraGuardada.getFechaCompra());
                request.setAttribute("receptor", compraGuardada.getReceptor());
                request.setAttribute("tipo", compraGuardada.getTipoDocumento());
                request.setAttribute("ndocumento", compraGuardada.getnDocumento());
                request.setAttribute("metodo", compraGuardada.getMetodoPago());
                request.setAttribute("depa", compraGuardada.getDepartamento());
                request.setAttribute("provincia", compraGuardada.getProvincia());
                request.setAttribute("distrito", compraGuardada.getDistrito());
                request.setAttribute("direccion", compraGuardada.getDireccion());

                request.getRequestDispatcher("admin/DetalleCompraAdmin.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            break;

            case "FiltrarCompras":
    try {
                String estadoParam = request.getParameter("estado");
                if (estadoParam != null) {
                    int estado = Integer.parseInt(estadoParam);
                    List<Compra> comprasFiltradas = compraDAO.obtenerComprasPorEstado(estado);
                    request.setAttribute("compras", comprasFiltradas);
                } else {
                    // Manejo de caso cuando no hay estado (puedes lanzar una excepción o redirigir a una lista completa)
                    List<Compra> todasLasCompras = compraDAO.obtenerCompras();
                    request.setAttribute("compras", todasLasCompras);
                }
                request.getRequestDispatcher("admin/listarCompras.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            break;

            case "BuscarCompras":
                String buscar = request.getParameter("buscar");
                List<Compra> comprasBuscadas = new ArrayList<>();
                if (buscar != null && !buscar.trim().isEmpty()) {
                    comprasBuscadas = compraDAO.buscarCompras(buscar);
                }
                request.setAttribute("compras", comprasBuscadas);
                request.getRequestDispatcher("admin/listarCompras.jsp").forward(request, response);
                break;

            case "EnviarSolicitud":
                try {
                // Obtener parámetros del formulario
                String nombre = request.getParameter("nombre");
                String empresa = request.getParameter("empresa");
                String ndocumento = request.getParameter("ndocumento");
                String email = request.getParameter("email");
                String telefono = request.getParameter("telefono");
                String departamento = request.getParameter("departamento");
                String provincia = request.getParameter("provincia");
                String distrito = request.getParameter("distrito");
                String tipoCliente = request.getParameter("tipoCliente");
                String mensaje = request.getParameter("mensaje");
                int Estado = 0;

                String codSolicitud = generarCodigoSolicitud();
                Solicitud s = new Solicitud();
                s.setCodSolicitud(codSolicitud);
                s.setNombre(nombre);
                s.setEmpresa(empresa);
                s.setnDocumento(ndocumento);
                s.setEmail(email);
                s.setTelefono(telefono);
                s.setDepartamento(departamento);
                s.setProvincia(provincia);
                s.setDistrito(distrito);
                s.setTipoCliente(tipoCliente);
                s.setMensaje(mensaje);
                s.setFechaSolicitud(new Timestamp(new Date().getTime()));
                s.setEstado(0);
                solicitudDAO.agregar(s);

                request.setAttribute("s", s);
                request.getRequestDispatcher("DetalleSolicitud.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al enviar la solicitud:" + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
            break;

            case "ListarSolicitudes":
    try {
                List<Solicitud> s = solicitudDAO.obtenerSolicitudes();
                request.setAttribute("s", s);
                request.getRequestDispatcher("admin/listarSolicitudes.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al listar las solicitudes: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
            break;

            case "FiltrarSolicitudes":
    try {
                String estadoParam = request.getParameter("estado");
                if (estadoParam != null) {
                    int estado = Integer.parseInt(estadoParam);
                    List<Solicitud> s = solicitudDAO.obtenerSolicitudesPorEstado(estado);
                    request.setAttribute("s", s);
                } else {
                    // Manejo de caso cuando no hay estado (puedes lanzar una excepción o redirigir a una lista completa)
                    List<Solicitud> s = solicitudDAO.obtenerSolicitudes();
                    request.setAttribute("s", s);
                }
                request.getRequestDispatcher("admin/listarSolicitudes.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            break;

            case "ActualizarEstadoSolicitud":
    try {
                // Obtener parámetros de la solicitud y nuevo estado
                String codSolicitud = request.getParameter("codSolicitud");
                int nuevoEstado = Integer.parseInt(request.getParameter("nuevoEstado"));

                // Actualizar el estado de la solicitud
                boolean actualizado = solicitudDAO.actualizarEstado(codSolicitud, nuevoEstado);

                // Mostrar mensaje de éxito o error
                String mensaje = actualizado ? "Estado actualizado correctamente." : "No se pudo actualizar el estado.";
                request.setAttribute("mensaje", mensaje);

                // Cargar los detalles de la solicitud actualizada
                Solicitud solicitud = solicitudDAO.obtenerSolicitudPorCodigo(codSolicitud);
                request.setAttribute("s", solicitud);

                // Redirigir a la vista de detalles de la solicitud
                request.getRequestDispatcher("admin/DetalleSolicitudAdmin.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            break;

            case "BuscarSolicitudes":
                buscar = request.getParameter("buscar");
                List<Solicitud> solicitudesBuscadas = new ArrayList<>();
                if (buscar != null && !buscar.trim().isEmpty()) {
                    solicitudesBuscadas = solicitudDAO.buscarSolicitudes(buscar);
                }
                request.setAttribute("s", solicitudesBuscadas);
                request.getRequestDispatcher("admin/listarSolicitudes.jsp").forward(request, response);
                break;
            default:
                request.setAttribute("productos", productos);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
        }
    }

    private String generarCodigoCompra() {
        return "COMP" + System.currentTimeMillis(); // Ejemplo simple, genera un código basado en el tiempo actual
    }

    private String generarCodigoSolicitud() {
        return "SOL" + System.currentTimeMillis(); // Ejemplo simple, genera un código basado en el tiempo actual
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
