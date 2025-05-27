
package com.lenguaje.model;

import java.sql.Timestamp;
import java.util.Date;

public class Solicitud {
    String nombre;
    String codSolicitud;
    String empresa;
    String nDocumento;
    String email;
    String telefono;
    String departamento;
    String provincia;
    String distrito;
    String tipoCliente;
    String mensaje;
    Timestamp FechaSolicitud; 
    int Estado;
    
    public Solicitud() {
    }

    public Solicitud(String nombre, String codSolicitud, String empresa, String nDocumento, String email, String telefono, String departamento, String provincia, String distrito, String tipoCliente, String mensaje, Timestamp FechaSolicitud, int Estado) {
        this.nombre = nombre;
        this.codSolicitud = codSolicitud;
        this.empresa = empresa;
        this.nDocumento = nDocumento;
        this.email = email;
        this.telefono = telefono;
        this.departamento = departamento;
        this.provincia = provincia;
        this.distrito = distrito;
        this.tipoCliente = tipoCliente;
        this.mensaje = mensaje;
        this.FechaSolicitud = FechaSolicitud;
        this.Estado = Estado;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCodSolicitud() {
        return codSolicitud;
    }

    public void setCodSolicitud(String codSolicitud) {
        this.codSolicitud = codSolicitud;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    public String getnDocumento() {
        return nDocumento;
    }

    public void setnDocumento(String nDocumento) {
        this.nDocumento = nDocumento;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getDistrito() {
        return distrito;
    }

    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

    public String getTipoCliente() {
        return tipoCliente;
    }

    public void setTipoCliente(String tipoCliente) {
        this.tipoCliente = tipoCliente;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public Timestamp getFechaSolicitud() {
        return FechaSolicitud;
    }

    public void setFechaSolicitud(Timestamp FechaSolicitud) {
        this.FechaSolicitud = FechaSolicitud;
    }

    public int getEstado() {
        return Estado;
    }

    public void setEstado(int Estado) {
        this.Estado = Estado;
    }

}
