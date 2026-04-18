import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class TicketsService {
  constructor(private prisma: PrismaService) {}

  // GET ALL
  async findAll() {
    return await this.prisma.ticket.findMany();
  }

  // GET BY ID
  async findOne(id: number) {
    return await this.prisma.ticket.findUnique({
      where: {
        id: Number(id),
      },
    });
  }

  // CREATE
  async create(data: any) {
    return await this.prisma.ticket.create({
      data: {
        name: data.name,
        price: Number(data.price),
      },
    });
  }

  // PATCH 
  async patch(id: number, data: any) {
    return await this.prisma.ticket.update({
      where: {
        id: Number(id),
      },
      data: {
        ...(data.name && { name: data.name }),
        ...(data.price && { price: Number(data.price) }),
      },
    });
  }

  // DELETE
  async delete(id: number) {
    return await this.prisma.ticket.delete({
      where: {
        id: Number(id),
      },
    });
  }
}