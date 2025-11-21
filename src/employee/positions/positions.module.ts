import { Module } from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';
import { DatabaseModule } from '../../database/database.module';

@Module({
  imports: [DatabaseModule],
  providers: [PrismaService],
  exports: [PrismaService],
})
export class PositionsModule {}
