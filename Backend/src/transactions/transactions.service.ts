import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class TransactionsService {
  constructor(private prisma: PrismaService) {}

  // 🔥 GET ALL TRANSAKSI + JOIN TICKET
  findAll() {
    return this.prisma.transaction.findMany({
      include: {
        ticket: true,
      },
    });
  }

  // 🔥 CREATE TRANSAKSI
  async create(data: any) {
    console.log("DATA MASUK:", data);

    const ticketId = Number(data.ticketId);

    const ticket = await this.prisma.ticket.findUnique({
      where: { id: ticketId },
    });

    console.log("CARI ID:", ticketId);
    console.log("TICKET KETEMU:", ticket);

    if (!ticket) {
      return { message: 'Ticket tidak ditemukan' };
    }

    return this.prisma.transaction.create({
      data: {
        name: ticket.name,
        price: ticket.price,
        ticketId: ticket.id, // 🔥 relasi pakai ini
      },
    });
  }

  // 🔥 DELETE
  delete(id: number) {
    return this.prisma.transaction.delete({
      where: { id: Number(id) },
    });
  }
}