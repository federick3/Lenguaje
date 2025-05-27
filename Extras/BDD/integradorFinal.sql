-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-12-2024 a las 17:52:23
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `DesarrolloWeb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `tipoProducto` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`tipoProducto`, `nombre`) VALUES
(1, 'Fertilizante'),
(4, 'Tierra'),
(5, 'Agroquimicos'),
(21, 'Azadon'),
(22, 'Guantes'),
(23, 'Guantes'),
(24, 'Rastrillo'),
(25, 'Tijera de podar'),
(31, 'Aspersores'),
(32, 'Mangueras');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `idCompra` int(11) NOT NULL,
  `User` varchar(255) NOT NULL,
  `Total` decimal(10,2) NOT NULL,
  `Receptor` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `MetodoPago` varchar(255) NOT NULL,
  `codCompra` varchar(255) NOT NULL,
  `Estado` int(11) NOT NULL,
  `Departamento` varchar(255) NOT NULL,
  `Provincia` varchar(255) NOT NULL,
  `Distrito` varchar(255) NOT NULL,
  `tipoDocumento` int(11) NOT NULL,
  `nDocumento` int(11) NOT NULL,
  `fechaCompra` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`idCompra`, `User`, `Total`, `Receptor`, `Direccion`, `MetodoPago`, `codCompra`, `Estado`, `Departamento`, `Provincia`, `Distrito`, `tipoDocumento`, `nDocumento`, `fechaCompra`) VALUES
(7, 'Marcos7', 400.00, 'Walter Arturo Mendoza Montoya', 'a', 'Yape', 'COMP1732488466659', 0, 'a', 'a', 'a', 1, 12356, '2024-11-24'),
(8, 'Marcos7', 100.00, 'a', 'a', 'Plin', 'COMP1733244654977', 0, 'a', 'a', 'a', 1, 12345678, '2024-12-03'),
(9, 'Marcos7', 100.00, 'jp', 'a', 'Yape', 'COMP1733244674771', 0, 'a', 'a', 'a', 1, 12232, '2024-12-03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contacto`
--

CREATE TABLE `contacto` (
  `idContacto` int(11) NOT NULL,
  `CodSolicitud` varchar(255) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Empresa` varchar(255) NOT NULL,
  `nDocumento` varchar(255) NOT NULL,
  `Correo` varchar(255) NOT NULL,
  `Celular` varchar(255) NOT NULL,
  `Departamento` varchar(255) NOT NULL,
  `Provincia` varchar(255) NOT NULL,
  `Distrito` varchar(255) NOT NULL,
  `tipoCliente` varchar(255) NOT NULL,
  `Mensaje` varchar(255) NOT NULL,
  `FechaSolicitud` timestamp NOT NULL DEFAULT current_timestamp(),
  `Estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id_detalleCompra` int(11) NOT NULL,
  `idCompra` int(11) DEFAULT NULL,
  `idProductos` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `Precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`id_detalleCompra`, `idCompra`, `idProductos`, `cantidad`, `Precio`) VALUES
