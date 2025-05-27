package com.lenguaje.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/error")
public class ErrorController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer codigo = (Integer) request.getAttribute("javax.servlet.error.status_code");
        String mensaje;

        if (codigo != null) {
            switch (codigo) {
                case 401:
                    mensaje = "No autorizado";
                    break;
                case 403:
                    mensaje = "Prohibido";
                    break;
                case 404:
                    mensaje = "Página no encontrada";
                    break;
                case 405:
                    mensaje = "Página no encontrada";
                    break;
                case 500:
                    mensaje = "Error interno del servidor";
                    break;
                default:
                    mensaje = "Ha ocurrido un error inesperado";
                    break;
            }
        } else {
            codigo = 0;
            mensaje = "Ha ocurrido un error inesperado";
        }

        request.setAttribute("codigoError", codigo.toString());
        request.setAttribute("mensajeError", mensaje);
        request.getRequestDispatcher("error.jsp").forward(request, response);

    }
}
