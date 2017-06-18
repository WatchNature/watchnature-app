<template>
  <div>
    <notification-drawer></notification-drawer>

    <step-header
      title="New Post"
      prevUrl="/"
    ></step-header>

    <div class="container">
      <wizard-menu v-if="isMenuView"></wizard-menu>

      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import NotificationDrawer from '../components/global/notification/NotificationDrawer.vue'
import StepHeader from '../components/post-wizard/StepHeader.vue'
import WizardMenu from '../components/post-wizard/WizardMenu.vue'

export default {
  name: 'PostWizardLayout',

  components: {
    NotificationDrawer,
    StepHeader,
    WizardMenu
  },

  computed: {
    isMenuView () {
      return this.$route.name === 'postwizard'
    }
  }
}
</script>

<style scoped>
.container {
  padding-top: 68px;
  padding-bottom: 50px;
}
</style>
