<template>
  <div>
    <notification-drawer></notification-drawer>
    <global-header></global-header>

    <div class="Default__container">
      <router-view></router-view>
    </div>

    <tab-bar></tab-bar>
  </div>
</template>

<script>
import GlobalHeader from '../components/global/GlobalHeader.vue'
import NotificationDrawer from '../components/global/notification/NotificationDrawer.vue'
import TabBar from '../components/global/TabBar.vue'

export default {
  name: 'DefaultLayout',

  components: {
    GlobalHeader,
    NotificationDrawer,
    TabBar
  }
}
</script>

<style lang="stylus" scoped>
.Default__container
  padding-top 68px
  padding-bottom 50px
</style>
