-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 06/04/2024 às 02:26
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `b.d_rh`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `departamentos`
--

CREATE TABLE `departamentos` (
  `id_dep` int(11) NOT NULL,
  `nome_dep` varchar(50) NOT NULL,
  `total_func_dep` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `folha_pagamento`
--

CREATE TABLE `folha_pagamento` (
  `id` int(11) NOT NULL,
  `id_func` int(11) NOT NULL,
  `valor_liquido` decimal(10,2) NOT NULL CHECK (`valor_liquido` > 0),
  `descontos` decimal(10,2) NOT NULL CHECK (`descontos` > 0),
  `total_salario` decimal(10,2) NOT NULL CHECK (`total_salario` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Acionadores `folha_pagamento`
--
DELIMITER $$
CREATE TRIGGER `tr_total_salario` AFTER INSERT ON `folha_pagamento` FOR EACH ROW BEGIN
	UPDATE folha_pagamento SET total_salario = valor_liquido - descontos;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `id_func` int(11) NOT NULL,
  `nome_func` varchar(50) NOT NULL,
  `idade_func` int(11) NOT NULL,
  `dep_func` int(11) NOT NULL,
  `sexo` char(1) NOT NULL CHECK (`sexo` in ('m ','f')),
  `cpf` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `vales`
--

CREATE TABLE `vales` (
  `id_func` int(11) NOT NULL,
  `valor_vt` decimal(10,2) NOT NULL CHECK (`valor_vt` > 0),
  `valor_va` decimal(10,2) NOT NULL CHECK (`valor_va` > 0),
  `plano_saude` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id_dep`);

--
-- Índices de tabela `folha_pagamento`
--
ALTER TABLE `folha_pagamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_folha_func` (`id_func`);

--
-- Índices de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id_func`),
  ADD KEY `fk_dep_fun` (`dep_func`);

--
-- Índices de tabela `vales`
--
ALTER TABLE `vales`
  ADD KEY `fk_func_vales` (`id_func`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id_dep` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `folha_pagamento`
--
ALTER TABLE `folha_pagamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `id_func` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `folha_pagamento`
--
ALTER TABLE `folha_pagamento`
  ADD CONSTRAINT `fk_folha_func` FOREIGN KEY (`id_func`) REFERENCES `funcionarios` (`id_func`);

--
-- Restrições para tabelas `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD CONSTRAINT `fk_dep_fun` FOREIGN KEY (`dep_func`) REFERENCES `departamentos` (`id_dep`);

--
-- Restrições para tabelas `vales`
--
ALTER TABLE `vales`
  ADD CONSTRAINT `fk_func_vales` FOREIGN KEY (`id_func`) REFERENCES `funcionarios` (`id_func`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
