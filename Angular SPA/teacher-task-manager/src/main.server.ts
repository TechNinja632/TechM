import { enableProdMode } from '@angular/core';
import { environment } from './environments/environment';
import { ngExpressEngine } from '@nguniversal/express-engine';
import { provideServerRendering } from '@angular/platform-server';
import { AppServerModule } from './app/app.module.server';
import * as express from 'express';
import { join } from 'path';
import { Request, Response } from 'express'; // Import types

if (environment.production) {
  enableProdMode();
}

export const app = express();

app.engine(
  'html',
  ngExpressEngine({
    bootstrap: AppServerModule,
    providers: [provideServerRendering()],
  })
);

app.set('view engine', 'html');
app.set('views', join(__dirname, 'browser'));

app.get(
  '*.*',
  express.static(join(__dirname, 'browser'), {
    maxAge: '1y',
  })
);

app.get('*', (req: Request, res: Response) => {
  // Explicitly type req and res
  res.render('index', { req });
});
