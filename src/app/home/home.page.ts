import { Component, OnInit } from '@angular/core';
import { Plugins } from '@capacitor/core';
import { FormControl } from '@angular/forms';
import { countryCodes, getCountryCode } from '../countryCode/countryCodesData';
import {Observable} from 'rxjs';
import {map, startWith} from 'rxjs/operators';
const { Toast } = Plugins;

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss']
})
export class HomePage {

  countryCode: string;
  code: number;
  phoneNumber: number;
  message: string;

  countryCodeControl = new FormControl();
  filteredOptions: Observable<CountryCode[]>;
  countryCodes: CountryCode[] = countryCodes;

  constructor() {
    this.filteredOptions = this.countryCodeControl.valueChanges.pipe(
      startWith(''),
      map(countries => countries ? this._filterStates(countries) : this.countryCodes.slice())
    );
  }

  private _filterStates(value: string): CountryCode[] {
    const filterValue = (value as string).toLowerCase();
    return this.countryCodes.filter(countries => countries.country.toLowerCase().includes(filterValue));
  }

  public _sendMessage() {

    if (this.countryCode === undefined) {
      this.toast('Please choose the country');
      return;
    }

    this.code = getCountryCode(this.countryCode);

    if (this.phoneNumber === undefined ||
        typeof this.phoneNumber === 'string') {
          this.toast('Invalid Phone Code');
          return;
        }

    if (this.message === undefined || this.message === '') {
      this.message = 'Hi!';
    }

    const messageText = 'https://wa.me/' + this.code + this.phoneNumber + '?text=' + this.message;
    window.open(messageText, '_system');
  }

  async toast(message: string) {
    await Toast.show({
      text: message
    });
  }
}

interface CountryCode {
  code: number;
  country: string;
}
