import { Routes } from '@angular/router';
import { TaskListComponent } from './task-list/task-list.component';
import { TaskFormComponent } from './task-form/task-form.component';
import { LoginComponent } from './login/login.component';
import { EnquiryComponent } from './enquiry/enquiry.component';
import { AuthGuard } from './auth.guard';
import { ServerRoute, RenderMode } from '@angular/ssr';
import { provideRouter } from '@angular/router';

// Define regular routes
export const routes: Routes = [
  { path: '', component: TaskListComponent, canActivate: [AuthGuard] },
  { path: 'add-task', component: TaskFormComponent, canActivate: [AuthGuard] },
  { path: 'login', component: LoginComponent },
  { path: 'enquiry', component: EnquiryComponent, canActivate: [AuthGuard] },
];

// Convert Routes to ServerRoutes by adding renderMode
export const serverRoutes: ServerRoute[] = [
  {
    path: '**',
    renderMode: RenderMode.Server,
  },
];
