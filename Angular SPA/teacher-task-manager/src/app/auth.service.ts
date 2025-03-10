import { Injectable } from '@angular/core';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private currentUser: any = null;

  constructor(private router: Router) {}

  login(username: string, password: string): boolean {
    if (username === 'staff' && password === 'password') {
      this.currentUser = { username, role: 'teacher' };
      this.router.navigate(['/']);
      return true;
    } else if (
      (username === 'praveen' || username === 'suban') &&
      password === 'password'
    ) {
      this.currentUser = { username, role: 'student' };
      this.router.navigate(['/']);
      return true;
    }
    return false;
  }

  logout(): void {
    this.currentUser = null;
    this.router.navigate(['/login']);
  }

  getCurrentUser(): any {
    return this.currentUser;
  }

  isTeacher(): boolean {
    return this.currentUser?.role === 'teacher';
  }

  isStudent(): boolean {
    return this.currentUser?.role === 'student';
  }

  isAuthenticated(): boolean {
    return this.currentUser !== null;
  }
}
