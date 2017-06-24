<template>
  <div>
    <step-header
      title="Add Tags"
      :prevUrl="prevUrl"
      :show-action-button="showActionButton"
      :actionCallback="save"
    ></step-header>

    <h2>Suggested Tags</h2>

    <div
      v-for="(value, key) in tagsByType"
      :key="key"
    >
      <h3>{{ key }}</h3>

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
  </div>
</template>

<script>
import _ from 'lodash'
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
      selectedTagIds: _.cloneDeep(this.$store.getters['postWizard/tagIds'])
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
      return _.groupBy(this.tags, (tag) => tag.type)
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
    }
  },

  created () {
    if (this.tags.length === 0) {
      this.findAll()
    }
  }

}
</script>

<style scoped>
.tag {
  background-color: #3e8ac1;
  color: white;
  border-radius: 20px;
  border: none;
  outline: none;
  -webkit-appearance: none;
  cursor: pointer;
  transition: background-color 140ms ease-out;
}

.tag.selected {
  background-color: #7bb85c;
}
</style>
