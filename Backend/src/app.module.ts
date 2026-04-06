import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TicketsModule } from './tickets/tickets.module';
import { TransactionsModule } from './transactions/transactions.module';

@Module({
  imports: [TicketsModule, TransactionsModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}