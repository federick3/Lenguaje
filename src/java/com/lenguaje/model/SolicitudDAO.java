/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lenguaje.model;

import com.lenguaje.config.Conexion;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

public class SolicitudDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public void agregar(Solicitud s) {
        String sql = "insert into contacto(CodSolicitud,Nombre,Empresa,nDocumento,Correo,Celular,Departamento,Provincia,Distrito,tipoCliente,Mensaje,FechaSolicitud,Estado)values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            s.setFechaSolicitud(new Timestamp(new Date().getTime()));
            ps.setString(1, s.getCodSolicitud());
            ps.setString(2, s.getNombre());
            ps.setString(3, s.getEmpresa());
            ps.setString(4, s.getnDocumento());
            ps.setString(5, s.getEmail());
            ps.setString(6, s.getTelefono());
            ps.setString(7, s.getDepartamento());
            ps.setString(8, s.getProvincia());
            ps.setString(9, s.getDistrito());
            ps.setString(10, s.getTipoCliente());
            ps.setString(11, s.getMensaje());
            ps.setTimestamp(12, new Timestamp(s.getFechaSolicitud().getTime())); // Insertar la fecha actual
            ps.setInt(13, s.getEstado());
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

    public List<Solicitud> obtenerSolicitudes() {
        List<Solicitud> solicitudes = new ArrayList<>();
        String sql = "SELECT * FROM contacto";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Solicitud solicitud = new Solicitud();
                solicitud.setCodSolicitud(rs.getString("CodSolicitud"));
                solicitud.setNombre(rs.getString("Nombre"));
                solicitud.setEmpresa(rs.getString("Empresa"));
                solicitud.setnDocumento(rs.getString("nDocumento"));
                solicitud.setEmail(rs.getString("Correo"));
                solicitud.setTelefono(rs.getString("Celular"));
                solicitud.setDepartamento(rs.getString("Departamento"));
                solicitud.setProvincia(rs.getString("Provincia"));
                solicitud.setDistrito(rs.getString("Distrito"));
                solicitud.setTipoCliente(rs.getString("tipoCliente"));
                solicitud.setMensaje(rs.getString("Mensaje"));
                solicitud.setFechaSolicitud(rs.getTimestamp("FechaSolicitud"));
                solicitud.setEstado(rs.getInt("Estado"));
                solicitudes.add(solicitud);
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

        return solicitudes;
    }
    
    public Solicitud obtenerSolicitudPorCodigo(String codSolicitud) {
    Solicitud solicitud = null;
    String sql = "SELECT * FROM contacto WHERE CodSolicitud = ?";

    try {
        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, codSolicitud);  // Establecer el parámetro CodSolicitud
        rs = ps.executeQuery();

        if (rs.next()) {
            solicitud = new Solicitud();
            solicitud.setCodSolicitud(rs.getString("CodSolicitud"));
            solicitud.setNombre(rs.getString("Nombre"));
            solicitud.setEmpresa(rs.getString("Empresa"));
            solicitud.setnDocumento(rs.getString("nDocumento"));
            solicitud.setEmail(rs.getString("Correo"));
            solicitud.setTelefono(rs.getString("Celular"));
            solicitud.setDepartamento(rs.getString("Departamento"));
            solicitud.setProvincia(rs.getString("Provincia"));
            solicitud.setDistrito(rs.getString("Distrito"));
            solicitud.setTipoCliente(rs.getString("tipoCliente"));
            solicitud.setMensaje(rs.getString("Mensaje"));
            solicitud.setFechaSolicitud(rs.getTimestamp("FechaSolicitud"));
            solicitud.setEstado(rs.getInt("Estado"));
        }

    } catch (SQLException e) {
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    return solicitud;
}

    
    public List<Solicitud> obtenerSolicitudesPorEstado(int estado) {
        List<Solicitud> solicitudes = new ArrayList<>();
        String sql = "SELECT * FROM contacto WHERE Estado = ?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, estado);
            rs = ps.executeQuery();

            while (rs.next()) {
                Solicitud solicitud = new Solicitud();
                solicitud.setCodSolicitud(rs.getString("CodSolicitud"));
                solicitud.setNombre(rs.getString("Nombre"));
                solicitud.setEmpresa(rs.getString("Empresa"));
                solicitud.setnDocumento(rs.getString("nDocumento"));
                solicitud.setEmail(rs.getString("Correo"));
                solicitud.setTelefono(rs.getString("Celular"));
                solicitud.setDepartamento(rs.getString("Departamento"));
                solicitud.setProvincia(rs.getString("Provincia"));
                solicitud.setDistrito(rs.getString("Distrito"));
                solicitud.setTipoCliente(rs.getString("tipoCliente"));
                solicitud.setMensaje(rs.getString("Mensaje"));
                solicitud.setFechaSolicitud(rs.getTimestamp("FechaSolicitud"));
                solicitud.setEstado(rs.getInt("Estado"));
                solicitudes.add(solicitud);
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
        return solicitudes;
    }

    public boolean actualizarEstado(String CodSolicitud, int nuevoEstado) {
    String sql = "UPDATE contacto SET Estado = ? WHERE CodSolicitud = ?";
    try {
        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        
        // Establecer solo el nuevo estado
        ps.setInt(1, nuevoEstado);
        ps.setString(2, CodSolicitud);
        
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
    
    public List<Solicitud> buscarSolicitudes(String buscar) {
    List<Solicitud> solicitudes = new ArrayList<>();
    String sql = "SELECT * FROM contacto WHERE Nombre LIKE ? OR Empresa LIKE ? OR nDocumento LIKE ? OR Correo LIKE ?";

    try {
        con = cn.getConnection();
        ps = con.prepareStatement(sql);

        // Usamos '%' para permitir que coincida con cualquier parte del texto
        String likeBuscar = "%" + buscar + "%";
        ps.setString(1, likeBuscar);
        ps.setString(2, likeBuscar);
        ps.setString(3, likeBuscar);
        ps.setString(4, likeBuscar);

        rs = ps.executeQuery();

        while (rs.next()) {
            Solicitud solicitud = new Solicitud();
            solicitud.setCodSolicitud(rs.getString("CodSolicitud"));
            solicitud.setNombre(rs.getString("Nombre"));
            solicitud.setEmpresa(rs.getString("Empresa"));
            solicitud.setnDocumento(rs.getString("nDocumento"));
            solicitud.setEmail(rs.getString("Correo"));
            solicitud.setTelefono(rs.getString("Celular"));
            solicitud.setDepartamento(rs.getString("Departamento"));
            solicitud.setProvincia(rs.getString("Provincia"));
            solicitud.setDistrito(rs.getString("Distrito"));
            solicitud.setTipoCliente(rs.getString("tipoCliente"));
            solicitud.setMensaje(rs.getString("Mensaje"));
            solicitud.setFechaSolicitud(rs.getTimestamp("FechaSolicitud"));
            solicitud.setEstado(rs.getInt("Estado"));
            solicitudes.add(solicitud);
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
    return solicitudes;
}



}
