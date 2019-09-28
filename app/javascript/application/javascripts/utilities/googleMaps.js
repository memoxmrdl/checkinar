const loadGoogleMapsApi = require('load-google-maps-api')

function createArea (google, map, initialRadius, initialCoords) {
  let drawed_area = defaultCircle(initialRadius, initialCoords);
  let radius = initialRadius;

  function defaultCircle (_radius, coords) {
    return new google.Circle({
      strokeColor: '#FF0000',
      strokeOpacity: 0.8,
      strokeWeight: 2,
      fillColor: '#FF0000',
      fillOpacity: 0.35,
      map: map,
      radius: _radius,
      center: {
        lat: coords.latitude,
        lng: coords.longitude
      }
    });
  }

  function getRadius () {
    return radius
  }

  function repaint (_radius, coords) {
    remove()
    drawed_area = defaultCircle(_radius, coords)
    radius = _radius
  }

  function remove() {
    if (drawed_area) {
      drawed_area.setMap(null)
      drawed_area = null
    }
  }

  return {
    getRadius,
    repaint,
    remove,
  }
}

function initialMap(google, elementTarget, coords) {
  return new google.Map(elementTarget, {
    zoom: 18,
    center: {
      lat: coords.latitude,
      lng: coords.longitude
    },
    mapTypeId: 'terrain',
    disableDefaultUI: true
  });
}

function createMarker(google, map, coords) {
  return new google.Marker({
    map: map,
    draggable: true,
    animation: google.Animation.DROP,
    position: {
      lat: coords.latitude,
      lng: coords.longitude
    }
  });
}

function createAutoComplete(google, map) {
  let card = document.getElementById('autocomplete-container')
  let input = document.getElementById('autocomplete_address')

  map.controls[google.ControlPosition.TOP_LEFT].push(card)

  let autocomplete = new google.places.Autocomplete(input)

  autocomplete.bindTo('bounds', map)
  autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])

  return autocomplete
}

export default function loadMapViewer (target, { coords, radius }, onChangePointer) {
  const options = {
    key: process.env.google_maps_api_key,
    libraries: ['places']
  }

  return loadGoogleMapsApi(options)
    .then(function (google) {
      const map = initialMap(google, target, coords)
      const marker = createMarker(google, map, coords)
      const autoComplete = createAutoComplete(google, map)
      const roundedArea = createArea(google, map, radius, coords)

      function moveAreaToMarkerPosition(radius) {
        const { lat, lng } = marker.getPosition()
        roundedArea.repaint(radius, {
          latitude: lat(),
          longitude: lng()
        })
        onChangePointer({
          latitude: lat(),
          longitude: lng(),
          radius: roundedArea.getRadius()
        })
      }

      function moveAreaToPlaceAutoComplete() {
        let place = autoComplete.getPlace()

        marker.setVisible(false)

        if (!place.geometry) {
          return false
        }

        if (place.geometry.viewport) {
          map.fitBounds(place.geometry.viewport)
        } else {
          map.setCenter(place.geometry.location)
          map.setZoom(17)
        }

        marker.setPosition(place.geometry.location)
        marker.setVisible(true)
      }

      marker.addListener('dragend', () => moveAreaToMarkerPosition(roundedArea.getRadius()))

      autoComplete.addListener('place_changed', () => moveAreaToPlaceAutoComplete())

      return {
        destroy: function () {
          marker.setPosition({
            lat: coords.latitude,
            lng: coords.longitude
          })
          roundedArea.remove()
        },
        setRadius: moveAreaToMarkerPosition
      }
    })
    .catch(function (error) {
      console.log(error)
    })
}
