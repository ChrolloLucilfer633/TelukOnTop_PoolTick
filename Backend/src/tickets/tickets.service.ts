import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class TicketsService {
  constructor(private prisma: PrismaService) {}

  // 🔥 GET ALL
  async findAll() {
    return await this.prisma.ticket.findMany();
  }

  // 🔥 CREATE
  async create(data: any) {
    return await this.prisma.ticket.create({
      data: {
        name: data.name,
        price: Number(data.price),
      },
    });
  }

  // 🔥 DELETE
  async delete(id: number) {
    return await this.prisma.ticket.delete({
      where: {
        id: Number(id),
      },
    });
  }
}