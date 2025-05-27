package com.lenguaje.model;

import com.lenguaje.config.Conexion;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

public class ProductoDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public Producto listarId(int idProductos) {
        Producto p = new Producto();
        String sql = "SELECT * FROM productos WHERE idProductos=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idProductos);
            rs = ps.executeQuery();
            if (rs.next()) {
                p.setIdProductos(rs.getInt(1));
                p.setTipoProducto(rs.getInt(2));
                p.setNombre(rs.getString(3));
                p.setDescripcion(rs.getString(4));
                p.setPrecio(rs.getDouble(5));
                p.setLink(rs.getString(6));
                System.out.println("Producto encontrado: " + p.getNombre());
            } else {
                System.out.println("No se encontró ningún producto con ID: " + idProductos);
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
        return p;
    }

    public List<Producto> listar() {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProductos(rs.getInt(1));
                p.setTipoProducto(rs.getInt(2));
                p.setNombre(rs.getString(3));
                p.setDescripcion(rs.getString(4));
                p.setPrecio(rs.getDouble(5));
                p.setLink(rs.getString(6));
                productos.add(p);
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
        return productos;
    }

  
    public List<Producto> listarPorTipoProducto(int tipoProducto) {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE tipoProducto = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, tipoProducto);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProductos(rs.getInt(1));
                p.setTipoProducto(rs.getInt(2));
                p.setNombre(rs.getString(3));
                p.setDescripcion(rs.getString(4));
                p.setPrecio(rs.getDouble(5));
                p.setLink(rs.getString(6));
                productos.add(p);
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
        return productos;
    }

    public int agregar(Producto p) {
    String sql = "INSERT INTO productos(tipoProducto, Nombre, Descripcion, Precio, Link) VALUES (?, ?, ?, ?, ?)";
    int idProducto = -1; // Inicializa la variable para el ID del producto
    try {
        con = cn.getConnection();
        ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // Habilita el retorno de las claves generadas
        ps.setInt(1, p.getTipoProducto());
        ps.setString(2, p.getNombre());
        ps.setString(3, p.getDescripcion());
        ps.setDouble(4, p.getPrecio());
        ps.setString(5, p.getLink());
        ps.executeUpdate();

        // Obtiene el ID generado
        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            idProducto = rs.getInt(1); // Obtiene el primer ID generado
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
    return idProducto; // Devuelve el ID del producto
}


    public int obtenerUltimoId() {
        int id = -1;
        String sql = "SELECT LAST_INSERT_ID()"; // Para MySQL
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getInt(1);
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
        return id;
    }

    
    

    public void eliminar(int idProductos) {
        String sql = "DELETE FROM productos WHERE idProductos=?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idProductos);
            ps.executeUpdate();
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
    }

    public Producto obtenerProductoPorId(int idProducto) {
        Producto producto = null;
        String sql = "SELECT * FROM productos WHERE idproductos = ?";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idProducto);
            rs = ps.executeQuery();
            if (rs.next()) {
                producto = new Producto();
                producto.setIdProductos(rs.getInt("idproductos"));
                producto.setNombre(rs.getString("Nombre"));
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
        return producto;
    }
}
