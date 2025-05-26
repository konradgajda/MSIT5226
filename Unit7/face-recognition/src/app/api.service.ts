import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from './environment';


@Injectable({ providedIn: 'root' })
export class ApiService {
  constructor(private http: HttpClient) {}

  register(name: string, image: string) {
    return this.http.post(`${environment.apiUrl}/register`, { name, image });
  }

  recognize(image: string) {
    return this.http.post(`${environment.apiUrl}/recognize`, { image });
  }

  getFaces() {
    return this.http.get(`${environment.apiUrl}/faces`);
  }
}
