<template>
  <div>
    <step-header
      title="Add Description"
      :prevUrl="prevUrl"
      :show-action-button="showActionButton"
      :actionCallback="save"
    ></step-header>

    <form @submit.prevent="save">
      <div class="input-group">
        <label for="post_description">Description</label>
        <textarea
          id="post_description"
          name="post[description]"
          v-model="post.description"
          rows="8"
          cols="80"
        ></textarea>
      </div>
    </form>
  </div>
</template>

<script>
import StepHeader from './StepHeader.vue'

export default {
  name: 'DescriptionForm',

  components: {
    StepHeader
  },

  data () {
    return {
      prevUrl: '/posts/new',
      post: {
        description: this.$store.getters['postWizard/description']
      }
    }
  },

  computed: {
    valid () {
      return this.post.description !== ''
    },

    showActionButton () {
      return this.valid
    }
  },

  methods: {
    save () {
      this.$store.dispatch('postWizard/addDescription', this.post.description)
        .then(() => {
          this.$router.push(this.prevUrl)
        })
    }
  }
}
</script>

<style lang="stylus" scope>
@import '../../../../assets/css/_vars'

.action-group
  margin-top $space-2

.input-group
  & + .input-group
    margin-top $space-2
</style>
