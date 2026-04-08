import { Injectable } from '@nestjs/common';

@Injectable()
export class TransactionsService {
  private transactions: any[] = [];

  // 🔥 CREATE
  create(data: any) {
    const newData = {
      id: this.transactions.length + 1,
      ...data,
    };

    this.transactions.push(newData);
    return newData;
  }

  // 🔥 GET ALL
  findAll() {
    return this.transactions;
  }

  // 🔥 DELETE
  delete(id: number) {
    this.transactions = this.transactions.filter(t => t.id !== id);
    return { message: 'Deleted' };
  }
}