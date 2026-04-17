import { Module } from '@nestjs/common';
import { TransactionsController } from './transactions.controller';
import { TransactionsService } from './transactions.service';
import { PrismaModule } from '../prisma/prisma.module'; 

@Module({
  imports: [PrismaModule], // 🔥 WAJIB
  controllers: [TransactionsController],
  providers: [TransactionsService],
})
export class TransactionsModule {}