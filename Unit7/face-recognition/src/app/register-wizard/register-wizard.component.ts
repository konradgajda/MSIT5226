import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { WebcamModule, WebcamImage } from 'ngx-webcam';
import { Subject } from 'rxjs';
import { ApiService } from '../api.service';

@Component({
  selector: 'app-register-wizard',
  standalone: true,
  imports: [CommonModule, FormsModule, WebcamModule],
  templateUrl: './register-wizard.component.html',
  styleUrls: ['./register-wizard.component.scss']
})
export class RegisterWizardComponent {
  name = '';
  currentStep = 0;
  imagesPerStep = 5;
  collected = 0;
  directions = ['Center', 'Up', 'Down', 'Left', 'Right'];
  message = '';
  trigger = new Subject<void>();

  constructor(private api: ApiService) {}

  get triggerObservable() {
    return this.trigger.asObservable();
  }

startWizard(): void {
  if (!this.name.trim()) {
    this.message = '⚠️ Name is required.';
    return;
  }

  this.api.getFaces().subscribe(
    (res: any) => {
      if (res.registered && res.registered.includes(this.name)) {
        this.message = `❌ The name "${this.name}" is already registered. Please use a different name.`;
      } else {
        this.currentStep = 0;
        this.collected = 0;
        this.message = `🟡 Look ${this.directions[this.currentStep]}`;
        this.captureNext();
      }
    },
    err => {
      this.message = '❌ Could not validate name. Try again.';
    }
  );
}

  captureNext(): void {
    if (this.collected < this.imagesPerStep) {
      this.trigger.next();
    } else if (this.currentStep < this.directions.length - 1) {
      this.currentStep++;
      this.collected = 0;
      this.message = `🟡 Look ${this.directions[this.currentStep]}`;
      setTimeout(() => this.captureNext(), 800);
    } else {
      this.message = '✅ All directions completed!';
    }
  }

  handleImage(image: WebcamImage): void {
    if (!this.name.trim()) {
      this.message = '⚠️ Name is required.';
      return;
    }

    this.api.register(this.name, image.imageAsBase64).subscribe({
      next: () => {
        this.collected++;
        this.message = `✅ ${this.directions[this.currentStep]} ${this.collected}/${this.imagesPerStep}`;
        setTimeout(() => this.captureNext(), 500);
      },
      error: err => {
        this.message = `❌ ${err.error.detail || 'Failed to register'}`;
      }
    });
  }
}
