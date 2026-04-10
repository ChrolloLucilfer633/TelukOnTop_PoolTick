import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity('ticket') // 🔥 paksa pakai ini
export class Ticket {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  price: number;
}