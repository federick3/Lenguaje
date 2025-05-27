package com.lenguaje.controller;

import com.lenguaje.model.Usuario;
import com.lenguaje.model.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener parámetros del formulario
        String nombres = request.getParameter("txtNombres").trim();
        String apellidos = request.getParameter("txtApellidos").trim();
        String celular = request.getParameter("txtCelular");
        String correo = request.getParameter("txtCorreo");
        String password = request.getParameter("txtPassword");
        String passwordNew = request.getParameter("txtPasswordNew");

        // Validar que los campos no estén vacíos
        if (nombres.isEmpty() || apellidos.isEmpty() || celular.isEmpty() || correo.isEmpty() || password.isEmpty() || passwordNew.isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.setAttribute("txtNombres", nombres);
            request.setAttribute("txtApellidos", apellidos);
            request.setAttribute("txtCelular", celular);
            request.setAttribute("txtCorreo", correo);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validar que celular empiece con 9 y tenga 9 dígitos
        celular = celular.trim();
        if (!celular.matches("^9\\d{8}$")) {
            request.setAttribute("error", "Número de celular inválido.");
            request.setAttribute("txtNombres", nombres);
            request.setAttribute("txtApellidos", apellidos);
            request.setAttribute("txtCorreo", correo);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validar formato de correo con expresión regular simple
        correo = correo.trim().replaceAll("\\s+", "");
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        if (!correo.matches(emailRegex)) {
            request.setAttribute("error", "Correo electrónico inválido.");
            request.setAttribute("txtNombres", nombres);
            request.setAttribute("txtApellidos", apellidos);
            request.setAttribute("txtCelular", celular);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validar que las contraseñas coincidan
        if (!password.equals(passwordNew)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.setAttribute("txtNombres", nombres);
            request.setAttribute("txtApellidos", apellidos);
            request.setAttribute("txtCelular", celular);
            request.setAttribute("txtCorreo", correo);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validar patrón de contraseña: mínimo 8 caracteres, al menos una letra, un número y un símbolo
        String passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        if (!password.matches(passwordPattern)) {
            request.setAttribute("error", "La contraseña debe tener al menos 8 caracteres, incluyendo letras, números y símbolos.");
            request.setAttribute("txtNombres", nombres);
            request.setAttribute("txtApellidos", apellidos);
            request.setAttribute("txtCelular", celular);
            request.setAttribute("txtCorreo", correo);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String primerNombre = nombres.split(" ")[0];
        char inicialApellido = apellidos.charAt(0);
        String username = primerNombre + " " + inicialApellido + ".";

        // Crear objeto Usuario y asignar datos
        Usuario usuario = new Usuario();
        usuario.setUsername(username);
        usuario.setNombres(nombres);
        usuario.setApellidos(apellidos);
        usuario.setCorreo(correo);
        usuario.setPassword(password);
        usuario.setCelular(celular);
        usuario.setEstado(true);

        boolean registrado = usuarioDAO.registrarUsuario(usuario);

        if (registrado) {
            request.getSession().invalidate();
            request.setAttribute("msj", "Usuario registrado correctamente, ahora inicie sesión");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } else {
            request.setAttribute("error", "Este correo ya está registrado. Intenta con otro o accede a tu cuenta.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

}
