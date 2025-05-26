import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { WebcamModule, WebcamImage } from 'ngx-webcam';
import { Subject } from 'rxjs';
import { ApiService } from '../api.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-recognize',
  standalone: true,
  imports: [CommonModule, WebcamModule, FormsModule],
  templateUrl: './recognize.component.html',
  styleUrls: ['./recognize.component.scss']
})
export class RecognizeComponent implements OnInit, OnDestroy {
  message = '🔍 Awaiting recognition...';
  trigger = new Subject<void>();
  interval: any;

  constructor(private api: ApiService) {}

  get triggerObservable() {
    return this.trigger.asObservable();
  }

  ngOnInit(): void {
    this.interval = setInterval(() => {
      this.trigger.next();
    }, 200); // trigger every 200ms
  }

  ngOnDestroy(): void {
    clearInterval(this.interval);
  }

  handleImage(image: WebcamImage): void {
    this.api.recognize(image.imageAsBase64).subscribe({
      next: (res: any) => {
        const name = res.name;
        const confidence = (res.confidence * 100).toFixed(2);
        const distance = res.distance.toFixed(4);
        this.message = `👤 ${name} | Confidence: ${confidence}% | Distance: ${distance}`;
      },
      error: (err: any) => {
        this.message = `❌ ${err.error.detail || 'Recognition failed'}`;
      }
    });
  }
}
