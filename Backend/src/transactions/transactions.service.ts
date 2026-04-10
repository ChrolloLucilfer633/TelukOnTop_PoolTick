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
      relations: ['ticket'], // 🔥 join otomatis
    });
  }

  async create(data: any) {
    const ticket = await this.ticketRepo.findOne({
      where: { id: data.ticketId },
    });

    // 🔥 biar ga error 500
    if (!ticket) {
      throw new Error('Ticket tidak ditemukan');
    }

    const transaksi = this.repo.create({
      name: data.name,
      price: data.price,
      ticket: ticket,
    });

    return this.repo.save(transaksi);
  }

  delete(id: number) {
    return this.repo.delete(id);
  }
}