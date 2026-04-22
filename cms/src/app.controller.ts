import { Controller, Get } from '@nestjs/common';
import axios from 'axios';

@Controller()
export class AppController {
  @Get('tickets')
  async getTickets() {
    const res = await axios.get('http://localhost:3000/tickets');
    return res.data;
  }
}