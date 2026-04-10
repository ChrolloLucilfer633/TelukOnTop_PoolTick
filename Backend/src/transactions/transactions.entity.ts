import { Entity, Column, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { Ticket } from '../tickets/tickets.entity';

@Entity()
export class Transaction {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  price: number;

  // 🔥 RELASI (optional biar ga error 500)
  @ManyToOne(() => Ticket, { nullable: true })
  ticket: Ticket;
}