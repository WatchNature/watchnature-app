<template>
  <div>
    <router-link
      class="link db"
      :to="{ name: 'postwizard-description' }"
      title="Add/Edit Description"
    >
      <div v-if="description">
        <p class="ma0">{{ description }}</p>
      </div>

      <span v-else>
        Add Description
      </span>
    </router-link>

    <router-link
      class="link mt3 db"
      :to="{ name: 'postwizard-location' }"
      title="Add/Edit Location"
    >
      <div v-if="locationName">
        <p class="ma0">{{ locationName }}</p>
      </div>

      <span v-else>
        Add Location
      </span>
    </router-link>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'WizardMenu',

  computed: {
    ...mapGetters({
      description: 'postWizard/description',
      locationName: 'postWizard/locationName'
    })
  }
}
</script>
