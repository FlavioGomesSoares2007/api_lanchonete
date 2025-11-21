import { Injectable } from '@nestjs/common';
import { PrismaService } from '../database/prisma.service';
import { Prisma } from '@prisma/client';
import * as bcrypt from 'bcrypt';

@Injectable()
export class EmployeeService {
  constructor(private prisma: PrismaService) {}
// EmployeeService - VERSÃO OTIMIZADA

async addEmployee(data: Prisma.funcionariosCreateInput) {
  const { senha,...funcionarioData } = data;

  const hashedPassword = await bcrypt.hash(senha, 10); 

  return this.prisma.funcionarios.create({
    data: {
      ...funcionarioData,
      senha: hashedPassword
    },
  });
}

    
}