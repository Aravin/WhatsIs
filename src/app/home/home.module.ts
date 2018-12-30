import { IonicModule } from '@ionic/angular';
import { RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HomePage } from './home.page';

import {MatButtonModule, MatCheckboxModule, MatAutocompleteModule , MatInputModule, MatFormFieldModule} from '@angular/material';


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
