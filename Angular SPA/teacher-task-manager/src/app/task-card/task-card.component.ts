import { Component, Input, Output, EventEmitter } from '@angular/core';
import { TaskService } from '../task.service';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-task-card',
  templateUrl: './task-card.component.html',
  styleUrls: ['./task-card.component.css'],
  standalone: false,
})
export class TaskCardComponent {
  @Input() task: any;
  @Output() taskDeleted = new EventEmitter<number>();
  isTeacher: boolean;

  constructor(
    private taskService: TaskService,
    private authService: AuthService
  ) {
    this.isTeacher = this.authService.isTeacher();
  }

  onStatusChange() {
    this.taskService
      .updateTaskStatus(this.task.id, this.task)
      .subscribe((updatedTask) => {
        this.task = updatedTask;
      });
  }

  onDelete() {
    this.taskService.deleteTask(this.task.id).subscribe(() => {
      this.taskDeleted.emit(this.task.id);
    });
  }

  onSaveRemarks() {
    this.taskService
      .updateTaskRemarks(this.task.id, this.task.remarks)
      .subscribe((updatedTask) => {
        this.task = updatedTask;
      });
  }
}
