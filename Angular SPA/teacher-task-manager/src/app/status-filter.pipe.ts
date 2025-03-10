import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'statusFilter',
  standalone: false,
})
export class StatusFilterPipe implements PipeTransform {
  transform(tasks: any[], filterStatus: string): any[] {
    if (!filterStatus) return tasks;
    return tasks.filter((task) =>
      task.status.toLowerCase().includes(filterStatus.toLowerCase())
    );
  }
}
