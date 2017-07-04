// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
// import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import 'tachyons/css/tachyons.css'

import Vue from 'vue'
import { sync } from 'vuex-router-sync'
import * as VueGoogleMaps from 'vue2-google-maps'
import router from './lib/router'
import store from './store/index'
import axios from 'axios'
import _ from 'lodash'
import App from './components/App.vue'

sync(store, router)

Vue.use(VueGoogleMaps, {
  load: {
    key: GOOGLE_MAPS_API_KEY,
    libraries: 'places'
  }
})

// Vue.config.devtools = ENV !== 'production'
// Vue.config.silent = ENV === 'production'
Vue.prototype.$http = axios

axios.defaults.baseURL = API_BASE_URL
axios.defaults.headers['Content-Type'] = 'application/json'
axios.defaults.headers['Accept'] = 'application/json'

if (!_.isEmpty(store.state.authToken)) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${store.state.authToken}`
}

new Vue({
  router: router,
  store: store,
  render: h => h(App)
}).$mount('#app')

