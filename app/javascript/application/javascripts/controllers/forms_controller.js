import { Controller } from 'stimulus';
import moment from 'moment';
import maskInput from 'vanilla-text-mask';
import createNumberMask from 'text-mask-addons/dist/createNumberMask';
import * as daterangepicker from 'daterangepicker'; // eslint-disable-line no-unused-vars

export default class extends Controller {
  connect() {
    this.initializeDateFields();
    this.initializeTimePicker($('.input-time'));
  }

  initializeDateFields() {
    const dateMask = [/\d/, /\d/, '/', /\d/, /\d/, '/', /\d/, /\d/, /\d/, /\d/];

    let dateInputs = document.querySelectorAll('.input-date');

    for (let input of dateInputs) {
      maskInput({
        inputElement: input,
        mask: dateMask
      });
    }

    this.initializeDatePicker($('.input-date'));
  }

  initializeDatePicker(element) {
    element.daterangepicker({
      singleDatePicker: true,
      showDropdowns: true,
      autoUpdateInput: false,
      minDate: moment(),
      minYear: 1901,
      maxYear: moment().add(5, 'years').year(),
      locale: {
        format: 'DD/MM/YYYY'
      }
    });

    element.on('apply.daterangepicker', function(ev, picker) {
      $(this).val(picker.startDate.format('DD/MM/YYYY'));
    });
  }

  initializeTimePicker(element) {
    element.daterangepicker({
      timePicker: true,
      singleDatePicker: true,
      timePicker24Hour: true,
      timePickerIncrement: 1,
      timePickerSecond: false,
      autoUpdateInput: false,
      locale : {
        format : 'HH:mm'
      }
    }).on('show.daterangepicker', function(ev, picker) {
      picker.container.find(".calendar-table").hide();
    }).on('apply.daterangepicker', function(ev, picker) {
      $(this).val(picker.startDate.format('HH:mm'));
    });
  }
}
