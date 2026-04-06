import { Controller, Get, Post, Body } from '@nestjs/common';
import { TicketsService } from './tickets.service';

@Controller('tickets')
export class TicketsController {
  constructor(private readonly ticketsService: TicketsService) {}

  @Get()
  getAllTickets() {
    return this.ticketsService.findAll();
  }

  @Post()
  createTicket(@Body() body: any) {
    return this.ticketsService.create(body);
  }
}