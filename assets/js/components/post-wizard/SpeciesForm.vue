<template>
  <div>
    <step-header
      title="Add Species"
      :prevUrl="prevUrl"
      :show-action-button="showActionButton"
      :actionCallback="save"
    ></step-header>

    <div
      v-if="selectedSpecies"
      class="selected-species"
    >
      <span class="results__common-name">{{ selectedSpecies.common_name }}</span>
      <span class="results__scientific-name">{{ selectedSpecies.scientific_name }}</span>
    </div>

    <form @submit.prevent="search">
      <input
        type="text"
        placeholder="Search Species"
        @keydown="search(true)"
        v-model="keywords"
      >
    </form>

    <ul
      v-if="results.length"
      class="results"
    >
      <li
        v-for="result in results"
        :key="result.id"
        @click="selectSpecies(result)"
        class="results__list-item"
      >
        <span class="results__common-name">{{ result.common_name }}</span>
        <span class="results__scientific-name">{{ result.scientific_name }}</span>
      </li>
    </ul>

    <button
      v-if="nextPage && nextPage > 1"
      @click.prevent="search(false)"
      class="view-more"
    >
      View More
    </button>
  </div>
</template>

<script>
import _ from 'lodash'
import { mapActions, mapGetters } from 'vuex'
import StepHeader from './StepHeader.vue'
import Spinner from '../global/Spinner.vue'
import axios from 'axios'

export default {
  name: 'SpeciesForm',

  components: {
    StepHeader,
    Spinner
  },

  data () {
    return {
      prevUrl: '/posts/new',
      loading: true,
      keywords: '',
      results: [],
      meta: {},
      selectedSpecies: null
    }
  },

  computed: {
    valid () {
      if (this.selectedSpecies == null) {
        return false
      } else {
        return true
      }
    },

    showActionButton () {
      return this.valid
    },

    nextPage () {
      if (this.meta.page_number) {
        if (this.meta.page_number < this.meta.total_pages) {
          return this.meta.page_number + 1
        } else {
          return false
        }
      } else {
        return 1
      }
    }
  },

  methods: {
    ...mapActions({
      addNotification: 'notifications/add',
      addSpecies: 'postWizard/addSpecies'
    }),

    search: _.debounce(function (reset = false) {
      console.log(reset)
      this.loading = true

      if (reset) {
        this.meta = {}
      }

      let params = {
        term: this.keywords,
        page_number: this.nextPage,
        page_size: 15
      }

      axios.get('species', { params: params })
        .then((response) => {
          let results = response.data.data

          if (reset) {
            this.results = results
          } else {
            results.forEach((result) => {
              this.results.push(result)
            })
          }

          this.meta = response.data.meta
        })
        .then((response) => {
          this.loading = false
        })
    }, 200),

    selectSpecies (species) {
      this.selectedSpecies = species
      this.keywords = ''
      this.results = []
      this.meta = {}
    },

    save () {
      this.addSpecies(this.selectedSpecies)
        .then(() => {
          this.$router.push(this.prevUrl)
        })
    }
  }
}
</script>

<style lang="stylus" scoped>
@import '../../../../assets/css/_vars'

.spinner-container
  text-align center
  padding $space-2
  position relative

  .spinner
    position absolute

.selected-species
  padding $space-2
  padding-top 0

.results
  margin 0
  padding 0

.results__list-item
  background-color white
  list-style none
  padding $space-1
  border-bottom 1px solid $gray-2

.results__common-name,
.results__scientific-name
  display block

.results__common-name
  font-weight bold

.results__scientific-name
  font-style italic

.view-more
  width 100%
  background-color #3070bc
  color #ffffff
  text-align center
  border none
  padding $space-2
  cursor pointer
</style>
