import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TicketsModule } from './tickets/tickets.module';
import { TransactionsModule } from './transactions/transactions.module';

// 🔥 TAMBAH INI
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    // 🔥 KONEKSI DATABASE
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      username: 'postgres',
      password: 'postgres', // ganti!
      database: 'pooltick',
      autoLoadEntities: true,
      synchronize: true,
    }),

    // module lu
    TicketsModule,
    TransactionsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}