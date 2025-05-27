<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>AgroPiura - Registro</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
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
                max-width: 500px;
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
                    flex-direction: column;
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
            <!-- Carrusel -->
            <div class="col-lg-6 col-md-6 d-none d-md-block p-0">
                <div
                    id="agricultureCarousel"
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
                                <h5>Productos Agrícolas Frescos</h5>
                                <p>Directamente del campo a tu mesa</p>
                            </div>
                        </div>
                        <div class="carousel-item h-100">
                            <img
                                src="https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=2070&auto=format&fit=crop"
                                class="d-block w-100"
                                alt="Campo"
                                />
                            <div class="carousel-caption d-none d-md-block">
                                <h5>Cultivos Sostenibles</h5>
                                <p>Apoyamos la agricultura responsable</p>
                            </div>
                        </div>
                        <div class="carousel-item h-100">
                            <img
                                src="https://images.unsplash.com/photo-1498837167922-ddd27525d352?q=80&w=2070&auto=format&fit=crop"
                                class="d-block w-100"
                                alt="Vegetales"
                                />
                            <div class="carousel-caption d-none d-md-block">
                                <h5>Variedad de Productos</h5>
                                <p>Todo lo que necesitas en un solo lugar</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Formulario -->
            <div class="col-lg-6 col-md-6 col-12 form-section d-flex flex-column">
                <span class="d-flex imgCont mb-1">
                    <img src="logo.png" width="190" alt="" />
                </span>

                <div class="form-box mt-2">
                    <h3 class="mb-4">Crear una cuenta</h3>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mt-3" role="alert">${error}</div>
                    </c:if>

                    <form action="register" method="POST" class="d-flex flex-column" autocomplete="off">
                        <div class="row g-0">
                            <div class="col-md-6 form-group pr-md-1">
                                <input
                                    type="text"
                                    id="txtNombres"
                                    class="form-input"
                                    name="txtNombres"
                                    placeholder=" "
                                    autocomplete="off"
                                    value="${txtNombres != null ? txtNombres : ''}"
                                    required
                                    />
                                <label for="txtNombres" class="form-label">Nombre</label>
                            </div>
                            <div class="col-md-6 form-group p-0 ps-md-1">
                                <input
                                    type="text"
                                    id="txtApellidos"
                                    class="form-input"
                                    name="txtApellidos"
                                    placeholder=" "
                                    autocomplete="off"
                                    value="${txtApellidos != null ? txtApellidos : ''}"
                                    required
                                    />
                                <label for="txtApellidos" class="form-label">Apellidos</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <input
                                type="tel"
                                id="txtCelular"
                                class="form-input"
                                name="txtCelular"
                                placeholder=" "
                                autocomplete="off"
                                value="${txtCelular != null ? txtCelular : ''}"
                                required
                                />
                            <label for="txtCelular" class="form-label">Celular</label>
                        </div>

                        <div class="form-group p-0">
                            <input
                                type="email"
                                id="txtCorreo"
                                class="form-input"
                                name="txtCorreo"
                                placeholder=" "
                                autocomplete="off"
                                value="${txtCorreo != null ? txtCorreo : ''}"
                                required
                                />
                            <label for="txtCorreo" class="form-label">Correo</label>
                        </div>
                        <div class="row g-0 mb-3">
                            <div class="col-md-6 form-group pr-md-1 m-0 ">
                                <div class="form-group position-relative p-0 mb-0">
                                    <input
                                        type="password"
                                        id="txtPassword"
                                        class="form-input"
                                        name="txtPassword"
                                        placeholder=" "
                                        autocomplete="new-password"
                                        required
                                        />
                                    <label for="txtPassword" class="form-label">Contraseña</label>
                                    <span
                                        class="material-symbols-outlined position-absolute top-50 end-0 translate-middle-y me-3"
                                        style="cursor: pointer"
                                        onclick="togglePassword('txtPassword', this)"
                                        >visibility</span
                                    >
                                </div>
                            </div>
                            <div class="col-md-6 form-group ps-md-1 m-0">
                                <div class="form-group position-relative p-0 mb-0">
                                    <input
                                        type="password"
                                        id="txtPasswordNew"
                                        class="form-input"
                                        name="txtPasswordNew"
                                        placeholder=" "
                                        autocomplete="new-password"
                                        required
                                        />
                                    <label for="txtPasswordNew" class="form-label"
                                           >Confirmar</label
                                    >
                                    <span
                                        class="material-symbols-outlined position-absolute top-50 end-0 translate-middle-y me-3"
                                        style="cursor: pointer"
                                        onclick="togglePassword('txtPasswordNew', this)"
                                        >visibility</span
                                    >
                                </div>
                            </div>
                            <div class="col-12">
                                <span class="fs-7 text-body-secondary">Utiliza ocho carácteres como mínimo con una combinación de letras, números, y símbolos</span>
                            </div>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary">Registrarse</button>
                        </div>
                        <p class="text-center">
                            ¿Ya tienes una cuenta? <a href="login.jsp">Inicia sesión</a>
                        </p>
                    </form>
                </div>
            </div>
        </div>

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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
