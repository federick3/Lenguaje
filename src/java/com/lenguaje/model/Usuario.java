package com.lenguaje.model;

public class Usuario {

    private int Id_User;
    private String username;
    private String nombres;
    private String apellidos;
    private String correo;
    private String password;
    private String celular;
    private boolean estado;
    private Rol rol;

    public Usuario() {
    }

    public Usuario(int Id_User, String username, String nombres, String apellidos, String correo, String password, String celular, boolean estado, Rol rol) {
        this.Id_User = Id_User;
        this.username = username;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.correo = correo;
        this.password = password;
        this.celular = celular;
        this.estado = estado;
        this.rol = rol;
    }

    public int getId_User() {
        return Id_User;
    }

    public void setId_User(int Id_User) {
        this.Id_User = Id_User;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }

    @Override
    public String toString() {
        return "Usuario{"
                + "Id_User=" + Id_User
                + ", username=" + username
                + ", nombres=" + nombres
                + ", apellidos=" + apellidos
                + ", correo=" + correo
                + ", celular=" + celular
                + ", estado=" + estado
                + ", rol=" + rol
                + '}';
    }

}
