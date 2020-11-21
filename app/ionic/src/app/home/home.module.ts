import { IonicModule } from '@ionic/angular';
import { RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HomePage } from './home.page';

import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';


@NgModule({
  imports: [
    IonicModule,
    CommonModule,
    FormsModule, ReactiveFormsModule,
    MatButtonModule, MatCheckboxModule, MatAutocompleteModule, MatInputModule, MatFormFieldModule,
    RouterModule.forChild([{ path: '', component: HomePage }],
    )],
    exports: [
      ReactiveFormsModule,
      MatButtonModule, MatCheckboxModule, MatAutocompleteModule, MatInputModule, MatFormFieldModule
    ],
  declarations: [HomePage]
})
export class HomePageModule {}
