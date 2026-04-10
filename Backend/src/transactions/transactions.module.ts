import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Transaction } from './transactions.entity';
import { Ticket } from '../tickets/tickets.entity';
import { TransactionsController } from './transactions.controller';
import { TransactionsService } from './transactions.service';

@Module({
  imports: [TypeOrmModule.forFeature([Transaction, Ticket])],
  controllers: [TransactionsController],
  providers: [TransactionsService],
})
export class TransactionsModule {}