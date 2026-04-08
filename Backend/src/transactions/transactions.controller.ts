import { Controller, Post, Body, Get, Delete, Param } from '@nestjs/common';
import { TransactionsService } from './transactions.service';

@Controller('transactions')
export class TransactionsController {
  constructor(private readonly service: TransactionsService) {}

  // 🔥 CREATE TRANSACTION
  @Post()
  create(@Body() body: any) {
    return this.service.create(body);
  }

  // 🔥 GET ALL
  @Get()
  findAll() {
    return this.service.findAll();
  }

  // 🔥 DELETE TRANSACTION
  @Delete(':id')
  delete(@Param('id') id: string) {
    return this.service.delete(parseInt(id));
  }
}