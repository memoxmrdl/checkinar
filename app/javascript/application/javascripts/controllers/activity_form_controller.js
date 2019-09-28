import { Controller } from 'stimulus';
import loadMapViewer from '../utilities/googleMaps';
export default class extends Controller {
  static targets = ['inputTime', 'inputDate', 'inputCheckbox', 'inputCheckboxLabel', 'source', 'mapViewer', 'slider', 'latitude', 'longitude', 'mapSection', 'selectActivityPlace']

  initialize() {
    this.change(this.sourceTarget);
    this.mountMap.bind(this)();

    const hasPlace = this.hasBeenMarkedAPlace()
    this.selectActivityPlaceTarget.checked = hasPlace
    hasPlace && this.mapSectionTarget.classList.remove('is-hidden')
  }

  mountMap() {
    const updateLatitudeLongitude = this.updateLatitudeLongitude.bind(this)
    const {
      mapViewerTarget,
      sliderTarget,
      selectActivityPlaceTarget,
      latitudeTarget,
      longitudeTarget
    } = this

    navigator.geolocation.getCurrentPosition(function (position) {
      const radius = Number(sliderTarget.value)
      const coords = {
        latitude: Number(latitudeTarget.value) || position.coords.latitude,
        longitude: Number(longitudeTarget.value) || position.coords.longitude
      }

      loadMapViewer(mapViewerTarget, { coords, radius }, function ({ radius, latitude, longitude }) {
        updateLatitudeLongitude(latitude, longitude)
      }).then(function ({ setRadius, destroy }) {
          selectActivityPlaceTarget.addEventListener('click', (ev) => !ev.target.checked && destroy())
          sliderTarget.addEventListener('input', (ev) => setRadius(Number(ev.target.value)))
        })
    })
  }

  hasBeenMarkedAPlace() {
    return this.latitudeTarget.value &&
      this.longitudeTarget.value &&
      this.sliderTarget.value
  }

  updateLatitudeLongitude(lat, lng) {
    this.latitudeTarget.value = lat
    this.longitudeTarget.value = lng
  }

  toggleMapSection(ev) {
    if (ev.target.checked) {
      this.mapSectionTarget.classList.remove('is-hidden')
      this.sliderTarget.value = this.sliderTarget.value || ''
    } else {
      this.latitudeTarget.value = 0
      this.longitudeTarget.value = 0
      this.sliderTarget.value = 0
      this.mapSectionTarget.classList.add('is-hidden')
    }
  }

  change(event) {
    let target = event.target || event;
    let valueSelectedOption = target.options[target.selectedIndex].value;

    if(valueSelectedOption == 'date') {
      this.inputTimeDisabled(false);
      this.inputDateDisabled(false);
      this.inputCheckboxesDisabled(true);
    } else if(valueSelectedOption == 'more_than_once') {
      this.inputTimeDisabled(false);
      this.inputDateDisabled(true);
      this.inputCheckboxesDisabled(false);
    } else if(valueSelectedOption == 'free'){
      this.inputTimeDisabled(true);
      this.inputDateDisabled(true);
      this.inputCheckboxesDisabled(true);
    } else {
      this.inputDateDisabled(true);
      this.inputCheckboxesDisabled(true);
    }
  }

  inputTimeDisabled(true_or_false) {
    this.inputTimeTargets.forEach((input)=> {
      input.disabled = true_or_false
    })
  }

  inputDateDisabled(true_or_false) {
    this.inputDateTargets.forEach((input)=> {
      input.disabled = true_or_false
    })
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
