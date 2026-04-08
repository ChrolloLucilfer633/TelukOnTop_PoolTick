import { Module, Controller, Post, Body, Get, Delete, Param, Injectable } from '@nestjs/common';

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

  // 🔥 TAMBAH INI
  delete(id: number) {
    this.transactions = this.transactions.filter(
      t => t.id !== Number(id)
    );
    return { message: 'Deleted' };
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

  // 🔥 DELETE ENDPOINT
  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.service.delete(Number(id));
  }
}

@Module({
  controllers: [TransactionsController],
  providers: [TransactionsService],
})
export class TransactionsModule {}