package com.lenguaje.model;

public class Rol {

    private int Id_Role;
    private String name;

    public Rol() {
    }

    public Rol(int Id_Role, String name) {
        this.Id_Role = Id_Role;
        this.name = name;
    }

    public int getId_Role() {
        return Id_Role;
    }

    public void setId_Role(int Id_Role) {
        this.Id_Role = Id_Role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Rol{" + "Id_Role=" + Id_Role + ", name=" + name + '}';
    }

}
