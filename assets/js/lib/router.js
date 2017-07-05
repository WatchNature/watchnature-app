import Vue from 'vue'
import VueRouter from 'vue-router'
import Routes from './routes'
import store from '../store/index'
import _ from 'lodash'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: Routes
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (_.isEmpty(store.state.authToken)) {
      next({
        path: '/signin',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else {
    next()
  }
})

export default router
