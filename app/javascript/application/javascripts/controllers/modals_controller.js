import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [ 'modal', 'form', 'inputField', 'errorField' ];

  openModal(event) {
    event.preventDefault();
    this.clearValueFields();
    const modalToOpen = event.currentTarget.getAttribute('modalTrigger');
    const modal = document.getElementById(modalToOpen);
    modal.classList.add('is-active');
  }

  closeModal(event) {
    event.preventDefault();
    const modalToClose = event.currentTarget.getAttribute('id');
    const modal = document.getElementById(modalToClose);
    modal.classList.remove('is-active');
  }

  onSuccess(event) {
    let [data, status, xhr] = event.detail;

    if(data.hasOwnProperty('redirect_to')) {
      Turbolinks.visit(data['redirect_to']);
    } else {
      location.reload();
    }
  }

  onError(event) {
    let [data, status, xhr] = event.detail;
    switch(xhr.status) {
      case 403:
        alert(data.alert);
        break;
      case 422:
        let inputFieldTargets = this.inputFieldTargets;

        this.clearFields();

        if(this.hasErrorFieldTarget) {
          let errors = JSON.parse(xhr.response);
          let keys = [];

          for (var error in errors) {
            keys.push(error);
          }

          this.errorFieldTargets.forEach(function(errorField){
            if(keys.includes(errorField.id)) {
              inputFieldTargets.forEach(function(inputField){
                if(inputField.id == errorField.id)
                  inputField.classList.add('is-danger');
              });

              errorField.classList.add('is-danger');
              errorField.classList.remove('is-invisible');
              errorField.innerHTML = errors[errorField.id][0];
            }
          })
        }
        break;
    }
  }

  clearFields(){
    this.inputFieldTargets.forEach(function(inputField){
      inputField.classList.remove('is-danger');
    });

    this.errorFieldTargets.forEach(function(errorField){
      errorField.classList.add('is-invisible');
      errorField.innerHTML = "";
    });
  }

  clearValueFields() {
    this.inputFieldTargets.forEach(function(inputField){
      if(!inputField.classList.value.match(/value-no-clear/)) {
        inputField.value = '';
      }
    });
  }
}
