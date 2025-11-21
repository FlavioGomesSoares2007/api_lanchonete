import { Module } from '@nestjs/common';
import { EmployeeController } from './employee.controller';
import { EmployeeService } from './employee.service';
import { PositionsModule } from './positions/positions.module';
import { DatabaseModule } from '../database/database.module';

@Module({
  controllers: [EmployeeController],
  providers: [EmployeeService],
  imports: [PositionsModule, DatabaseModule]
})
export class EmployeeModule {}
