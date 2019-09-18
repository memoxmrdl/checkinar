import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['inputDate', 'inputCheckbox', 'inputCheckboxLabel', 'source']

  initialize() {
    this.change(this.sourceTarget);
  }

  change(event) {
    let target = event.target || event;
    let valueSelectedOption = target.options[target.selectedIndex].value;

    if(valueSelectedOption == 'date') {
      this.inputDateDisabled(false);
      this.inputCheckboxesDisabled(true);
    } else if(valueSelectedOption == 'more_than_once') {
      this.inputDateDisabled(true);
      this.inputCheckboxesDisabled(false);
    } else {
      this.inputDateDisabled(true);
      this.inputCheckboxesDisabled(true);
    }
  }

  inputDateDisabled(true_or_false) {
    this.inputDateTarget.disabled = true_or_false;
  }

  inputCheckboxesDisabled(true_or_false) {
    this.inputCheckboxTargets.forEach(function(checkbox){
      checkbox.disabled = true_or_false;
    });
    this.inputCheckboxLabelTargets.forEach(function(label) {
      label.disabled = true_or_false;
    });
  }
}
