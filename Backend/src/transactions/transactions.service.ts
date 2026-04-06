import { Injectable } from '@nestjs/common';

@Injectable()
export class TransactionsService {
  private transactions: any[] = [];

  create(data: any) {
    const newData = {
      id: this.transactions.length + 1,
      ...data,
    };

    this.transactions.push(newData);
    return newData;
  }

  findAll() {
    return this.transactions;
  }
}