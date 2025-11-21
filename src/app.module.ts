import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config'; // 👈 Importar o ConfigModule
import { CustomersModule } from './customers/customers.module';
import { DatabaseModule } from './database/database.module';
import { EmployeeModule } from './employee/employee.module';

@Module({
  imports: [
    // Configura o ConfigModule para carregar o .env
    ConfigModule.forRoot({
      isGlobal: true, // Torna as variáveis acessíveis em qualquer lugar
    }),
    DatabaseModule,
    CustomersModule,
    EmployeeModule,
  ],
})
export class AppModule {}