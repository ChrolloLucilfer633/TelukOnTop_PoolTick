import { Module } from '@nestjs/common';
import { TicketsController } from './tickets.controller';
import { TicketsService } from './tickets.service';
import { PrismaModule } from '../prisma/prisma.module'; // 🔥 TAMBAH INI

@Module({
  imports: [PrismaModule], // 🔥 WAJIB
  controllers: [TicketsController],
  providers: [TicketsService],
})
export class TicketsModule {}