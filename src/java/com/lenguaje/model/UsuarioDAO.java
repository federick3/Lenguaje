package com.lenguaje.model;

import com.lenguaje.config.Conexion;
import com.lenguaje.utils.HashUtil;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public Usuario validarUsuario(String correo, String password) {
        Usuario usuario = null;
        String sql = "SELECT u.Id_User, u.username, u.nombres, u.apellidos, u.correo, u.password, u.celular, u.estado, "
                + "r.Id_Role, r.name AS rol_nombre "
                + "FROM usuarios u "
                + "JOIN user_rol ur ON u.Id_User = ur.Id_User "
                + "JOIN roles r ON ur.Id_Role = r.Id_Role "
                + "WHERE u.correo = ? AND u.estado = 1";

        try (Connection con = cn.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, correo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String passwordHashBD = rs.getString("password");
                    String passwordHashInput = HashUtil.hashPassword(password);

                    if (passwordHashBD.equals(passwordHashInput)) {
                        usuario = new Usuario();
                        usuario.setId_User(rs.getInt("Id_User"));
                        usuario.setUsername(rs.getString("username"));
                        usuario.setNombres(rs.getString("nombres"));
                        usuario.setApellidos(rs.getString("apellidos"));
                        usuario.setCorreo(rs.getString("correo"));
                        usuario.setPassword(passwordHashBD);
                        usuario.setCelular(rs.getString("celular"));
                        usuario.setEstado(rs.getBoolean("estado"));

                        Rol rol = new Rol();
                        rol.setId_Role(rs.getInt("Id_Role"));
                        rol.setName(rs.getString("rol_nombre"));
                        usuario.setRol(rol);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    public boolean registrarUsuario(Usuario usuario) {
        boolean registrado = false;
        Connection con = null;
        PreparedStatement psValidar = null;
        PreparedStatement psInsert = null;
        PreparedStatement psRol = null;
        ResultSet rs = null;

        try {
            con = cn.getConnection();
            String validarSql = "SELECT COUNT(*) FROM usuarios WHERE correo = ?";

            ps = con.prepareStatement(validarSql);
            ps.setString(1, usuario.getCorreo());
            rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false;
            }

            String insertSql = "INSERT INTO usuarios (username, nombres, apellidos, correo, password, celular, estado) "
                    + "VALUES (?, ?, ?, ?, ?, ?, 1)";
            ps = con.prepareStatement(insertSql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, usuario.getUsername());
            ps.setString(2, usuario.getNombres());
            ps.setString(3, usuario.getApellidos());
            ps.setString(4, usuario.getCorreo());

            // Hashear contraseña antes de guardar
            String passwordHash = HashUtil.hashPassword(usuario.getPassword());
            ps.setString(5, passwordHash);

            ps.setString(6, usuario.getCelular());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int nuevoIdUser = rs.getInt(1);

                    String insertRolSql = "INSERT INTO user_rol (Id_User, Id_Role) VALUES (?, ?)";
                    ps = con.prepareStatement(insertRolSql);
                    ps.setInt(1, nuevoIdUser);
                    ps.setInt(2, 2);
                    ps.executeUpdate();

                    registrado = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (psValidar != null) {
                    psValidar.close();
                }
                if (psInsert != null) {
                    psInsert.close();
                }
                if (psRol != null) {
                    psRol.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return registrado;
    }

}
