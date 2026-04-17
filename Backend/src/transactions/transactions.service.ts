import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class TransactionsService {
  constructor(private prisma: PrismaService) {}

  // ✅ GET ALL TRANSAKSI + JOIN TICKET
  findAll() {
    return this.prisma.transaction.findMany({
      include: {
        ticket: true,
      },
      orderBy: {
        createdAt: 'desc', // biar terbaru di atas
      },
    });
  }

<<<<<<< HEAD
  // ✅ GET TRANSAKSI HARI INI (buat export excel)
  findToday() {
    const now = new Date();

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
        createdAt: 'desc',
      },
    });
  }

  // ✅ CREATE TRANSAKSI
  async create(data: any) {
    const ticketId = Number(data.ticketId);

    const ticket = await this.prisma.ticket.findUnique({
      where: { id: ticketId },
    });

=======
  // CREATE TRANSAKSI
  async create(data: any) {
    console.log("DATA MASUK:", data);

    const ticketId = Number(data.ticketId);

    const ticket = await this.prisma.ticket.findUnique({
      where: { id: ticketId },
    });

>>>>>>> 22588f44973656a4be4be754bd90d73de79fd3d3
    if (!ticket) {
      return { message: 'Ticket tidak ditemukan' };
    }

    return this.prisma.transaction.create({
      data: {
<<<<<<< HEAD
        name: data.name, // 👉 nama pembeli
=======
        name: data.name,
>>>>>>> 22588f44973656a4be4be754bd90d73de79fd3d3
        price: ticket.price,
        ticketId: ticket.id,
      },
    });
  }

<<<<<<< HEAD
  // ✅ DELETE
=======
  // DELETE
>>>>>>> 22588f44973656a4be4be754bd90d73de79fd3d3
  delete(id: number) {
    return this.prisma.transaction.delete({
      where: { id: Number(id) },
    });
  }
}