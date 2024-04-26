-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-03-2024 a las 15:56:32
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `elcallejondeelia`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_aux` ()   BEGIN 
DECLARE v_hecho INT DEFAULT 0; 
DECLARE v_id int;
DECLARE v_enlace varchar(100); 
DECLARE v_texto varchar(500); 
DECLARE c_cursor CURSOR for select enlace, texto from libros_mas_vendidos; 
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_hecho = 1; 
OPEN c_cursor; 
SET v_id = 1;
l_loop: LOOP 
FETCH c_cursor INTO v_enlace, v_texto; 
IF v_hecho = 1 THEN 
LEAVE l_loop; 
END IF; 
insert into aux_mas_vendidos (id_aux_mas_vendidos, imagen, texto) values (v_id, v_enlace,v_texto);
SET v_id = v_id + 1;
END LOOP l_loop; 
CLOSE c_cursor; 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autores`
--

CREATE TABLE `autores` (
  `id_autor` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `id_texto` int(11) DEFAULT NULL,
  `id_pais` int(11) DEFAULT NULL,
  `id_imagen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `autores`
--

INSERT INTO `autores` (`id_autor`, `nombre`, `apellidos`, `fecha_nacimiento`, `id_texto`, `id_pais`, `id_imagen`) VALUES
(1, 'J.K', 'Rowling', '1965-07-31', 3, 1, 3),
(2, 'J.R.R', 'Tolkien', '1892-01-03', 4, 1, 4),
(3, 'Laura', 'Gallego ', '1977-10-11', 6, 2, 6),
(4, 'Rosa', 'Montero', '1951-01-03', 9, 2, 9),
(5, 'Dolores', 'Redondo', '1951-01-03', 10, 2, 10);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `autores_info`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `autores_info` (
`enlace` varchar(100)
,`nombre` varchar(100)
,`texto` varchar(500)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aux_mas_vendidos`
--

CREATE TABLE `aux_mas_vendidos` (
  `id_aux_mas_vendidos` int(11) DEFAULT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `texto` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aux_mas_vendidos`
--

INSERT INTO `aux_mas_vendidos` (`id_aux_mas_vendidos`, `imagen`, `texto`) VALUES
(1, 'imagen de harry potter', 'texto de harry potter'),
(2, 'imagen de la resistencia', 'texto de la resistencia'),
(3, 'imagen del señor de los anillos', 'texto del señor de los anillos');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `buscador_libros`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `buscador_libros` (
`enlace` varchar(100)
,`titulo` varchar(100)
,`valoracion` tinyint(4)
,`genero` varchar(100)
,`libro` varchar(500)
,`nombre_autor` varchar(100)
,`apellidos` varchar(100)
,`autor` varchar(500)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `cabecera_logo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `cabecera_logo` (
`enlace` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contacto`
--

CREATE TABLE `contacto` (
  `id_contacto` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(12) DEFAULT NULL,
  `e-mail` varchar(100) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `x` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contacto`
--

INSERT INTO `contacto` (`id_contacto`, `nombre`, `direccion`, `telefono`, `e-mail`, `facebook`, `instagram`, `x`) VALUES
(1, 'El Callejón de Elia', 'calle Santiago, 1,Valladolid,47001', '665555444', 'elcallejondeelia@gmail.com', 'El Callejón de Elia', 'El Callejón de Elia', 'El Callejón de Elia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `editan`
--

CREATE TABLE `editan` (
  `id_editan` int(11) NOT NULL,
  `id_libro` int(11) DEFAULT NULL,
  `id_editorial` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `editan`
--

INSERT INTO `editan` (`id_editan`, `id_libro`, `id_editorial`) VALUES
(1, 1, 1),
(2, 2, 4),
(3, 3, 3),
(4, 4, 2),
(5, 5, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `editoriales`
--

CREATE TABLE `editoriales` (
  `id_editorial` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `editoriales`
--

INSERT INTO `editoriales` (`id_editorial`, `nombre`) VALUES
(1, 'Salamandra'),
(2, 'Alfaguara'),
(3, 'SM'),
(4, 'Minotauro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escriben`
--

CREATE TABLE `escriben` (
  `id_escriben` int(11) NOT NULL,
  `id_autor` int(11) DEFAULT NULL,
  `id_libro` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `escriben`
--

INSERT INTO `escriben` (`id_escriben`, `id_autor`, `id_libro`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `id_evento` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `dia` date DEFAULT NULL,
  `id_texto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `eventos`
--

INSERT INTO `eventos` (`id_evento`, `nombre`, `dia`, `id_texto`) VALUES
(1, 'lectura evento', '2024-03-25', 11);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `eventos_info`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `eventos_info` (
`nombre` varchar(100)
,`dia` date
,`texto` varchar(500)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generos`
--

CREATE TABLE `generos` (
  `id_genero` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `enlace` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `generos`
--

INSERT INTO `generos` (`id_genero`, `nombre`, `enlace`) VALUES
(1, 'Fantasía épica', 'enlace genero uno'),
(2, 'Novela contemporánea', 'enlace genero dos'),
(3, 'Ficción', 'enlace genero tres'),
(4, 'Policiaca', 'enlace genero cuatro');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `genero_cuatro`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `genero_cuatro` (
`enlace` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `genero_dos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `genero_dos` (
`enlace` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `genero_tres`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `genero_tres` (
`enlace` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `genero_uno`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `genero_uno` (
`enlace` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes`
--

CREATE TABLE `imagenes` (
  `id_imagen` int(11) NOT NULL,
  `enlace` varchar(100) DEFAULT NULL,
  `zona` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `imagenes`
--

INSERT INTO `imagenes` (`id_imagen`, `enlace`, `zona`) VALUES
(1, 'imagen de harry potter', 'libros'),
(2, 'imagen del señor de los anillos', 'libros'),
(3, 'imagen de autor rowling', 'autores'),
(4, 'imagen de tolkien', 'autores'),
(5, 'imagen de la resistencia', 'libros'),
(6, 'imagen de laura gallego', 'autores'),
(7, 'imagen de la buena suerte', 'libros'),
(8, 'imagen del baztán', 'libros'),
(9, 'imagen de rosa montero', 'autores'),
(10, 'imagen de dolores redondo', 'autores'),
(11, 'imagen logo tienda', 'cabecera logo');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `imagenes_libros_generos_texto_autores_texto`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `imagenes_libros_generos_texto_autores_texto` (
`enlace` varchar(100)
,`titulo` varchar(100)
,`valoracion` tinyint(4)
,`genero` varchar(100)
,`libro` varchar(500)
,`nombre_autor` varchar(100)
,`apellidos` varchar(100)
,`autor` varchar(500)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `imagen_autor`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `imagen_autor` (
`enlace` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `id_libro` int(11) NOT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `valoracion` tinyint(4) DEFAULT NULL,
  `fecha_publicacion` date DEFAULT NULL,
  `precio_unitario` double(4,2) DEFAULT NULL,
  `stock` tinyint(4) DEFAULT NULL,
  `id_genero` int(11) DEFAULT NULL,
  `id_texto` int(11) DEFAULT NULL,
  `id_imagen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`id_libro`, `isbn`, `titulo`, `valoracion`, `fecha_publicacion`, `precio_unitario`, `stock`, `id_genero`, `id_texto`, `id_imagen`) VALUES
(1, '1', 'Harry Potter y la piedra filosofal', 9, '1997-06-26', 20.10, 6, 1, 1, 1),
(2, '2', 'El Señor de los Anillos: La comunidad del anillo', 7, '1954-07-29', 50.99, 4, 1, 2, 2),
(3, '3', 'Memorias de Idhún: La resistencia', 10, '2004-09-29', 20.40, 15, 1, 5, 5),
(4, '3', 'La buena suerte', 5, '2016-05-24', 19.45, 11, 3, 7, 7),
(5, '4', 'El Guardián Invisible', 7, '1954-07-29', 9.45, 5, 4, 8, 8);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `libros_mas_vendidos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `libros_mas_vendidos` (
`id_libro` int(11)
,`num_ventas` bigint(21)
,`enlace` varchar(100)
,`titulo` varchar(100)
,`texto` varchar(500)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `mas_vendidos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `mas_vendidos` (
`id_libro` int(11)
,`id_reportan` int(11)
,`enlace` varchar(100)
,`titulo` varchar(100)
,`texto` varchar(500)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `id_menu` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `enlace` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id_menu`, `nombre`, `enlace`) VALUES
(1, 'libros más vendidos', 'enlace libros'),
(2, 'eventos', 'enlace eventos'),
(3, 'géneros', 'enlace géneros'),
(4, 'autores', 'enlace autores'),
(5, 'contacto', 'enlace contacto');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `menu_autores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `menu_autores` (
`enlace` varchar(30)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `menu_contacto`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `menu_contacto` (
`enlace` varchar(30)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `menu_eventos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `menu_eventos` (
`enlace` varchar(30)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `menu_generos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `menu_generos` (
`enlace` varchar(30)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `menu_libros`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `menu_libros` (
`enlace` varchar(30)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `nombre_autor`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `nombre_autor` (
`nombre` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE `paises` (
  `id_pais` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`id_pais`, `nombre`) VALUES
(1, 'Reino Unido'),
(2, 'España');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportan`
--

CREATE TABLE `reportan` (
  `id_reportan` int(11) NOT NULL,
  `id_libro` int(11) DEFAULT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reportan`
--

INSERT INTO `reportan` (`id_reportan`, `id_libro`, `id_venta`, `cantidad`) VALUES
(1, 1, 1, 2),
(2, 2, 3, 1),
(3, 3, 2, 1),
(7, 1, 3, 1),
(8, 1, 2, 3),
(9, 2, 3, 1),
(10, 3, 3, 4),
(11, 3, 1, 1);

--
-- Disparadores `reportan`
--
DELIMITER $$
CREATE TRIGGER `actualizar_stock` AFTER INSERT ON `reportan` FOR EACH ROW BEGIN
delete from aux_mas_vendidos where id_aux_mas_vendidos != 0;
update libros set stock = stock - new.cantidad where id_libro = new.id_libro;
call `insert_aux`();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `textos`
--

CREATE TABLE `textos` (
  `id_texto` int(11) NOT NULL,
  `texto` varchar(500) DEFAULT NULL,
  `zona` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `textos`
--

INSERT INTO `textos` (`id_texto`, `texto`, `zona`) VALUES
(1, 'texto de harry potter', 'libros'),
(2, 'texto del señor de los anillos', 'libros'),
(3, 'texto de autor rowling', 'autores'),
(4, 'texto de tolkien', 'autores'),
(5, 'texto de la resistencia', 'libros'),
(6, 'texto de laura gallego', 'autores'),
(7, 'texto de la buena suerte', 'libros'),
(8, 'texto de baztan', 'libros'),
(9, 'texto de rosa montero', 'autores'),
(10, 'texto de dolores redondo', 'autores'),
(11, 'texto evento', 'eventos');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `texto_autor`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `texto_autor` (
`texto` varchar(500)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `fecha_venta` date DEFAULT NULL,
  `precio_total` double(16,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `fecha_venta`, `precio_total`) VALUES
(1, '2024-03-21', 40.25),
(2, '2024-03-21', 20.40),
(3, '2024-03-21', 50.99);

-- --------------------------------------------------------

--
-- Estructura para la vista `autores_info`
--
DROP TABLE IF EXISTS `autores_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `autores_info`  AS SELECT `i`.`enlace` AS `enlace`, `a`.`nombre` AS `nombre`, `t`.`texto` AS `texto` FROM ((`autores` `a` join `textos` `t` on(`a`.`id_texto` = `t`.`id_texto`)) join `imagenes` `i` on(`i`.`id_imagen` = `a`.`id_imagen`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `buscador_libros`
--
DROP TABLE IF EXISTS `buscador_libros`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `buscador_libros`  AS SELECT `imagenes_libros_generos_texto_autores_texto`.`enlace` AS `enlace`, `imagenes_libros_generos_texto_autores_texto`.`titulo` AS `titulo`, `imagenes_libros_generos_texto_autores_texto`.`valoracion` AS `valoracion`, `imagenes_libros_generos_texto_autores_texto`.`genero` AS `genero`, `imagenes_libros_generos_texto_autores_texto`.`libro` AS `libro`, `imagenes_libros_generos_texto_autores_texto`.`nombre_autor` AS `nombre_autor`, `imagenes_libros_generos_texto_autores_texto`.`apellidos` AS `apellidos`, `imagenes_libros_generos_texto_autores_texto`.`autor` AS `autor` FROM `imagenes_libros_generos_texto_autores_texto` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `cabecera_logo`
--
DROP TABLE IF EXISTS `cabecera_logo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cabecera_logo`  AS SELECT `imagenes`.`enlace` AS `enlace` FROM `imagenes` WHERE `imagenes`.`zona` like 'cab%' ;

-- --------------------------------------------------------

--
-- Estructura para la vista `eventos_info`
--
DROP TABLE IF EXISTS `eventos_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `eventos_info`  AS SELECT `e`.`nombre` AS `nombre`, `e`.`dia` AS `dia`, `t`.`texto` AS `texto` FROM (`eventos` `e` join `textos` `t` on(`e`.`id_texto` = `t`.`id_texto`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `genero_cuatro`
--
DROP TABLE IF EXISTS `genero_cuatro`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `genero_cuatro`  AS SELECT `generos`.`enlace` AS `enlace` FROM `generos` WHERE `generos`.`id_genero` = 4 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `genero_dos`
--
DROP TABLE IF EXISTS `genero_dos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `genero_dos`  AS SELECT `generos`.`enlace` AS `enlace` FROM `generos` WHERE `generos`.`id_genero` = 2 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `genero_tres`
--
DROP TABLE IF EXISTS `genero_tres`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `genero_tres`  AS SELECT `generos`.`enlace` AS `enlace` FROM `generos` WHERE `generos`.`id_genero` = 3 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `genero_uno`
--
DROP TABLE IF EXISTS `genero_uno`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `genero_uno`  AS SELECT `generos`.`enlace` AS `enlace` FROM `generos` WHERE `generos`.`id_genero` = 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `imagenes_libros_generos_texto_autores_texto`
--
DROP TABLE IF EXISTS `imagenes_libros_generos_texto_autores_texto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `imagenes_libros_generos_texto_autores_texto`  AS SELECT `i`.`enlace` AS `enlace`, `l`.`titulo` AS `titulo`, `l`.`valoracion` AS `valoracion`, `g`.`nombre` AS `genero`, `t`.`texto` AS `libro`, `a`.`nombre` AS `nombre_autor`, `a`.`apellidos` AS `apellidos`, `te`.`texto` AS `autor` FROM ((((((`libros` `l` join `escriben` `e` on(`l`.`id_libro` = `e`.`id_libro`)) join `autores` `a` on(`e`.`id_autor` = `a`.`id_autor`)) join `textos` `t` on(`t`.`id_texto` = `l`.`id_texto`)) join `textos` `te` on(`te`.`id_texto` = `a`.`id_texto`)) join `generos` `g` on(`g`.`id_genero` = `l`.`id_genero`)) join `imagenes` `i` on(`l`.`id_imagen` = `i`.`id_imagen`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `imagen_autor`
--
DROP TABLE IF EXISTS `imagen_autor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `imagen_autor`  AS SELECT `autores_info`.`enlace` AS `enlace` FROM `autores_info` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `libros_mas_vendidos`
--
DROP TABLE IF EXISTS `libros_mas_vendidos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `libros_mas_vendidos`  AS SELECT `mas_vendidos`.`id_libro` AS `id_libro`, count(0) AS `num_ventas`, `mas_vendidos`.`enlace` AS `enlace`, `mas_vendidos`.`titulo` AS `titulo`, `mas_vendidos`.`texto` AS `texto` FROM `mas_vendidos` GROUP BY `mas_vendidos`.`titulo` ORDER BY count(0) DESC, `mas_vendidos`.`titulo` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `mas_vendidos`
--
DROP TABLE IF EXISTS `mas_vendidos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mas_vendidos`  AS SELECT `l`.`id_libro` AS `id_libro`, `r`.`id_reportan` AS `id_reportan`, `i`.`enlace` AS `enlace`, `l`.`titulo` AS `titulo`, `t`.`texto` AS `texto` FROM (((`reportan` `r` join `libros` `l` on(`r`.`id_libro` = `l`.`id_libro`)) join `imagenes` `i` on(`i`.`id_imagen` = `l`.`id_imagen`)) join `textos` `t` on(`t`.`id_texto` = `l`.`id_texto`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `menu_autores`
--
DROP TABLE IF EXISTS `menu_autores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `menu_autores`  AS SELECT `menu`.`enlace` AS `enlace` FROM `menu` WHERE `menu`.`id_menu` = 4 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `menu_contacto`
--
DROP TABLE IF EXISTS `menu_contacto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `menu_contacto`  AS SELECT `menu`.`enlace` AS `enlace` FROM `menu` WHERE `menu`.`id_menu` = 5 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `menu_eventos`
--
DROP TABLE IF EXISTS `menu_eventos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `menu_eventos`  AS SELECT `menu`.`enlace` AS `enlace` FROM `menu` WHERE `menu`.`id_menu` = 2 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `menu_generos`
--
DROP TABLE IF EXISTS `menu_generos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `menu_generos`  AS SELECT `menu`.`enlace` AS `enlace` FROM `menu` WHERE `menu`.`id_menu` = 3 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `menu_libros`
--
DROP TABLE IF EXISTS `menu_libros`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `menu_libros`  AS SELECT `menu`.`enlace` AS `enlace` FROM `menu` WHERE `menu`.`id_menu` = 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `nombre_autor`
--
DROP TABLE IF EXISTS `nombre_autor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nombre_autor`  AS SELECT `autores_info`.`nombre` AS `nombre` FROM `autores_info` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `texto_autor`
--
DROP TABLE IF EXISTS `texto_autor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `texto_autor`  AS SELECT `autores_info`.`texto` AS `texto` FROM `autores_info` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autores`
--
ALTER TABLE `autores`
  ADD PRIMARY KEY (`id_autor`),
  ADD KEY `id_texto` (`id_texto`),
  ADD KEY `id_pais` (`id_pais`),
  ADD KEY `id_imagen` (`id_imagen`);

--
-- Indices de la tabla `contacto`
--
ALTER TABLE `contacto`
  ADD PRIMARY KEY (`id_contacto`);

--
-- Indices de la tabla `editan`
--
ALTER TABLE `editan`
  ADD PRIMARY KEY (`id_editan`),
  ADD KEY `id_libro` (`id_libro`),
  ADD KEY `id_editorial` (`id_editorial`);

--
-- Indices de la tabla `editoriales`
--
ALTER TABLE `editoriales`
  ADD PRIMARY KEY (`id_editorial`);

--
-- Indices de la tabla `escriben`
--
ALTER TABLE `escriben`
  ADD PRIMARY KEY (`id_escriben`),
  ADD KEY `id_autor` (`id_autor`),
  ADD KEY `id_libro` (`id_libro`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `id_texto` (`id_texto`);

--
-- Indices de la tabla `generos`
--
ALTER TABLE `generos`
  ADD PRIMARY KEY (`id_genero`);

--
-- Indices de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`id_imagen`);

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`id_libro`),
  ADD KEY `id_genero` (`id_genero`),
  ADD KEY `id_texto` (`id_texto`),
  ADD KEY `id_imagen` (`id_imagen`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indices de la tabla `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`id_pais`);

--
-- Indices de la tabla `reportan`
--
ALTER TABLE `reportan`
  ADD PRIMARY KEY (`id_reportan`),
  ADD KEY `id_libro` (`id_libro`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `textos`
--
ALTER TABLE `textos`
  ADD PRIMARY KEY (`id_texto`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autores`
--
ALTER TABLE `autores`
  MODIFY `id_autor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `contacto`
--
ALTER TABLE `contacto`
  MODIFY `id_contacto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `editan`
--
ALTER TABLE `editan`
  MODIFY `id_editan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `editoriales`
--
ALTER TABLE `editoriales`
  MODIFY `id_editorial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `escriben`
--
ALTER TABLE `escriben`
  MODIFY `id_escriben` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `generos`
--
ALTER TABLE `generos`
  MODIFY `id_genero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `id_imagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `id_libro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `paises`
--
ALTER TABLE `paises`
  MODIFY `id_pais` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `reportan`
--
ALTER TABLE `reportan`
  MODIFY `id_reportan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `textos`
--
ALTER TABLE `textos`
  MODIFY `id_texto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `autores`
--
ALTER TABLE `autores`
  ADD CONSTRAINT `autores_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`),
  ADD CONSTRAINT `autores_ibfk_2` FOREIGN KEY (`id_texto`) REFERENCES `textos` (`id_texto`),
  ADD CONSTRAINT `autores_ibfk_3` FOREIGN KEY (`id_imagen`) REFERENCES `imagenes` (`id_imagen`);

--
-- Filtros para la tabla `editan`
--
ALTER TABLE `editan`
  ADD CONSTRAINT `editan_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`),
  ADD CONSTRAINT `editan_ibfk_2` FOREIGN KEY (`id_editorial`) REFERENCES `editoriales` (`id_editorial`);

--
-- Filtros para la tabla `escriben`
--
ALTER TABLE `escriben`
  ADD CONSTRAINT `escriben_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`),
  ADD CONSTRAINT `escriben_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `autores` (`id_autor`);

--
-- Filtros para la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`id_texto`) REFERENCES `textos` (`id_texto`);

--
-- Filtros para la tabla `libros`
--
ALTER TABLE `libros`
  ADD CONSTRAINT `libros_ibfk_1` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id_genero`),
  ADD CONSTRAINT `libros_ibfk_2` FOREIGN KEY (`id_texto`) REFERENCES `textos` (`id_texto`),
  ADD CONSTRAINT `libros_ibfk_3` FOREIGN KEY (`id_imagen`) REFERENCES `imagenes` (`id_imagen`);

--
-- Filtros para la tabla `reportan`
--
ALTER TABLE `reportan`
  ADD CONSTRAINT `reportan_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`),
  ADD CONSTRAINT `reportan_ibfk_2` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
