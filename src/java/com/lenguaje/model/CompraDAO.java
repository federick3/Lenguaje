package com.lenguaje.model;

import com.lenguaje.config.Conexion;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement; // Asegúrate de tener esta importación
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

public class CompraDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public int agregar(Compra compra) {
        String sql = "INSERT INTO compra (User, Total, Receptor, Direccion, MetodoPago, codCompra, Estado, Departamento, Provincia, Distrito, tipoDocumento, nDocumento, fechaCompra) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int idGenerado = -1; // Variable para almacenar el ID generado

        try {
            con = cn.getConnection(); // Obtener la conexión
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // Preparar la consulta con clave generada
            ps.setString(1, compra.getUser());
            ps.setString(2, compra.getTotal());
            ps.setString(3, compra.getReceptor());
            ps.setString(4, compra.getDireccion());
            ps.setString(5, compra.getMetodoPago());
            ps.setString(6, compra.getCodCompra());
            ps.setInt(7, 0); // Estado: puedes ajustar este valor según tu lógica
            ps.setString(8, compra.getDepartamento());
            ps.setString(9, compra.getProvincia());
            ps.setString(10, compra.getDistrito());
            ps.setInt(11, compra.getTipoDocumento());
            ps.setInt(12, compra.getnDocumento());
            ps.setDate(13, new java.sql.Date(System.currentTimeMillis())); // Establecer fecha actual

            ps.executeUpdate(); // Ejecutar la consulta

            // Obtener el ID generado
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                idGenerado = rs.getInt(1); // Obtener el ID de la primera columna
            }
        } catch (Exception e) {
            e.printStackTrace(); // Manejar excepciones
        } finally {
            try {
                if (rs != null) {
                    rs.close(); // Cerrar ResultSet
                }
                if (ps != null) {
                    ps.close(); // Cerrar PreparedStatement
                }
                if (con != null) {
                    con.close(); // Cerrar conexión
                }
            } catch (Exception e) {
                e.printStackTrace(); // Manejar excepciones
            }
        }
        return idGenerado; // Devolver el ID generado
    }

    public Compra obtenerCompraPorCodigo(String codCompra) {
        Compra compra = null;
        String sql = "SELECT * FROM compra WHERE codCompra = ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, codCompra);
            rs = ps.executeQuery();

            if (rs.next()) {
                compra = new Compra();
                // Rellena los atributos de compra
                compra.setUser(rs.getString("User"));
                compra.setTotal(rs.getString("Total"));
                compra.setReceptor(rs.getString("Receptor"));
                compra.setDireccion(rs.getString("Direccion"));
                compra.setMetodoPago(rs.getString("MetodoPago"));
                compra.setCodCompra(rs.getString("codCompra"));
                compra.setEstado(rs.getInt("Estado"));
                compra.setDepartamento(rs.getString("Departamento"));
                compra.setProvincia(rs.getString("Provincia"));
                compra.setDistrito(rs.getString("Distrito"));
                compra.setTipoDocumento(rs.getInt("TipoDocumento"));
                compra.setnDocumento(rs.getInt("nDocumento"));
                compra.setFechaCompra(rs.getDate("fechaCompra"));

                System.out.println("Compra encontrada en la base de datos con codCompra: " + codCompra); // Confirma si se encuentra
            } else {
                System.out.println("No se encontró ninguna compra con codCompra: " + codCompra); // Mensaje si no encuentra
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return compra;
    }

    public List<Compra> obtenerCompraPorUser(String user) {
        List<Compra> compras = new ArrayList<>();
        String sql = "SELECT * FROM compra WHERE User = ?";

        try {
            con = cn.getConnection(); // Obtener la conexión
            ps = con.prepareStatement(sql); // Preparar la consulta SQL
            ps.setString(1, user); // Establecer el parámetro codCompra
            ResultSet rs = ps.executeQuery(); // Ejecutar la consulta

            while (rs.next()) {
                Compra compra = new Compra();
                // Asignar valores a la instancia de Compra
                compra.setUser(rs.getString("User"));
                compra.setTotal(rs.getString("Total"));
                compra.setReceptor(rs.getString("Receptor"));
                compra.setDireccion(rs.getString("Direccion"));
                compra.setMetodoPago(rs.getString("MetodoPago"));
                compra.setCodCompra(rs.getString("codCompra"));
                compra.setEstado(rs.getInt("Estado"));
                compra.setDepartamento(rs.getString("Departamento"));
                compra.setProvincia(rs.getString("Provincia"));
                compra.setDistrito(rs.getString("Distrito"));
                compra.setTipoDocumento(rs.getInt("TipoDocumento"));
                compra.setnDocumento(rs.getInt("nDocumento"));
                compra.setFechaCompra(rs.getDate("fechaCompra")); // Extraer la fecha de compra

                compras.add(compra); // Agregar a la lista
            }
        } catch (Exception e) {
            e.printStackTrace(); // Manejar excepciones
        } finally {
            try {
                if (ps != null) {
                    ps.close(); // Cerrar el PreparedStatement
                }
                if (con != null) {
                    con.close(); // Cerrar la conexión
                }
            } catch (Exception e) {
                e.printStackTrace(); // Manejar excepciones
            }
        }

        return compras; // Retornar la lista de objetos Compra
    }

    public List<Compra> obtenerCompras() {
        List<Compra> compras = new ArrayList<>();
        String sql = "SELECT * FROM compra";

        try {
            con = cn.getConnection(); // Obtener la conexión
            ps = con.prepareStatement(sql); // Preparar la consulta SQL
            ResultSet rs = ps.executeQuery(); // Ejecutar la consulta

            while (rs.next()) {
                Compra compra = new Compra();
                // Asignar valores a la instancia de Compra
                compra.setUser(rs.getString("User"));
                compra.setTotal(rs.getString("Total"));
                compra.setReceptor(rs.getString("Receptor"));
                compra.setDireccion(rs.getString("Direccion"));
                compra.setMetodoPago(rs.getString("MetodoPago"));
                compra.setCodCompra(rs.getString("codCompra"));
                compra.setEstado(rs.getInt("Estado"));
                compra.setDepartamento(rs.getString("Departamento"));
                compra.setProvincia(rs.getString("Provincia"));
                compra.setDistrito(rs.getString("Distrito"));
                compra.setTipoDocumento(rs.getInt("TipoDocumento"));
                compra.setnDocumento(rs.getInt("nDocumento"));
                compra.setFechaCompra(rs.getDate("fechaCompra")); // Extraer la fecha de compra

                compras.add(compra); // Agregar a la lista
            }
        } catch (Exception e) {
            e.printStackTrace(); // Manejar excepciones
        } finally {
            try {
                if (ps != null) {
                    ps.close(); // Cerrar el PreparedStatement
                }
                if (con != null) {
                    con.close(); // Cerrar la conexión
                }
            } catch (Exception e) {
                e.printStackTrace(); // Manejar excepciones
            }
        }

        return compras; // Retornar la lista de objetos Compra
    }

   
    public boolean actualizarEstado(String CodCompra, int nuevoEstado) {
        String sql = "UPDATE compra SET Estado = ? WHERE CodCompra = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, nuevoEstado);
            ps.setString(2, CodCompra);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Devuelve true si se actualizó correctamente
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public List<Compra> obtenerComprasPorEstado(int estado) {
        List<Compra> compras = new ArrayList<>();
        String sql = "SELECT * FROM compra WHERE Estado = ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, estado);
            rs = ps.executeQuery();

            while (rs.next()) {
                Compra compra = new Compra();
                compra.setUser(rs.getString("User"));
                compra.setTotal(rs.getString("Total"));
                compra.setReceptor(rs.getString("Receptor"));
                compra.setDireccion(rs.getString("Direccion"));
                compra.setMetodoPago(rs.getString("MetodoPago"));
                compra.setCodCompra(rs.getString("codCompra"));
                compra.setEstado(rs.getInt("Estado"));
                compra.setDepartamento(rs.getString("Departamento"));
                compra.setProvincia(rs.getString("Provincia"));
                compra.setDistrito(rs.getString("Distrito"));
                compra.setTipoDocumento(rs.getInt("TipoDocumento"));
                compra.setnDocumento(rs.getInt("nDocumento"));
                compra.setFechaCompra(rs.getDate("fechaCompra"));
                compras.add(compra);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return compras;
    }

    public List<Compra> buscarCompras(String buscar) {
        List<Compra> compras = new ArrayList<>();
        String sql = "SELECT * FROM compra WHERE User LIKE ? OR codCompra LIKE ? OR nDocumento LIKE ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            // Usamos '%' para permitir que coincida con cualquier parte del texto
            String likeBuscar = "%" + buscar + "%";
            ps.setString(1, likeBuscar);
            ps.setString(2, likeBuscar);
            ps.setString(3, likeBuscar);

            rs = ps.executeQuery();

            while (rs.next()) {
                Compra compra = new Compra();
                compra.setUser(rs.getString("User"));
                compra.setTotal(rs.getString("Total"));
                compra.setReceptor(rs.getString("Receptor"));
                compra.setDireccion(rs.getString("Direccion"));
                compra.setMetodoPago(rs.getString("MetodoPago"));
                compra.setCodCompra(rs.getString("codCompra"));
                compra.setEstado(rs.getInt("Estado"));
                compra.setDepartamento(rs.getString("Departamento"));
                compra.setProvincia(rs.getString("Provincia"));
                compra.setDistrito(rs.getString("Distrito"));
                compra.setTipoDocumento(rs.getInt("TipoDocumento"));
                compra.setnDocumento(rs.getInt("nDocumento"));
                compra.setFechaCompra(rs.getDate("fechaCompra"));
                compras.add(compra);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return compras;
    }

}
