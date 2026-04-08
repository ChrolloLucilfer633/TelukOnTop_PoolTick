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
  console.log("DELETE ID:", id);

  this.transactions = this.transactions.filter(
    t => t.id !== Number(id)
  );

  console.log("DATA SEKARANG:", this.transactions);

  return { message: 'Deleted' };
}
}