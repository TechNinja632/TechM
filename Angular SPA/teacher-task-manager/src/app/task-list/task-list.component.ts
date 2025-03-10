import { Component, OnInit } from '@angular/core';
import { TaskService } from '../task.service';
import { AuthService } from '../auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-task-list',
  templateUrl: './task-list.component.html',
  styleUrls: ['./task-list.component.css'],
  standalone: false,
})
export class TaskListComponent implements OnInit {
  tasks: any[] = [];
  filterStatus: string = '';
  isTeacher: boolean;

  constructor(
    private taskService: TaskService,
    private authService: AuthService,
    private router: Router
  ) {
    this.isTeacher = this.authService.isTeacher();
  }

  ngOnInit(): void {
    if (!this.authService.isAuthenticated()) {
      this.router.navigate(['/login']);
      return;
    }

    this.taskService.getTasks().subscribe((data) => {
      if (this.authService.isStudent()) {
        const currentUser = this.authService.getCurrentUser();
        this.tasks = data.filter(
          (task) =>
            task.student.toLowerCase() === currentUser.username.toLowerCase()
        );
      } else {
        this.tasks = data;
      }
    });
  }

  clearFilter(): void {
    this.filterStatus = '';
  }

  onTaskDeleted(taskId: number): void {
    this.tasks = this.tasks.filter((task) => task.id !== taskId);
  }

  navigateToAddTask(): void {
    this.router.navigate(['/add-task']);
  }
}
