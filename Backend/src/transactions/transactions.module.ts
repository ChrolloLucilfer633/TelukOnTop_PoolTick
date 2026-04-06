import { Module } from '@nestjs/common';
import { Controller, Post, Body, Get } from '@nestjs/common';
import { Injectable } from '@nestjs/common';

@Injectable()
class TransactionsService {
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

@Controller('transactions')
class TransactionsController {
  constructor(private readonly service: TransactionsService) {}

  @Post()
  create(@Body() body: any) {
    return this.service.create(body);
  }

  @Get()
  findAll() {
    return this.service.findAll();
  }
}

@Module({
  controllers: [TransactionsController],
  providers: [TransactionsService],
})
export class TransactionsModule {}