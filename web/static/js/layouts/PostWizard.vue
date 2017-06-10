<template>
  <div>
    <notification-drawer></notification-drawer>
    <router-view></router-view>
  </div>
</template>

<script>
import NotificationDrawer from '../components/global/notification/NotificationDrawer.vue'

export default {
  name: 'PostWizardLayout',

  components: {
    NotificationDrawer
  }
}
</script>
