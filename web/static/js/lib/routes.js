export default [
  {
    path: '/',
    component: require('../components/stream/Stream.vue'),
    name: 'home'
  },
  {
    path: '/signup',
    component: require('../components/session/Signup.vue'),
    name: 'signup'
  },
  {
    path: '/signin',
    component: require('../components/session/Signin.vue'),
    name: 'signin'
  },
  {
    path: '/users/:id',
    component: require('../components/user/UserProfile.vue'),
    name: 'userprofile'
  },
  {
    path: '/posts/new',
    component: require('../components/post/PostForm.vue'),
    name: 'newpost',
    meta: { requiresAuth: true }
  },
  {
    path: '*',
    component: require('../components/global/NotFound.vue')
  }
]
