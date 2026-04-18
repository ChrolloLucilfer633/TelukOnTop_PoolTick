import { Controller, Get, Post, Body, Delete, Param, Patch } from '@nestjs/common';
import { TicketsService } from './tickets.service';

@Controller('tickets')
export class TicketsController {
  constructor(private readonly ticketsService: TicketsService) {}

  // GET ALL
  @Get()
  getAllTickets() {
    return this.ticketsService.findAll();
  }

  // GET BY ID
  @Get(':id')
  getTicketById(@Param('id') id: string) {
    return this.ticketsService.findOne(Number(id));
  }

  // CREATE
  @Post()
  createTicket(@Body() body: any) {
    return this.ticketsService.create(body);
  }

  // PATCH 
  @Patch(':id')
  patchTicket(@Param('id') id: string, @Body() body: any) {
    return this.ticketsService.patch(Number(id), body);
  }

  // DELETE
  @Delete(':id')
  deleteTicket(@Param('id') id: string) {
    return this.ticketsService.delete(Number(id));
  }
}