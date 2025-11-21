-- CreateTable
CREATE TABLE `cargos` (
    `id_cargo` INTEGER NOT NULL AUTO_INCREMENT,
    `nome_cargo` VARCHAR(100) NOT NULL,

    UNIQUE INDEX `nome_cargo_UNIQUE`(`nome_cargo`),
    PRIMARY KEY (`id_cargo`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categoria` (
    `id_categoria` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(45) NOT NULL,

    UNIQUE INDEX `nome_UNIQUE`(`nome`),
    PRIMARY KEY (`id_categoria`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `clientes` (
    `id_cliente` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(20) NOT NULL,
    `sobre_nome` VARCHAR(45) NOT NULL,
    `senha` VARCHAR(1000) NOT NULL,

    PRIMARY KEY (`id_cliente`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contato` (
    `id_contato` INTEGER NOT NULL AUTO_INCREMENT,
    `telefone` VARCHAR(30) NOT NULL,
    `email` VARCHAR(300) NOT NULL,
    `id_cliente` INTEGER NULL,
    `id_funcionario` INTEGER NULL,

    UNIQUE INDEX `telefone_UNIQUE`(`telefone`),
    UNIQUE INDEX `email_UNIQUE`(`email`),
    INDEX `id_cliente_idx`(`id_cliente`),
    INDEX `id_funcionario_idx`(`id_funcionario`),
    PRIMARY KEY (`id_contato`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `endereco` (
    `id_endereco` INTEGER NOT NULL AUTO_INCREMENT,
    `logradouro` VARCHAR(100) NOT NULL,
    `numero` VARCHAR(45) NOT NULL,
    `complemento` VARCHAR(100) NULL,
    `id_cliente` INTEGER NULL,
    `id_funcionario` INTEGER NULL,

    INDEX `id_cliente_idx`(`id_cliente`),
    INDEX `id_funcionario_idx`(`id_funcionario`),
    PRIMARY KEY (`id_endereco`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `funcionarios` (
    `id_funcionario` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,
    `senha` VARCHAR(1000) NOT NULL,
    `matricula` VARCHAR(45) NOT NULL,
    `data_contratacao` DATE NOT NULL,
    `salario_base` DECIMAL(10, 2) NOT NULL,
    `ativo` TINYINT NOT NULL,
    `id_cargo` INTEGER NOT NULL,

    UNIQUE INDEX `matricula_UNIQUE`(`matricula`),
    INDEX `id_cargo_idx`(`id_cargo`),
    PRIMARY KEY (`id_funcionario`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `itens_pedido` (
    `id_itensPedido` INTEGER NOT NULL AUTO_INCREMENT,
    `id_pedido` INTEGER NOT NULL,
    `id_produto` INTEGER NOT NULL,
    `quantidade` INTEGER NOT NULL,
    `observacoes` VARCHAR(255) NULL,

    INDEX `id_pedido_idx`(`id_pedido`),
    INDEX `id_produto_idx`(`id_produto`),
    PRIMARY KEY (`id_itensPedido`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mesas` (
    `id_mesa` INTEGER NOT NULL AUTO_INCREMENT,
    `nomero_mesa` VARCHAR(45) NOT NULL,

    UNIQUE INDEX `nomero_mesa_UNIQUE`(`nomero_mesa`),
    PRIMARY KEY (`id_mesa`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pedidos` (
    `id_pedido` INTEGER NOT NULL AUTO_INCREMENT,
    `data_hora_abertura` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `data_hora_entrega` TIMESTAMP(0) NULL,
    `status_pedido` ENUM('em preparo', 'pronto', 'entregue', 'cancelado') NOT NULL,
    `observacoes` VARCHAR(250) NULL,
    `id_cliente` INTEGER NOT NULL,
    `id_mesa` INTEGER NULL,
    `id_funcionario` INTEGER NOT NULL,
    `id_endereco` INTEGER NULL,

    INDEX `id_cliente_idx`(`id_cliente`),
    INDEX `id_endereco_idx`(`id_endereco`),
    INDEX `id_funcionario_idx`(`id_funcionario`),
    INDEX `id_mesa_idx`(`id_mesa`),
    PRIMARY KEY (`id_pedido`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `produtos` (
    `id_produto` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(45) NOT NULL,
    `preco` DECIMAL(10, 2) NOT NULL,
    `descricao` VARCHAR(45) NOT NULL,
    `disponivel` TINYINT NOT NULL,
    `tempo_preparo` SMALLINT NOT NULL,
    `id_categoria` INTEGER NOT NULL,

    UNIQUE INDEX `nome_UNIQUE`(`nome`),
    INDEX `id_categoria_idx`(`id_categoria`),
    PRIMARY KEY (`id_produto`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `contato` ADD CONSTRAINT `fk_contato_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes`(`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `contato` ADD CONSTRAINT `fk_contato_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios`(`id_funcionario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `endereco` ADD CONSTRAINT `fk_endereco_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes`(`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `endereco` ADD CONSTRAINT `fk_endereco_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios`(`id_funcionario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `funcionarios` ADD CONSTRAINT `fk_funcionarios_cargo` FOREIGN KEY (`id_cargo`) REFERENCES `cargos`(`id_cargo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `itens_pedido` ADD CONSTRAINT `fk_itenspedido_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos`(`id_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `itens_pedido` ADD CONSTRAINT `fk_itenspedido_produto` FOREIGN KEY (`id_produto`) REFERENCES `produtos`(`id_produto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pedidos` ADD CONSTRAINT `fk_pedidos_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes`(`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pedidos` ADD CONSTRAINT `fk_pedidos_endereco` FOREIGN KEY (`id_endereco`) REFERENCES `endereco`(`id_endereco`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pedidos` ADD CONSTRAINT `fk_pedidos_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios`(`id_funcionario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pedidos` ADD CONSTRAINT `fk_pedidos_mesa` FOREIGN KEY (`id_mesa`) REFERENCES `mesas`(`id_mesa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `produtos` ADD CONSTRAINT `fk_produtos_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria`(`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;
