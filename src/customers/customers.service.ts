import { Injectable } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';

import * as bcrypt from 'bcrypt';
import { Prisma } from '@prisma/client';

@Injectable()
export class CustomersService {
  constructor(private prisma: PrismaService) {}

  async addCustomer(data: Prisma.clientesCreateInput) {
    const { senha, ...clienteData } = data;

    const hashedPassword = await bcrypt.hash(senha, 10);

    return this.prisma.clientes.create({
      data: {
        ...clienteData,
        senha: hashedPassword,
      },
    });
  }

  async updateCustomer(clientId: number, data: Prisma.clientesUpdateInput) {
    if (data.senha) {
      data.senha = await bcrypt.hash(data.senha as string, 10);
    }

    return this.prisma.clientes.update({
      where: {
        id_cliente: clientId,
      },
      data: data,
    });
  }

  updateContact(contactId: number, data: Prisma.contatoUpdateInput) {
    return this.prisma.contato.update({
      where: {
        id_contato: contactId,
      },
      data: data,
    });
  }

  updateAddress(addressId: number, data: Prisma.enderecoUpdateInput) {
    return this.prisma.endereco.update({
      where: {
        id_endereco: addressId,
      },
      data: data,
    });
  }

  addAddress(clientId: number, data: Prisma.enderecoCreateInput) {
    const { clientes, funcionarios, pedidos, ...addressData } = data;

    return this.prisma.endereco.create({
      data: {
        ...addressData,
        clientes: {
          connect: { 
            id_cliente: clientId
           },
        },
        funcionarios: funcionarios,
        pedidos: pedidos,
      },
    });
  }

  addContact(clientId: number, data: Prisma.contatoCreateInput) {
    const { clientes, ...contactData } = data;

    return this.prisma.contato.create({
      data: {
        ...contactData,
        clientes: {
          connect: { 
            id_cliente: clientId
           },
        },
      },
    });
  }

  readcontacts(clientId: number) {
    return this.prisma.contato.findMany({
      where: {
        id_cliente: clientId,
      },
    });
  }

  readAddresses(clientId: number) {
    return this.prisma.endereco.findMany({
      where: {
        id_cliente: clientId,
      },
    });
  }

  deleteCustomer(clientId: number) {
    return this.prisma.$transaction([
      this.prisma.endereco.deleteMany({
        where: {
          id_cliente: clientId,
        },
      }),
      this.prisma.contato.deleteMany({
        where: {
          id_cliente: clientId,
        },
      }),
      this.prisma.clientes.delete({
        where: {
          id_cliente: clientId,
        },
      }),
    ]);
  }

  deleteAddress(addressId: number) {
    return this.prisma.endereco.delete({
      where: {
        id_endereco: addressId,
      },
    });
  }

  deleteContact(contactId: number) {
    return this.prisma.contato.delete({
      where: {
        id_contato: contactId,
      },
    });
  }
}
