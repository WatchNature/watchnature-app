<template>
  <div
    @click="dismiss"
    :class="[notificationWrapperClasses]"
  >
    <span class="icon">
      <icon-close></icon-close>
    </span>

    <p class="message pl3 f6 ma0">
      {{ notification.message }}
    </p>
  </div>
</template>

<script>
import IconClose from '../../icons/IconClose.vue'

export default {
  name: 'Notification',

  components: {
    IconClose
  },

  props: {
    notification: {
      type: Object,
      required: true
    }
  },

  computed: {
    notificationWrapperClasses () {
      return `notification ${this.notification.type} ma2 pa3`
    }
  },

  methods: {
    dismiss () {
      this.$store.dispatch('notifications/dismiss', this.notification.id)
    }
  },

  mounted () {
    const dismissAfter = this.notification.dismissAfter

    if (!isNaN(dismissAfter)) {
      setTimeout(this.dismiss, dismissAfter)
    }
  }
}
</script>

<style lang="stylus" scoped>
.notification
  display flex
  align-items center
  cursor pointer

.info
  background-color #333333
  color #ffffff

.success
  background-color #7bb85c
  color #ffffff

.error
  background-color #db534f
  color #ffffff
</style>
