-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-01-2019 a las 18:54:07
-- Versión del servidor: 10.1.29-MariaDB
-- Versión de PHP: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbclinica_web`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPActualizarPaciente` (IN `prmId` INT, IN `prmDireccion` VARCHAR(50))  NO SQL
BEGIN
	UPDATE paciente SET direccion=prmDireccion WHERE idPaciente=prmId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPBuscarMedico` (IN `prmDni` INT)  NO SQL
BEGIN
	SELECT M.idMedico, E.idEmpleado, E.nombres, E.apPaterno	, E.apMaterno, S.idEspecialidad, S.descripcion, M.estado as estadoMedico    
    FROM medico M INNER JOIN empleado E ON M.idEmpleado=E.idEmpleado
    INNER JOIN especialidad S ON S.idEspecialidad=M.idEspecialidad
    WHERE m.estado=1 AND E.nroDocumento=prmDni;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPConsultarPacientes` ()  NO SQL
BEGIN
	SELECT p.idPaciente,
    		p.nombres,
            p.apPaterno,
            p.apMaterno,
            p.edad,
            p.sexo,
            p.nroDocumento,
            p.direccion
    FROM paciente p
    WHERE p.estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPEliminarPaciente` (IN `prmIDPaciente` INT)  NO SQL
BEGIN
	UPDATE paciente SET estado=0 WHERE idpaciente=prmIDPaciente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPLogin` (IN `prmUser` VARCHAR(50), IN `prmPass` VARCHAR(50))  BEGIN
	SELECT E.idEmpleado, E.usuario, E.clave
	FROM Empleado E
	WHERE E.usuario = prmUser AND E.clave = prmPass;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPRegistrarHorarioAtencion` (IN `prmIdMedico` INT, IN `prmHora` VARCHAR(5), IN `prmFecha` DATE)  NO SQL
BEGIN
DECLARE HoraNueva int;
DECLARE idHorarioAtencion int;	
	
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    	GET DIAGNOSTICS CONDITION 1
        	@state = RETURNED_SQLSTATE, 
            @rtc    = MYSQL_ERRNO,
            @rmg    = MESSAGE_TEXT; -- MySQL 5.6 > : comment diagnostics for lower versions
            ROLLBACK;
        END;
        
    /*Obtener el ID del parametro Hora*/
    /*SET @HoraNueva := (*/
    SELECT h.idHora INTO HoraNueva
    FROM hora h WHERE h.hora = prmHora;
    
    /* Realizamos el Insert */
    INSERT INTO HorarioAtencion(idMedico, fecha, idHoraInicio, Estado)
    VALUES (prmIdMedico, prmFecha, HoraNueva, 1);
    
    /* Obtenemos el Ultimo Registro Insertado en la Tabla HorarioAtencion */    
    SET @idHorarioAtencion := (SELECT LAST_INSERT_ID());
    
    SELECT ha.idHorarioAtencion, ha.fecha, h.idHora, h.hora, ha.estado
    FROM horarioatencion ha
    INNER JOIN hora h on ha.idHoraInicio=h.idHora
    WHERE ha.idHorarioAtencion=@idHorarioAtencion;
    
    /*COMMIT;*/
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SPRegistrarPaciente` (IN `prmNombres` VARCHAR(50), IN `prmApellidoUno` VARCHAR(20), IN `prmApellidoDos` VARCHAR(20), IN `prmEdad` INT(11), IN `prmSexo` CHAR(1), IN `prmNroDocumento` VARCHAR(8), IN `prmDireccion` VARCHAR(150), IN `prmTelefono` VARCHAR(20), IN `prmEstado` TINYINT(4))  NO SQL
BEGIN
	INSERT INTO paciente (nombres, apPaterno, apMaterno, edad, sexo, nroDocumento, direccion, telefono, estado)
    VALUES (prmNombres, prmApellidoUno, prmApellidoDos, prmEdad, prmSexo, prmNroDocumento, prmDireccion,prmTelefono, prmEstado);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aseguradora`
--

CREATE TABLE `aseguradora` (
  `idAseguradora` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `telefono` varchar(12) DEFAULT NULL,
  `direccion` varchar(120) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `idCita` int(11) NOT NULL,
  `idMedico` int(11) NOT NULL,
  `idPaciente` int(11) NOT NULL,
  `fechaReserva` datetime(3) DEFAULT NULL,
  `observacion` varchar(350) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL,
  `hora` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleaseguradora`
