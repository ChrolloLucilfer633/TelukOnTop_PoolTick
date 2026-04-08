import { Controller, Get, Post, Body, Delete, Param } from '@nestjs/common';
import { TicketsService } from './tickets.service';

@Controller('tickets')
export class TicketsController {
  constructor(private readonly ticketsService: TicketsService) {}

  // 🔥 GET ALL
  @Get()
  getAllTickets() {
    return this.ticketsService.findAll();
  }

  // 🔥 CREATE
  @Post()
  createTicket(@Body() body: any) {
    return this.ticketsService.create(body);
  }

  // 🔥 DELETE
  @Delete(':id')
  deleteTicket(@Param('id') id: string) {
    return this.ticketsService.delete(parseInt(id));
  }
}