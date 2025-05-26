import { Routes } from '@angular/router';
import { NavComponent } from './nav/nav.component';

export const routes: Routes = [
      {
        path: '',
        component: NavComponent,
        children: [
          { path: '', redirectTo: 'register', pathMatch: 'full' },
          {
            path: 'register',
            loadComponent: () =>
              import('./register-wizard/register-wizard.component').then(m => m.RegisterWizardComponent)
          },
          {
            path: 'recognize',
            loadComponent: () =>
              import('./recognize/recognize.component').then(m => m.RecognizeComponent)
          }
        ]
      }
    ];
