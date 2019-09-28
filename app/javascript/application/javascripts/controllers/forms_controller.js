import { Controller } from 'stimulus';
import moment from 'moment';
import maskInput from 'vanilla-text-mask';
import createNumberMask from 'text-mask-addons/dist/createNumberMask';
import * as daterangepicker from 'daterangepicker'; // eslint-disable-line no-unused-vars

export default class extends Controller {
  connect() {
    this.initializeDateFields();
    this.initializeTimePicker($('.input-time'));
    this.initializeDateRangePicker($('.input-date-range'))
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

  initializeDateRangePicker(element) {
    element.daterangepicker({
      opens: 'center',
      buttonClasses: 'button is-small',
      locale: {
        'format': 'DD/MM/YYYY',
        'separator': ' - ',
        'applyLabel': 'Aplicar',
        'cancelLabel': 'Cancelar',
        'customRangeLabel': 'Rango de fechas',
        'daysOfWeek': 'Días de la semana',
        'monthNames': 'Meses',
        'firstDay': 1
      },
      ranges: this.generateRanges()
    });
  }

  generateRanges () {
    let ranges = {};

    ranges['Hoy'] = [moment(), moment()];
    ranges['Ayer'] = [moment().subtract(1, 'days'), moment().subtract(1, 'days')];
    ranges['Últimos 7 dias'] = [moment().subtract(6, 'days'), moment()];
    ranges['Últimos 30 dias'] = [moment().subtract(29, 'days'), moment()];
    ranges['Este mes'] = [moment().startOf('month'), moment().endOf('month')];
    ranges['Último mes'] = [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')];
    ranges['Últimos 3 meses'] = [moment().subtract(3, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')];

    return ranges;
  }
}
