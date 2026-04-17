import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class TransactionsService {
  constructor(private prisma: PrismaService) {}

  // ✅ GET ALL TRANSAKSI + JOIN TICKET (terbaru di atas)
  findAll() {
    return this.prisma.transaction.findMany({
      include: {
        ticket: true,
      },
      orderBy: {
        id: 'desc', // pake id biar aman kalau belum ada createdAt
      },
    });
  }

  // ✅ GET TRANSAKSI HARI INI (buat export excel)
  findToday() {
    const start = new Date();
    start.setHours(0, 0, 0, 0);

    const end = new Date();
    end.setHours(23, 59, 59, 999);

    return this.prisma.transaction.findMany({
      where: {
        createdAt: {
          gte: start,
          lte: end,
        },
      },
      include: {
        ticket: true,
      },
      orderBy: {
        id: 'desc',
      },
    });
  }

  // ✅ CREATE TRANSAKSI
  async create(data: any) {
    const ticketId = Number(data.ticketId);

    const ticket = await this.prisma.ticket.findUnique({
      where: { id: ticketId },
    });

    if (!ticket) {
      return { message: 'Ticket tidak ditemukan' };
    }

    return this.prisma.transaction.create({
      data: {
        name: data.name, // 👉 nama pembeli
        price: ticket.price,
        ticketId: ticket.id,
      },
    });
  }

  // ✅ DELETE
  delete(id: number) {
    return this.prisma.transaction.delete({
      where: { id: Number(id) },
    });
  }
}