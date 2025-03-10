import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class EnquiryService {
  private apiUrl = 'http://localhost:4500/enquiries';
  private tasksUrl = 'http://localhost:4500/tasks';

  constructor(private http: HttpClient) {}

  getEnquiries(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  addEnquiry(enquiry: any): Observable<any> {
    return this.http.post<any>(this.apiUrl, enquiry);
  }

  deleteEnquiry(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/${id}`);
  }

  replyEnquiry(id: number, reply: string): Observable<any> {
    return this.http.patch<any>(`${this.apiUrl}/${id}`, { reply });
  }

  getTasks(): Observable<any[]> {
    return this.http.get<any[]>(this.tasksUrl);
  }
}
