<template>
  <div>
    <div class="input-group">
      <label for="g_autocomplete">Location Form <spinner v-if="fetchingLocation"></spinner></label>
      <input ref="autocomplete" id="g_autocomplete" type="text" placeholder="Search by name">
    </div>

    <div class="input-group">
      <div ref="map" class="map-container"></div>
    </div>
  </div>
</template>

<script>
import Spinner from '../global/Spinner.vue'

export default {
  name: 'LocationForm',

  components: {
    Spinner
  },

  data () {
    return {
      fetchingLocation: false,
      currentLocation: {
        latitude: '',
        longitude: ''
      },
      map: {},
      autocomplete: {}
    }
  },

  methods: {
    getCurrentLocation () {
      this.fetchingLocation = true

      const options = {
        enableHighAccuracy: true,
        timeout: 50000,
        maximumAge: 0
      }

      navigator.geolocation.getCurrentPosition(
        this.locationCallbackSuccess,
        this.locationCallbackError,
        options
      )
    },

    locationCallbackSuccess (position) {
      this.currentLocation.latitude = position.coords.latitude
      this.currentLocation.longitude = position.coords.longitude
      this.map.setCenter({ lat: this.currentLocation.latitude, lng: this.currentLocation.longitude })
      this.map.setZoom(14)
      this.fetchingLocation = false

      new google.maps.Marker({
        position: {
          lat: this.currentLocation.latitude,
          lng: this.currentLocation.longitude
        },
        map: this.map,
        animation: google.maps.Animation.DROP
      })
    },

    locationCallbackError (error) {
      console.error(error)
      alert(error)
      this.fetchingLocation = false
    },

    centerMapOnPlace (selectedPlace) {
      this.map.setCenter({
        lat: selectedPlace.geometry.location.lat(),
        lng: selectedPlace.geometry.location.lng()
      })
    },

    addMarkerToMap (selectedPlace) {
      // https://developers.google.com/maps/documentation/javascript/examples/marker-simple
      new google.maps.Marker({
        position: {
          lat: selectedPlace.geometry.location.lat(),
          lng: selectedPlace.geometry.location.lng()
        },
        map: this.map,
        title: selectedPlace.name,
        animation: google.maps.Animation.DROP
      })
    }
  },

  created () {
    this.getCurrentLocation()
  },

  mounted () {
    const lawrence = new google.maps.LatLng(38.9716700, -95.2352500)

    // https://developers.google.com/maps/documentation/javascript/3.exp/reference
    this.map = new google.maps.Map(this.$refs.map, {
      zoom: 4,
      center: lawrence
    })

    // https://developers.google.com/maps/documentation/javascript/3.exp/reference#Autocomplete
    this.autocomplete = new google.maps.places.Autocomplete(this.$refs.autocomplete)

    this.map.addListener('bounds_changed', () => {
      this.autocomplete.setBounds(this.map.getBounds())
    })

    this.autocomplete.addListener('place_changed', () => {
      const selectedPlace = this.autocomplete.getPlace()
      this.centerMapOnPlace(selectedPlace)
      this.addMarkerToMap(selectedPlace)

      this.$parent.setLocation(selectedPlace)
    })
  }
}
</script>

<style>
  .map-container {
    height: 400px;
    width: 100%;
  }

  /* https://google-developers.appspot.com/maps/documentation/javascript/places-autocomplete#style_autocomplete */
  .pac-container {
    border-radius: 0;
    font-family: inherit;
    box-shadow: none;
    border: 1px solid #bfbfbf;
  }

  .pac-container::after {
    background-position: left 0.5rem center;
    padding: 0.5rem;
  }

  .pac-item {
    padding: 0.5rem;
  }
</style>
