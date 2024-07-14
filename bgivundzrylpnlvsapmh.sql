-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: bgivundzrylpnlvsapmh-mysql.services.clever-cloud.com:3306
-- Tiempo de generación: 10-07-2024 a las 22:19:25
-- Versión del servidor: 8.0.22-13
-- Versión de PHP: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bgivundzrylpnlvsapmh`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Asientos`
--

CREATE TABLE `Asientos` (
  `asiento_id` int NOT NULL,
  `numero_asiento` varchar(10) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'Disponible',
  `usuario_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Asistentes`
--

CREATE TABLE `Asistentes` (
  `asistente_id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `evento_id` int DEFAULT NULL,
  `estado_inscripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Categorias`
--

CREATE TABLE `Categorias` (
  `categoria_id` int NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Comentarios`
--

CREATE TABLE `Comentarios` (
  `comentario_id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `evento_id` int DEFAULT NULL,
  `comentario` text,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Detalles_Evento`
--

CREATE TABLE `Detalles_Evento` (
  `detalle_evento_id` int NOT NULL,
  `evento_id` int DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `requerimientos` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Errores_Logs`
--

CREATE TABLE `Errores_Logs` (
  `log_id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `mensaje` text,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Escenario`
--

CREATE TABLE `Escenario` (
  `escenario_id` int NOT NULL,
  `asiento` int DEFAULT NULL,
  `forma` enum('Redondo','Cuadrado','Triangular') DEFAULT NULL,
  `evento_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Eventos`
--

CREATE TABLE `Eventos` (
  `evento_id` int NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_termino` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `tipo_evento_id` int DEFAULT NULL,
  `organizador_id` int DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `max_per` int DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `fecha_autorizacion` datetime DEFAULT NULL,
  `autorizado_por` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Imagenes`
--

CREATE TABLE `Imagenes` (
  `imagen_id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `evento_id` int DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `es_principal` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Membresia`
--

CREATE TABLE `Membresia` (
  `membresia_id` int NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `descripcion` text,
  `costo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `NotificacionO`
--

CREATE TABLE `NotificacionO` (
  `notificacion_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `mensaje` varchar(255) NOT NULL,
  `fecha_envio` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Pagos`
--

CREATE TABLE `Pagos` (
  `pago_id` int NOT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `tipo_pago_id` int DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `evento_id` int DEFAULT NULL,
  `f_inicio_ep` datetime DEFAULT NULL,
  `f_FIN_ep` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Pago_Tarjeta`
--

CREATE TABLE `Pago_Tarjeta` (
  `tarjeta_id` int NOT NULL,
  `numero_tarjeta` varchar(255) NOT NULL,
  `fecha_expiracion` date NOT NULL,
  `cvv` varchar(4) NOT NULL,
  `pago_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Permisos`
--

CREATE TABLE `Permisos` (
  `permiso_id` int NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Pruebas`
--

CREATE TABLE `Pruebas` (
  `pruebas_id` int NOT NULL,
  `nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `Pruebas`
--

INSERT INTO `Pruebas` (`pruebas_id`, `nombre`) VALUES
(1, 'pruebas'),
(2, 'pruebas'),
(3, 'pruebas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `RegistroEv`
--

CREATE TABLE `RegistroEv` (
  `registro_id` int NOT NULL,
  `evento_id` int DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Roles`
--

CREATE TABLE `Roles` (
  `rol_id` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Roles_Permisos`
--

CREATE TABLE `Roles_Permisos` (
  `rol_id` int NOT NULL,
  `permiso_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Tipos_Evento`
--

CREATE TABLE `Tipos_Evento` (
  `tipo_evento_id` int NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Tipos_Pago`
--

CREATE TABLE `Tipos_Pago` (
  `tipo_pago_id` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Tokens`
--

CREATE TABLE `Tokens` (
  `token_id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `expiracion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Usuarios`
--

CREATE TABLE `Usuarios` (
  `usuario_id` int NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contrasena` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `rol_id` int DEFAULT NULL,
  `membresia_id` int DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `last_name` varchar(255) DEFAULT NULL,
  `resetPasswordExpire` date DEFAULT NULL,
  `resetPasswordToken` varchar(255) DEFAULT NULL,
  `fotoPerfil` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Validacion`
--

CREATE TABLE `Validacion` (
  `validacion_id` int NOT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `comentarios` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Asientos`
--
ALTER TABLE `Asientos`
  ADD PRIMARY KEY (`asiento_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `Asistentes`
--
ALTER TABLE `Asistentes`
  ADD PRIMARY KEY (`asistente_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `evento_id` (`evento_id`);

--
-- Indices de la tabla `Categorias`
--
ALTER TABLE `Categorias`
  ADD PRIMARY KEY (`categoria_id`);

--
-- Indices de la tabla `Comentarios`
--
ALTER TABLE `Comentarios`
  ADD PRIMARY KEY (`comentario_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `evento_id` (`evento_id`);

--
-- Indices de la tabla `Detalles_Evento`
--
ALTER TABLE `Detalles_Evento`
  ADD PRIMARY KEY (`detalle_evento_id`),
  ADD KEY `evento_id` (`evento_id`);

--
-- Indices de la tabla `Errores_Logs`
--
ALTER TABLE `Errores_Logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `Escenario`
--
ALTER TABLE `Escenario`
  ADD PRIMARY KEY (`escenario_id`),
  ADD KEY `evento_id` (`evento_id`);

--
-- Indices de la tabla `Eventos`
--
ALTER TABLE `Eventos`
  ADD PRIMARY KEY (`evento_id`),
  ADD KEY `tipo_evento_id` (`tipo_evento_id`),
  ADD KEY `organizador_id` (`organizador_id`),
  ADD KEY `categoria_id` (`categoria_id`),
  ADD KEY `fk_eventos_autorizado_por` (`autorizado_por`);

--
-- Indices de la tabla `Imagenes`
--
ALTER TABLE `Imagenes`
  ADD PRIMARY KEY (`imagen_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `evento_id` (`evento_id`);

--
-- Indices de la tabla `Membresia`
--
ALTER TABLE `Membresia`
  ADD PRIMARY KEY (`membresia_id`);

--
-- Indices de la tabla `NotificacionO`
--
ALTER TABLE `NotificacionO`
  ADD PRIMARY KEY (`notificacion_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `Pagos`
--
ALTER TABLE `Pagos`
  ADD PRIMARY KEY (`pago_id`),
  ADD KEY `tipo_pago_id` (`tipo_pago_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `evento_id` (`evento_id`);

--
-- Indices de la tabla `Pago_Tarjeta`
--
ALTER TABLE `Pago_Tarjeta`
  ADD PRIMARY KEY (`tarjeta_id`),
  ADD KEY `pago_id` (`pago_id`);

--
-- Indices de la tabla `Permisos`
--
ALTER TABLE `Permisos`
  ADD PRIMARY KEY (`permiso_id`);

--
-- Indices de la tabla `Pruebas`
--
ALTER TABLE `Pruebas`
  ADD PRIMARY KEY (`pruebas_id`);

--
-- Indices de la tabla `RegistroEv`
--
ALTER TABLE `RegistroEv`
  ADD PRIMARY KEY (`registro_id`),
  ADD KEY `evento_id` (`evento_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `Roles`
--
ALTER TABLE `Roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `Roles_Permisos`
--
ALTER TABLE `Roles_Permisos`
  ADD PRIMARY KEY (`rol_id`,`permiso_id`),
  ADD KEY `permiso_id` (`permiso_id`);

--
-- Indices de la tabla `Tipos_Evento`
--
ALTER TABLE `Tipos_Evento`
  ADD PRIMARY KEY (`tipo_evento_id`);

--
-- Indices de la tabla `Tipos_Pago`
--
ALTER TABLE `Tipos_Pago`
  ADD PRIMARY KEY (`tipo_pago_id`);

--
-- Indices de la tabla `Tokens`
--
ALTER TABLE `Tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `rol_id` (`rol_id`),
  ADD KEY `membresia_id` (`membresia_id`);

--
-- Indices de la tabla `Validacion`
--
ALTER TABLE `Validacion`
  ADD PRIMARY KEY (`validacion_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Asientos`
--
ALTER TABLE `Asientos`
  MODIFY `asiento_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Asistentes`
--
ALTER TABLE `Asistentes`
  MODIFY `asistente_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Categorias`
--
ALTER TABLE `Categorias`
  MODIFY `categoria_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Comentarios`
--
ALTER TABLE `Comentarios`
  MODIFY `comentario_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Detalles_Evento`
--
ALTER TABLE `Detalles_Evento`
  MODIFY `detalle_evento_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Errores_Logs`
--
ALTER TABLE `Errores_Logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Escenario`
--
ALTER TABLE `Escenario`
  MODIFY `escenario_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Eventos`
--
ALTER TABLE `Eventos`
  MODIFY `evento_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Imagenes`
--
ALTER TABLE `Imagenes`
  MODIFY `imagen_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Membresia`
--
ALTER TABLE `Membresia`
  MODIFY `membresia_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `NotificacionO`
--
ALTER TABLE `NotificacionO`
  MODIFY `notificacion_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Pagos`
--
ALTER TABLE `Pagos`
  MODIFY `pago_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Pago_Tarjeta`
--
ALTER TABLE `Pago_Tarjeta`
  MODIFY `tarjeta_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Permisos`
--
ALTER TABLE `Permisos`
  MODIFY `permiso_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Pruebas`
--
ALTER TABLE `Pruebas`
  MODIFY `pruebas_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `RegistroEv`
--
ALTER TABLE `RegistroEv`
  MODIFY `registro_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Roles`
--
ALTER TABLE `Roles`
  MODIFY `rol_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Tipos_Evento`
--
ALTER TABLE `Tipos_Evento`
  MODIFY `tipo_evento_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Tipos_Pago`
--
ALTER TABLE `Tipos_Pago`
  MODIFY `tipo_pago_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Tokens`
--
ALTER TABLE `Tokens`
  MODIFY `token_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  MODIFY `usuario_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Validacion`
--
ALTER TABLE `Validacion`
  MODIFY `validacion_id` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Asientos`
--
ALTER TABLE `Asientos`
  ADD CONSTRAINT `Asientos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `Asistentes`
--
ALTER TABLE `Asistentes`
  ADD CONSTRAINT `Asistentes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Asistentes_ibfk_2` FOREIGN KEY (`evento_id`) REFERENCES `Eventos` (`evento_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Comentarios`
--
ALTER TABLE `Comentarios`
  ADD CONSTRAINT `Comentarios_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Comentarios_ibfk_2` FOREIGN KEY (`evento_id`) REFERENCES `Eventos` (`evento_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Detalles_Evento`
--
ALTER TABLE `Detalles_Evento`
  ADD CONSTRAINT `Detalles_Evento_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `Eventos` (`evento_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Errores_Logs`
--
ALTER TABLE `Errores_Logs`
  ADD CONSTRAINT `Errores_Logs_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Escenario`
--
ALTER TABLE `Escenario`
  ADD CONSTRAINT `Escenario_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `Eventos` (`evento_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Eventos`
--
ALTER TABLE `Eventos`
  ADD CONSTRAINT `Eventos_ibfk_1` FOREIGN KEY (`tipo_evento_id`) REFERENCES `Tipos_Evento` (`tipo_evento_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Eventos_ibfk_2` FOREIGN KEY (`organizador_id`) REFERENCES `Usuarios` (`usuario_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Eventos_ibfk_4` FOREIGN KEY (`categoria_id`) REFERENCES `Categorias` (`categoria_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_eventos_autorizado_por` FOREIGN KEY (`autorizado_por`) REFERENCES `Usuarios` (`usuario_id`);

--
-- Filtros para la tabla `Imagenes`
--
ALTER TABLE `Imagenes`
  ADD CONSTRAINT `Imagenes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Imagenes_ibfk_2` FOREIGN KEY (`evento_id`) REFERENCES `Eventos` (`evento_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `NotificacionO`
--
ALTER TABLE `NotificacionO`
  ADD CONSTRAINT `NotificacionO_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`);

--
-- Filtros para la tabla `Pagos`
--
ALTER TABLE `Pagos`
  ADD CONSTRAINT `Pagos_ibfk_1` FOREIGN KEY (`tipo_pago_id`) REFERENCES `Tipos_Pago` (`tipo_pago_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Pagos_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Pagos_ibfk_3` FOREIGN KEY (`evento_id`) REFERENCES `Eventos` (`evento_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Pago_Tarjeta`
--
ALTER TABLE `Pago_Tarjeta`
  ADD CONSTRAINT `Pago_Tarjeta_ibfk_1` FOREIGN KEY (`pago_id`) REFERENCES `Pagos` (`pago_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `RegistroEv`
--
ALTER TABLE `RegistroEv`
  ADD CONSTRAINT `RegistroEv_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `Eventos` (`evento_id`),
  ADD CONSTRAINT `RegistroEv_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`);

--
-- Filtros para la tabla `Roles_Permisos`
--
ALTER TABLE `Roles_Permisos`
  ADD CONSTRAINT `Roles_Permisos_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `Roles` (`rol_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Roles_Permisos_ibfk_2` FOREIGN KEY (`permiso_id`) REFERENCES `Permisos` (`permiso_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Tokens`
--
ALTER TABLE `Tokens`
  ADD CONSTRAINT `Tokens_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD CONSTRAINT `Usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `Roles` (`rol_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Usuarios_ibfk_2` FOREIGN KEY (`membresia_id`) REFERENCES `Membresia` (`membresia_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