--

CREATE TABLE `detalleaseguradora` (
  `idDetAseguradora` int(11) NOT NULL,
  `idAseguradora` int(11) DEFAULT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `tipoSeguroSalud` varchar(50) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diagnostico`
--

CREATE TABLE `diagnostico` (
  `idDiagnostico` int(11) NOT NULL,
  `idHistoriaClinica` int(11) NOT NULL,
  `fechaEmision` datetime(3) DEFAULT NULL,
  `observacion` varchar(500) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diasemana`
--

CREATE TABLE `diasemana` (
  `idDiaSemana` int(11) NOT NULL,
  `nombreDiaSemana` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idEmpleado` int(11) NOT NULL,
  `idTipoEmpleado` int(11) NOT NULL,
  `nombres` varchar(50) DEFAULT NULL,
  `apPaterno` varchar(20) DEFAULT NULL,
  `apMaterno` varchar(20) DEFAULT NULL,
  `nroDocumento` varchar(8) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  `imagen` varchar(500) DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `clave` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `idTipoEmpleado`, `nombres`, `apPaterno`, `apMaterno`, `nroDocumento`, `estado`, `imagen`, `usuario`, `clave`) VALUES
(1, 1, 'Felipe', 'Llanos', 'Betancourt', '1', 0, NULL, 'devfko', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `idEspecialidad` int(11) NOT NULL,
  `descripcion` varchar(25) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`idEspecialidad`, `descripcion`, `estado`) VALUES
(1, 'Medicina General', 1),
(2, 'Odontologia', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historiaclinica`
--

CREATE TABLE `historiaclinica` (
  `idHistoriaClinica` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `fechaApertura` datetime(3) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hora`
--

CREATE TABLE `hora` (
  `idHora` int(11) NOT NULL,
  `hora` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `hora`
--

INSERT INTO `hora` (`idHora`, `hora`) VALUES
(1, '12:00'),
(2, '12:30'),
(3, '13:00'),
(4, '13:30'),
(5, '14:00'),
(6, '14:30'),
(7, '15:00'),
(8, '15:30'),
(9, '16:00'),
(10, '16:30'),
(11, '17:00'),
(12, '17:30'),
(13, '18:00'),
(14, '18:30'),
(15, '19:00'),
(16, '19:30'),
(17, '20:00'),
(18, '20:30'),
(19, '21:00'),
(20, '21:30'),
(21, '22:00'),
(22, '22:30'),
(23, '23:00'),
(24, '23:30'),
(25, '00:00'),
(26, '00:30'),
(27, '01:00'),
(28, '01:30'),
(29, '02:00'),
(30, '02:30'),
(31, '03:00'),
(32, '03:30'),
(33, '04:00'),
(34, '04:30'),
(35, '05:00'),
(36, '05:30'),
(37, '06:00'),
(38, '06:30'),
(39, '07:00'),
(40, '07:30'),
(41, '08:00'),
(42, '08:30'),
(43, '09:00'),
(44, '09:30'),
(45, '10:00'),
(46, '10:30'),
(47, '11:00'),
(48, '11:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarioatencion`
--

CREATE TABLE `horarioatencion` (
  `idHorarioAtencion` int(11) NOT NULL,
  `idMedico` int(11) NOT NULL,
  `idHoraInicio` int(11) NOT NULL,
  `fecha` datetime(3) DEFAULT NULL,
  `fechaFin` date DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL,
  `idDiaSemana` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `horarioatencion`
--

INSERT INTO `horarioatencion` (`idHorarioAtencion`, `idMedico`, `idHoraInicio`, `fecha`, `fechaFin`, `estado`, `idDiaSemana`) VALUES
(2, 3, 4, '2012-12-12 00:00:00.000', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico`
--

CREATE TABLE `medico` (
  `idMedico` int(11) NOT NULL,
  `idEmpleado` int(11) NOT NULL,
  `idEspecialidad` int(11) NOT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `medico`
--

INSERT INTO `medico` (`idMedico`, `idEmpleado`, `idEspecialidad`, `estado`) VALUES
(3, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `idPaciente` int(11) NOT NULL,
  `nombres` varchar(50) DEFAULT NULL,
  `apPaterno` varchar(20) DEFAULT NULL,
  `apMaterno` varchar(20) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `sexo` char(1) DEFAULT NULL,
  `nroDocumento` varchar(8) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT '1',
  `imagen` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`idPaciente`, `nombres`, `apPaterno`, `apMaterno`, `edad`, `sexo`, `nroDocumento`, `direccion`, `telefono`, `estado`, `imagen`) VALUES
(1, 'Pipe', 'Llanos', 'Betancourt', 27, 'M', '11150753', 'Calle 16', '3215841265', 0, NULL),
(3, 'pedro', 'perez', 'acecas', 35, 'M', '181818', 'Calle falsa 123', '32132132', 0, NULL),
(4, 'Pipe', 'Llanos', 'Betancourt', 27, 'M', '11150753', 'Calle 16 # 5-63', '3215841265', 0, NULL),
(5, 'Pipe', 'Llanos', 'Betancourt', 27, 'M', '11150753', 'Calle 16 # 5-63', '3215841265', 0, NULL),
(6, 'pedro', 'perez', '', 35, 'M', '181818', 'Calle falsa 123', '32132132', 0, NULL),
(7, 'Pipe', 'Llanos', 'Betancourt', 27, 'M', '11150753', 'Calle 16 # 5-63', '3215841265', 0, NULL),
(8, 'pedro', 'Llanos', 'Betancourt', 27, 'M', '181818', 'Calle falsa 123', '3215841265', 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoempleado`
--

CREATE TABLE `tipoempleado` (
  `idTipoEmpleado` int(11) NOT NULL,
  `descripcion` varchar(25) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipoempleado`
--

INSERT INTO `tipoempleado` (`idTipoEmpleado`, `descripcion`, `estado`) VALUES
(1, 'Administrador', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aseguradora`
--
ALTER TABLE `aseguradora`
  ADD PRIMARY KEY (`idAseguradora`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`idCita`),
  ADD KEY `FK_Cita_Medico` (`idMedico`),
  ADD KEY `FK_Cita_Paciente` (`idPaciente`);

--
-- Indices de la tabla `detalleaseguradora`
--
ALTER TABLE `detalleaseguradora`
  ADD PRIMARY KEY (`idDetAseguradora`),
  ADD KEY `FK_DetalleAseguradora_Aseguradora` (`idAseguradora`),
  ADD KEY `FK_DetalleAseguradora_Paciente` (`idPaciente`);

--
-- Indices de la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD PRIMARY KEY (`idDiagnostico`),
  ADD KEY `FK_Diagnostico_HistoriaClinica` (`idHistoriaClinica`);

--
-- Indices de la tabla `diasemana`
--
ALTER TABLE `diasemana`
  ADD PRIMARY KEY (`idDiaSemana`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idEmpleado`),
  ADD KEY `FK_Empleado_TipoEmpleado` (`idTipoEmpleado`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`idEspecialidad`);

--
-- Indices de la tabla `historiaclinica`
--
ALTER TABLE `historiaclinica`
  ADD PRIMARY KEY (`idHistoriaClinica`),
  ADD KEY `FK_HistoriaClinica_Paciente` (`idPaciente`);

--
-- Indices de la tabla `hora`
--
ALTER TABLE `hora`
  ADD PRIMARY KEY (`idHora`);

--
-- Indices de la tabla `horarioatencion`
--
ALTER TABLE `horarioatencion`
  ADD PRIMARY KEY (`idHorarioAtencion`),
  ADD UNIQUE KEY `idMedico` (`idMedico`,`idHoraInicio`),
  ADD KEY `FK_HorarioAtencion_DiaSemana` (`idDiaSemana`),
  ADD KEY `FK_HorarioAtencion_Hora` (`idHoraInicio`);

--
-- Indices de la tabla `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`idMedico`),
  ADD KEY `FK_Medico_Empleado` (`idEmpleado`),
  ADD KEY `FK_Medico_Especialidad` (`idEspecialidad`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`idPaciente`);

--
-- Indices de la tabla `tipoempleado`
--
ALTER TABLE `tipoempleado`
  ADD PRIMARY KEY (`idTipoEmpleado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aseguradora`
--
ALTER TABLE `aseguradora`
  MODIFY `idAseguradora` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `idCita` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalleaseguradora`
--
ALTER TABLE `detalleaseguradora`
  MODIFY `idDetAseguradora` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  MODIFY `idDiagnostico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `diasemana`
--
ALTER TABLE `diasemana`
  MODIFY `idDiaSemana` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `idEspecialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `historiaclinica`
--
ALTER TABLE `historiaclinica`
  MODIFY `idHistoriaClinica` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `hora`
--
ALTER TABLE `hora`
  MODIFY `idHora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `horarioatencion`
--
ALTER TABLE `horarioatencion`
  MODIFY `idHorarioAtencion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `medico`
--
ALTER TABLE `medico`
  MODIFY `idMedico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `idPaciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tipoempleado`
--
ALTER TABLE `tipoempleado`
  MODIFY `idTipoEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `FK_Cita_Medico` FOREIGN KEY (`idMedico`) REFERENCES `medico` (`idMedico`),
  ADD CONSTRAINT `FK_Cita_Paciente` FOREIGN KEY (`idPaciente`) REFERENCES `paciente` (`idPaciente`);

--
-- Filtros para la tabla `detalleaseguradora`
--
ALTER TABLE `detalleaseguradora`
  ADD CONSTRAINT `FK_DetalleAseguradora_Aseguradora` FOREIGN KEY (`idAseguradora`) REFERENCES `aseguradora` (`idAseguradora`),
  ADD CONSTRAINT `FK_DetalleAseguradora_Paciente` FOREIGN KEY (`idPaciente`) REFERENCES `paciente` (`idPaciente`);

--
-- Filtros para la tabla `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD CONSTRAINT `FK_Diagnostico_HistoriaClinica` FOREIGN KEY (`idHistoriaClinica`) REFERENCES `historiaclinica` (`idHistoriaClinica`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `FK_Empleado_TipoEmpleado` FOREIGN KEY (`idTipoEmpleado`) REFERENCES `tipoempleado` (`idTipoEmpleado`);

--
-- Filtros para la tabla `historiaclinica`
--
ALTER TABLE `historiaclinica`
  ADD CONSTRAINT `FK_HistoriaClinica_Paciente` FOREIGN KEY (`idPaciente`) REFERENCES `paciente` (`idPaciente`);

--
-- Filtros para la tabla `horarioatencion`
--
ALTER TABLE `horarioatencion`
  ADD CONSTRAINT `FK_HorarioAtencion_DiaSemana` FOREIGN KEY (`idDiaSemana`) REFERENCES `diasemana` (`idDiaSemana`),
  ADD CONSTRAINT `FK_HorarioAtencion_Hora` FOREIGN KEY (`idHoraInicio`) REFERENCES `hora` (`idHora`),
  ADD CONSTRAINT `FK_HorarioAtencion_Medico` FOREIGN KEY (`idMedico`) REFERENCES `medico` (`idMedico`);

--
-- Filtros para la tabla `medico`
--
ALTER TABLE `medico`
  ADD CONSTRAINT `FK_Medico_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  ADD CONSTRAINT `FK_Medico_Especialidad` FOREIGN KEY (`idEspecialidad`) REFERENCES `especialidad` (`idEspecialidad`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
