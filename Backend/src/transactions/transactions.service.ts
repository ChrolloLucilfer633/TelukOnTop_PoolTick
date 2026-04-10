import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Transaction } from './transactions.entity';
import { Ticket } from '../tickets/tickets.entity';

@Injectable()
export class TransactionsService {
  constructor(
    @InjectRepository(Transaction)
    private repo: Repository<Transaction>,

    @InjectRepository(Ticket)
    private ticketRepo: Repository<Ticket>,
  ) {}

  findAll() {
    return this.repo.find({
      relations: ['ticket'],
    });
  }

  async create(data: any) {
    console.log("DATA MASUK:", data);

    const ticketId = Number(data.ticketId);

    const ticket = await this.ticketRepo.findOne({
      where: { id: ticketId },
    });

    console.log("CARI ID:", ticketId);
    console.log("TICKET KETEMU:", ticket);

    if (!ticket) {
      return { message: 'Ticket tidak ditemukan' };
    }

    const transaksi = this.repo.create({
      name: ticket.name,
      price: ticket.price,
      ticket: ticket,
    });

    return this.repo.save(transaksi);
  }

  delete(id: number) {
    return this.repo.delete(id);
  }
}