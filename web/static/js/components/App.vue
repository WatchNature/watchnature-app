<template>
  <div>
    <notification-drawer></notification-drawer>
    <global-header></global-header>

    <router-view></router-view>

    <tab-bar></tab-bar>
  </div>
</template>

<script>
import GlobalHeader from './global/GlobalHeader.vue'
import NotificationDrawer from './global/notification/NotificationDrawer.vue'
import TabBar from './global/TabBar.vue'

export default {
  name: 'App',

  components: {
    GlobalHeader,
    NotificationDrawer,
    TabBar
  }
}
</script>

<style media="screen">
  body {
    margin: 0;
  }
</style>