(13, 7, 1, 1, 100.00),
(14, 7, 2, 1, 100.00),
(15, 7, 3, 1, 100.00),
(16, 7, 4, 1, 100.00),
(17, 8, 1, 1, 100.00),
(18, 9, 1, 1, 100.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento`
--

CREATE TABLE `documento` (
  `tipoDocumento` int(11) NOT NULL,
  `Nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `documento`
--

INSERT INTO `documento` (`tipoDocumento`, `Nombre`) VALUES
(1, 'DNI'),
(3, 'Otro'),
(2, 'RUC');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idProductos` int(11) NOT NULL,
  `tipoProducto` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `Precio` decimal(10,2) NOT NULL,
  `Link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProductos`, `tipoProducto`, `Nombre`, `Descripcion`, `Precio`, `Link`) VALUES
(1, 5, 'AMINOTERRA PLUS ZN', 'Es un poderoso fertilizante y bioestimulante líquido, obtenido a partir de proteínas de origen marino (Salmón), hidrolizadas enzimáticamente en condiciones controladas con alta tecnología.\r\nTodos los ', 100.00, 'https://drive.google.com/file/d/1Gz7X614fVLfCGb4iiRMRKg4VmCF_q-zZ/view?usp=drive_link'),
(2, 5, 'AMINOTERRA STD', 'Es un poderoso fertilizante y bioestimulante líquido, obtenido a partir de proteínas de origen marino (Salmón), hidrolizadas enzimáticamente en condiciones controladas con alta tecnología.', 100.00, 'https://drive.google.com/file/d/1a2P_5o5RyARDCJS_Tm_xKWNk1fdz0WJX/view?usp=drive_link'),
(3, 5, 'BIOAMINO-L', 'Es una enmienda orgánica líquida que activa la biología del suelo, gracias sus péptidos y polipéptidos de bajo peso molecular, favoreciendo el desarrollo de micro y macroorganismos benéficos.\r\nProducto apto para ser utilizado en Agricultura Orgánica por: ', 100.00, 'https://drive.google.com/file/d/1y3TKqeIaHiuDeq-3BmRs2AzbC0Twy-U1/view?usp=drive_link'),
(4, 5, 'BIOIL-S (ENHANCE)', 'Aceite natural, obtenido del salmón, con propiedades únicas que promueven el desarrollo de defensa en las plantas. A su vez, su efecto antioxidante y bioestimulante disminuye el estrés de las plantas.\r\nProducto apto para ser utilizado en Agricultura Orgán', 100.00, 'https://procampo.com.pe/wp-content/uploads/2024/04/4.-BIOIL-S-Enhance_-FICHA-TECNICAAE.pdf'),
(5, 5, 'ESCUDERO', 'Fertilizante líquido para aplicación foliar, o sistemas de irrigación, de alta concentración en fósforo y potasio. (0 – 20 – 30).', 100.00, 'https://procampo.com.pe/wp-content/uploads/2021/05/ESCUDERO-X-1-LT.pdf'),
(6, 5, 'OPTIMAT 6 SL', 'Es una meza (fertilizante y bioestimulante), tiene la finalidad de preparar a la planta para resistir condiciones de estrés dinámico como altas y bajas temperaturas y periodos cortos de sequía al proveer precursores estructurales para dicho fin.', 100.00, 'https://procampo.com.pe/wp-content/uploads/2024/10/FT-OPTIMAT.pdf'),
(7, 1, 'Fertilizante', 'hola', 100.00, 'editar'),
(8, 1, 'Urea', 'hola', 100.00, 'editar'),
(10, 21, 'Azadon', 'A', 100.00, 'a'),
(11, 1, 'Fertilizante', 'a', 100.00, 'a'),
(12, 1, 'a', 'a', 100.00, 'a'),
(13, 21, 'a', 'a', 1.00, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--


--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`tipoProducto`),
  ADD KEY `idx_categorias_tipoProducto` (`tipoProducto`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`idCompra`),
  ADD KEY `idx_compra_User` (`User`),
  ADD KEY `idx_tipoDocumento` (`tipoDocumento`);

--
-- Indices de la tabla `contacto`
--
ALTER TABLE `contacto`
  ADD PRIMARY KEY (`idContacto`),
  ADD KEY `idx_contacto_Correo` (`Correo`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`id_detalleCompra`),
  ADD KEY `idx_detalle_compra_idCompra` (`idCompra`),
  ADD KEY `idx_detalle_compra_idProductos` (`idProductos`);

--
-- Indices de la tabla `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`tipoDocumento`),
  ADD KEY `idx_documento_Nombre` (`Nombre`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProductos`),
  ADD KEY `idx_productos_tipoProducto` (`tipoProducto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `User` (`User`),
  ADD KEY `idx_usuarios_Correo` (`Correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `idCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `contacto`
--
ALTER TABLE `contacto`
  MODIFY `idContacto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id_detalleCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `documento`
--
ALTER TABLE `documento`
  MODIFY `tipoDocumento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProductos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_User_fk` FOREIGN KEY (`User`) REFERENCES `usuarios` (`User`),
  ADD CONSTRAINT `compra_tipoDocumento_fk` FOREIGN KEY (`tipoDocumento`) REFERENCES `documento` (`tipoDocumento`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_idCompra_fk` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`),
  ADD CONSTRAINT `detalle_compra_idProductos_fk` FOREIGN KEY (`idProductos`) REFERENCES `productos` (`idProductos`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_tipoProducto_fk` FOREIGN KEY (`tipoProducto`) REFERENCES `categorias` (`tipoProducto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
