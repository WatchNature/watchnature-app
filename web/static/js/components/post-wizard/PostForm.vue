<template>
  <div>
    <step-header
      title="Add Description"
      prevUrl="/posts/new"
    ></step-header>

    <form @submit.prevent="create">
      <div class="input-group">
        <label for="post_description">Description</label>
        <textarea id="post_description" name="post[description]" v-model="post.description" rows="8" cols="80"></textarea>
      </div>

      <div class="action-group">
        <input type="submit" name="submit" value="Save">
      </div>
    </form>
  </div>
</template>

<script>
import StepHeader from './StepHeader.vue'
import LocationForm from '../location/LocationForm.vue'

export default {
  name: 'PostForm',

  components: {
    StepHeader,
    LocationForm
  },

  data () {
    return {
      post: {
        description: '',
        location_name: '',
        location: {
          coordinates: [],
          type: 'Point'
        }
      }
    }
  },

  methods: {
    create () {
      this.$store.dispatch('posts/create', this.post)
        .then(response => {
          this.$router.push('/')
        })
        .catch(response => {
          alert(response.response.data.errors[0].detail)
        })
    },

    setLocation (place) {
      this.post.location_name = place.name
      this.post.location.coordinates[0] = place.geometry.location.lat()
      this.post.location.coordinates[1] = place.geometry.location.lng()
    }
  }
}
</script>

<style scope>
  .action-group {
    margin-top: 1rem;
  }

  .input-group + .input-group {
    margin-top: 1rem;
  }
</style>
