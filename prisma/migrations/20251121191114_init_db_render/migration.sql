-- CreateEnum
CREATE TYPE "pedidos_status_pedido" AS ENUM ('em preparo', 'pronto', 'entregue', 'cancelado');

-- CreateTable
CREATE TABLE "cargos" (
    "id_cargo" SERIAL NOT NULL,
    "nome_cargo" VARCHAR(100) NOT NULL,

    CONSTRAINT "cargos_pkey" PRIMARY KEY ("id_cargo")
);

-- CreateTable
CREATE TABLE "categoria" (
    "id_categoria" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,

    CONSTRAINT "categoria_pkey" PRIMARY KEY ("id_categoria")
);

-- CreateTable
CREATE TABLE "clientes" (
    "id_cliente" SERIAL NOT NULL,
    "nome" VARCHAR(20) NOT NULL,
    "sobre_nome" VARCHAR(45) NOT NULL,
    "senha" VARCHAR(1000) NOT NULL,

    CONSTRAINT "clientes_pkey" PRIMARY KEY ("id_cliente")
);

-- CreateTable
CREATE TABLE "contato" (
    "id_contato" SERIAL NOT NULL,
    "telefone" VARCHAR(30) NOT NULL,
    "email" VARCHAR(300) NOT NULL,
    "id_cliente" INTEGER,
    "id_funcionario" INTEGER,

    CONSTRAINT "contato_pkey" PRIMARY KEY ("id_contato")
);

-- CreateTable
CREATE TABLE "endereco" (
    "id_endereco" SERIAL NOT NULL,
    "logradouro" VARCHAR(100) NOT NULL,
    "numero" VARCHAR(45) NOT NULL,
    "complemento" VARCHAR(100),
    "id_cliente" INTEGER,
    "id_funcionario" INTEGER,

    CONSTRAINT "endereco_pkey" PRIMARY KEY ("id_endereco")
);

-- CreateTable
CREATE TABLE "funcionarios" (
    "id_funcionario" SERIAL NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "senha" VARCHAR(1000) NOT NULL,
    "matricula" VARCHAR(45) NOT NULL,
    "data_contratacao" DATE NOT NULL,
    "salario_base" DECIMAL(10,2) NOT NULL,
    "ativo" BOOLEAN NOT NULL,
    "id_cargo" INTEGER NOT NULL,

    CONSTRAINT "funcionarios_pkey" PRIMARY KEY ("id_funcionario")
);

-- CreateTable
CREATE TABLE "itens_pedido" (
    "id_itensPedido" SERIAL NOT NULL,
    "id_pedido" INTEGER NOT NULL,
    "id_produto" INTEGER NOT NULL,
    "quantidade" INTEGER NOT NULL,
    "observacoes" VARCHAR(255),

    CONSTRAINT "itens_pedido_pkey" PRIMARY KEY ("id_itensPedido")
);

-- CreateTable
CREATE TABLE "mesas" (
    "id_mesa" SERIAL NOT NULL,
    "nomero_mesa" VARCHAR(45) NOT NULL,

    CONSTRAINT "mesas_pkey" PRIMARY KEY ("id_mesa")
);

-- CreateTable
CREATE TABLE "pedidos" (
    "id_pedido" SERIAL NOT NULL,
    "data_hora_abertura" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_hora_entrega" TIMESTAMPTZ(3),
    "status_pedido" "pedidos_status_pedido" NOT NULL,
    "observacoes" VARCHAR(250),
    "id_cliente" INTEGER NOT NULL,
    "id_mesa" INTEGER,
    "id_funcionario" INTEGER NOT NULL,
    "id_endereco" INTEGER,

    CONSTRAINT "pedidos_pkey" PRIMARY KEY ("id_pedido")
);

-- CreateTable
CREATE TABLE "produtos" (
    "id_produto" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "preco" DECIMAL(10,2) NOT NULL,
    "descricao" VARCHAR(45) NOT NULL,
    "disponivel" BOOLEAN NOT NULL,
    "tempo_preparo" SMALLINT NOT NULL,
    "id_categoria" INTEGER NOT NULL,

    CONSTRAINT "produtos_pkey" PRIMARY KEY ("id_produto")
);

-- CreateIndex
CREATE UNIQUE INDEX "cargos_nome_cargo_UNIQUE" ON "cargos"("nome_cargo");

