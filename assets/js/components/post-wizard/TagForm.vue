<template>
  <div>
    <step-header
      title="Add Tags"
      :prevUrl="prevUrl"
      :show-action-button="showActionButton"
      :actionCallback="save"
    ></step-header>

    <form>
      <input
        type="text"
        placeholder="Search Tags"
        v-model="keywords"
      >
    </form>

    <h2>Suggested Tags</h2>

    <transition-group name="fade">
      <div
        v-for="(value, key) in tagsByType"
        :key="key"
      >
        <h3>{{ startCase(key) }}</h3>

        <button
          v-for="tag in value"
          :key="tag.id"
          @click.prevent="handleTagSelect(tag)"
          class="tag pv1 ph2 dib mr1"
          :class="{'selected': isSelectedTagId(tag.id) }"
          title="Add Tag"
        >
          {{ tag.name }}
        </button>
      </div>
    </transition-group>
  </div>
</template>

<script>
import _ from 'lodash'
import Fuse from 'fuse.js'
import { mapActions, mapGetters } from 'vuex'
import StepHeader from './StepHeader.vue'

export default {
  name: 'TagForm',

  components: {
    StepHeader
  },

  data () {
    return {
      prevUrl: '/posts/new',
      selectedTagIds: _.cloneDeep(this.$store.getters['postWizard/tagIds']),
      fuse: null,
      keywords: '',
      results: []
    }
  },

  watch: {
    keywords () {
      this.search()
    }
  },

  computed: {
    ...mapGetters({
      tags: 'tags/allTags'
    }),

    valid () {
      return !!this.selectedTagIds.length
    },

    showActionButton () {
      return this.valid
    },

    tagsByType () {
      let list

      if (this.searching) {
        list = this.results
      } else {
        list = this.tags
      }

      return _.chain(list)
                .orderBy(['type'], ['asc'])
                .groupBy((tag) => tag.type)
                .value()
    },

    searching () {
      if (this.keywords.length === 0) {
        return false
      } else {
        return true
      }
    }
  },

  methods: {
    ...mapActions({
      findAll: 'tags/findAll'
    }),

    handleTagSelect (tag) {
      if (this.isSelectedTagId(tag.id)) {
        this.selectedTagIds = _.remove(this.selectedTagIds, (id) => {
          return id !== tag.id
        })
      } else {
        this.selectedTagIds.push(tag.id)
        this.selectedTagIds = _.uniq(this.selectedTagIds)
      }
    },

    isSelectedTagId (id) {
      return _.includes(this.selectedTagIds, id)
    },

    save () {
      this.$store.dispatch('postWizard/addTagids', this.selectedTagIds)
        .then(() => {
          this.$router.push(this.prevUrl)
        })
    },

    startCase (str) {
      return _.startCase(str)
    },

    buildFuse (list) {
      this.fuse = new Fuse(list, {
        tokenize: true,
        matchAllTokens: true,
        keys: ['name']
      })
    },

    search () {
      this.results = this.fuse.search(this.keywords)
    }
  },

  created () {
    if (this.tags.length === 0) {
      this.findAll()
        .then(response => this.buildFuse(response))
    } else {
      this.buildFuse(this.tags)
    }
  }

}
</script>

<style lang="stylus" scoped>
.tag
  background-color #cccccc
  color white
  border-radius 20px
  border none
  outline none
  -webkit-appearance none
  cursor pointer
  transition background-color 140ms ease-out
  &.selected
    background-color #3e8ac1
</style>
