import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { EmployeeService } from './employee.service';
import { Prisma } from '@prisma/client';
import { AdminAuthGuard } from '../common/guards/admin-auth.guard';


@Controller('employee')
export class EmployeeController {
  constructor(private readonly employeeService: EmployeeService) {}

  @Post('add/')
  @UseGuards(AdminAuthGuard)
  addEmployee(@Body() data: Prisma.funcionariosCreateInput) {
    return this.employeeService.addEmployee(data);
  }
  
}