-- CreateIndex
CREATE UNIQUE INDEX "categoria_nome_UNIQUE" ON "categoria"("nome");

-- CreateIndex
CREATE UNIQUE INDEX "contato_telefone_UNIQUE" ON "contato"("telefone");

-- CreateIndex
CREATE UNIQUE INDEX "contato_email_UNIQUE" ON "contato"("email");

-- CreateIndex
CREATE INDEX "contato_id_cliente_idx" ON "contato"("id_cliente");

-- CreateIndex
CREATE INDEX "contato_id_funcionario_idx" ON "contato"("id_funcionario");

-- CreateIndex
CREATE INDEX "endereco_id_cliente_idx" ON "endereco"("id_cliente");

-- CreateIndex
CREATE INDEX "endereco_id_funcionario_idx" ON "endereco"("id_funcionario");

-- CreateIndex
CREATE UNIQUE INDEX "funcionarios_matricula_UNIQUE" ON "funcionarios"("matricula");

-- CreateIndex
CREATE INDEX "funcionarios_id_cargo_idx" ON "funcionarios"("id_cargo");

-- CreateIndex
CREATE INDEX "itens_pedido_id_pedido_idx" ON "itens_pedido"("id_pedido");

-- CreateIndex
CREATE INDEX "itens_pedido_id_produto_idx" ON "itens_pedido"("id_produto");

-- CreateIndex
CREATE UNIQUE INDEX "mesas_nomero_mesa_UNIQUE" ON "mesas"("nomero_mesa");

-- CreateIndex
CREATE INDEX "pedidos_id_cliente_idx" ON "pedidos"("id_cliente");

-- CreateIndex
CREATE INDEX "pedidos_id_endereco_idx" ON "pedidos"("id_endereco");

-- CreateIndex
CREATE INDEX "pedidos_id_funcionario_idx" ON "pedidos"("id_funcionario");

-- CreateIndex
CREATE INDEX "pedidos_id_mesa_idx" ON "pedidos"("id_mesa");

-- CreateIndex
CREATE UNIQUE INDEX "produtos_nome_UNIQUE" ON "produtos"("nome");

-- CreateIndex
CREATE INDEX "produtos_id_categoria_idx" ON "produtos"("id_categoria");

-- AddForeignKey
ALTER TABLE "contato" ADD CONSTRAINT "fk_contato_cliente" FOREIGN KEY ("id_cliente") REFERENCES "clientes"("id_cliente") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "contato" ADD CONSTRAINT "fk_contato_funcionario" FOREIGN KEY ("id_funcionario") REFERENCES "funcionarios"("id_funcionario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "endereco" ADD CONSTRAINT "fk_endereco_cliente" FOREIGN KEY ("id_cliente") REFERENCES "clientes"("id_cliente") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "endereco" ADD CONSTRAINT "fk_endereco_funcionario" FOREIGN KEY ("id_funcionario") REFERENCES "funcionarios"("id_funcionario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "funcionarios" ADD CONSTRAINT "fk_funcionarios_cargo" FOREIGN KEY ("id_cargo") REFERENCES "cargos"("id_cargo") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "itens_pedido" ADD CONSTRAINT "fk_itenspedido_pedido" FOREIGN KEY ("id_pedido") REFERENCES "pedidos"("id_pedido") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "itens_pedido" ADD CONSTRAINT "fk_itenspedido_produto" FOREIGN KEY ("id_produto") REFERENCES "produtos"("id_produto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedidos" ADD CONSTRAINT "fk_pedidos_cliente" FOREIGN KEY ("id_cliente") REFERENCES "clientes"("id_cliente") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedidos" ADD CONSTRAINT "fk_pedidos_endereco" FOREIGN KEY ("id_endereco") REFERENCES "endereco"("id_endereco") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedidos" ADD CONSTRAINT "fk_pedidos_funcionario" FOREIGN KEY ("id_funcionario") REFERENCES "funcionarios"("id_funcionario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pedidos" ADD CONSTRAINT "fk_pedidos_mesa" FOREIGN KEY ("id_mesa") REFERENCES "mesas"("id_mesa") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "produtos" ADD CONSTRAINT "fk_produtos_categoria" FOREIGN KEY ("id_categoria") REFERENCES "categoria"("id_categoria") ON DELETE NO ACTION ON UPDATE NO ACTION;
