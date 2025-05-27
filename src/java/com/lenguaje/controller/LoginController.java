package com.lenguaje.controller;

import com.lenguaje.model.Usuario;
import com.lenguaje.model.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("txtCorreo");
        String password = request.getParameter("txtPassword");

        Usuario usuario = usuarioDAO.validarUsuario(correo, password);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario.getUsername());
            session.setAttribute("rol", usuario.getRol().getName());

            String rol = usuario.getRol().getName();
            if ("administrador".equalsIgnoreCase(rol)) {
                response.sendRedirect("home.jsp");
            } else if ("cliente".equalsIgnoreCase(rol)) {
                response.sendRedirect("home.jsp");
            } else {
                session.invalidate();
                request.setAttribute("error", "Rol de usuario no reconocido.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Correo o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
