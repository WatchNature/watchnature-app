export default [
  {
    path: '/posts/new',
    component: require('../layouts/PostWizard.vue'),
    children: [
      {
        path: '/',
        component: require('../components/post/PostForm.vue'),
        name: 'postwizard',
        meta: { requiresAuth: true }
      }
    ]
  },
  {
    path: '/',
    component: require('../layouts/Default.vue'),
    children: [
      {
        path: '/',
        component: require('../components/stream/Stream.vue'),
        name: 'home'
      },
      {
        path: 'signup',
        component: require('../components/session/Signup.vue'),
        name: 'signup'
      },
      {
        path: 'signin',
        component: require('../components/session/Signin.vue'),
        name: 'signin'
      },
      {
        path: 'users/:id',
        component: require('../components/user/UserProfile.vue'),
        name: 'userprofile'
      }
    ]
  },
  {
    path: '*',
    component: require('../components/global/NotFound.vue')
  }
]
