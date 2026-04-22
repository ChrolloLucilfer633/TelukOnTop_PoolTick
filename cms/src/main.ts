import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { join } from 'path';
import * as express from 'express';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // 1. Folder Views untuk HTML
  app.use(express.static(join(process.cwd(), 'src', 'views')));
  // 2. Folder Public untuk JS dan CSS
  app.use(express.static(join(process.cwd(), 'src', 'public')));

  await app.listen(3001);
  console.log('CMS PoolTick jalan di: http://localhost:3001');
}
bootstrap();