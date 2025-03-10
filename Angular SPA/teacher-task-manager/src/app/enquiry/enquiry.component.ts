import { Component, OnInit } from '@angular/core';
import { AuthService } from '../auth.service';
import { EnquiryService } from '../enquiry.service';
import { TaskService } from '../task.service';

@Component({
  selector: 'app-enquiry',
  templateUrl: './enquiry.component.html',
  styleUrls: ['./enquiry.component.css'],
  standalone: false,
})
export class EnquiryComponent implements OnInit {
  enquiries: any[] = [];
  newEnquiry: string = '';
  selectedTask: string = '';
  tasks: any[] = [];
  isTeacher: boolean;

  constructor(
    private authService: AuthService,
    private enquiryService: EnquiryService,
    private taskService: TaskService
  ) {
    this.isTeacher = this.authService.isTeacher();
  }

  ngOnInit(): void {
    this.enquiryService.getEnquiries().subscribe((data: any) => {
      if (this.authService.isStudent()) {
        const currentUser = this.authService.getCurrentUser();
        this.enquiries = data.filter(
          (enquiry: any) => enquiry.student === currentUser.username
        );
      } else {
        this.enquiries = data;
      }
    });

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

  sendEnquiry(): void {
    const currentUser = this.authService.getCurrentUser();
    const enquiry = {
      student: currentUser.username,
      task: this.selectedTask,
      message: this.newEnquiry,
    };
    this.enquiryService.addEnquiry(enquiry).subscribe((newEnquiry) => {
      this.enquiries.push(newEnquiry);
      this.newEnquiry = '';
      this.selectedTask = '';
    });
  }

  deleteEnquiry(id: number, event: Event): void {
    event.stopPropagation(); // Prevent event bubbling
    this.enquiryService.deleteEnquiry(id).subscribe(() => {
      this.enquiries = this.enquiries.filter((enquiry) => enquiry.id !== id);
    });
  }

  replyEnquiry(id: number, reply: string): void {
    this.enquiryService.replyEnquiry(id, reply).subscribe((updatedEnquiry) => {
      const index = this.enquiries.findIndex((enquiry) => enquiry.id === id);
      if (index !== -1) {
        this.enquiries[index] = updatedEnquiry;
      }
    });
  }
}
