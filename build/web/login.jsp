<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>AgroPiura - Login</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
            />
        <style>
            @import url("https://fonts.googleapis.com/css2?family=Karla:wght@400;700&family=Roboto:wght@400;700&display=swap");

            .form-container {
                display: flex;
                height: 100vh;
            }

            .carousel-inner img {
                object-fit: cover;
                height: 100%;
            }

            .form-section {
                padding: 2rem;
                background-color: white;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .form-box,
            .alert,
            .imgCont {
                width: 100%;
                max-width: 450px;
            }

            .form-group {
                position: relative;
                margin-bottom: 1.5rem;
            }

            .form-input {
                width: 100%;
                padding: 1.2rem 0.5rem 0.4rem;
                font-size: 1rem;
                border: 1px solid #747775;
                border-radius: 4px;
                outline: none;
                background: transparent;
            }

            .form-label {
                position: absolute;
                top: 1rem;
                left: 0.5rem;
                color: #777;
                pointer-events: none;
                transition: 0.2s ease all;
                background: white;
                padding: 0 0.2rem;
            }

            .form-input:focus + .form-label,
            .form-input:not(:placeholder-shown) + .form-label {
                top: -0.6rem;
                left: 0.4rem;
                font-size: 0.75rem;
                color: #3f51b5;
            }

            @media (max-width: 768px) {
                .form-container {
                    flex-direction: column-reverse;
                }

                .carousel,
                .carousel-item img {
                    height: 300px;
                }
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <!-- Formulario -->
            <div class="col-lg-6 col-md-6 col-12 form-section d-flex flex-column">
                <span class="d-flex imgCont mb-1">
                    <img src="logo.png" width="180" alt="" />
                </span>

                <c:if test="${not empty msj}">
                    <div class="alert alert-success mt-3" role="alert">${msj}</div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger mt-3" role="alert">${error}</div>
                </c:if>

                <div class="form-box mt-2">
                    <h3 class="mb-4">Iniciar sesión</h3>
                    <form action="login" method="POST" class="d-flex flex-column" autocomplete="off">
                        <div class="form-group">
                            <input
                                type="email"
                                id="correo"
                                class="form-input"
                                name="txtCorreo"
                                placeholder=" "
                                autocomplete="off"
                                required
                                />
                            <label for="correo" class="form-label">Correo</label>
                        </div>

                        <div class="form-group position-relative">
                            <input
                                type="password"
                                id="password"
                                class="form-input"
                                name="txtPassword"
                                placeholder=" "
                                autocomplete="new-password"
                                required
                                />
                            <label for="password" class="form-label">Contraseña</label>
                            <span
                                class="material-symbols-outlined position-absolute top-50 end-0 translate-middle-y me-3"
                                style="cursor: pointer"
                                onclick="togglePassword('password', this)"
                                >visibility</span
                            >
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary" name="accion"
                                    value="Ingresar">Ingresar</button>
                        </div>
                        <p class="text-center">
                            ¿No tienes una cuenta? <a href="register.jsp">Regístrate</a>
                        </p>
                    </form>

                    <script>
                        function togglePassword(id, icon) {
                            const input = document.getElementById(id);
                            if (input.type === "password") {
                                input.type = "text";
                                icon.textContent = "visibility_off";
                            } else {
                                input.type = "password";
                                icon.textContent = "visibility";
                            }
                        }
                    </script>
                </div>
            </div>

            <!-- Carrusel -->
            <div class="col-lg-6 col-md-6 d-none d-md-block p-0">
                <div
                    id="carouselLogin"
                    class="carousel slide h-100"
                    data-bs-ride="carousel"
                    >
                    <div class="carousel-inner h-100">
                        <div class="carousel-item active h-100">
                            <img
                                src="https://images.unsplash.com/photo-1533062618053-d51e617307ec?q=80&w=2070&auto=format&fit=crop"
                                class="d-block w-100"
                                alt="Agricultura"
                                />
                            <div class="carousel-caption d-none d-md-block">
                                <h5>Bienvenido a AgroVenta</h5>
                                <p>Productos agrícolas frescos al alcance de un clic</p>
                            </div>
                        </div>
                        <div class="carousel-item h-100">
                            <img
                                src="https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=2070&auto=format&fit=crop"
                                class="d-block w-100"
                                alt="Campo"
                                />
                            <div class="carousel-caption d-none d-md-block">
                                <h5>Conecta con el campo</h5>
                                <p>Compra directo a productores locales</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
