<template>
  <div>
    <notification-drawer></notification-drawer>

    <step-header
      title="New Post"
      prevUrl="/"
      :show-action-button="true"
      :actionCallback="save"
    ></step-header>

    <div class="container">
      <wizard-menu v-if="isMenuView"></wizard-menu>

      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
import _ from 'lodash'
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
    postData () {
      return this.$store.getters['postWizard/post']
    },

    isMenuView () {
      return this.$route.name === 'postwizard'
    }
  },

  methods: {
    ...mapActions({
      create: 'posts/create',
      reset: 'postWizard/reset'
    }),

    save () {
      return this.create(this.postData)
        .then((response) => {
          this.reset()
          .then(() => { this.$router.push('/') })
        })
        .catch(({ response }) => {
          const errors = response.data.errors

          _.forIn(errors, (val, key) => {
            this.$store.dispatch('notifications/add', {
              type: 'error',
              message: `${_.capitalize(key)} ${val}`
            })
          })
        })
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
