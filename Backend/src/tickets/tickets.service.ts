import { Injectable } from '@nestjs/common';

@Injectable()
export class TicketsService {
  private tickets = [
    { id: 1, name: 'Tiket Dewasa', price: 20000 },
    { id: 2, name: 'Tiket Anak', price: 10000 },
  ];

  findAll() {
    return this.tickets;
  }

  create(data: any) {
    const newTicket = {
      id: this.tickets.length + 1,
      ...data,
    };

    this.tickets.push(newTicket);
    return newTicket;
  }
}