// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
// import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import React from 'react'
import ReactDOM from 'react-dom'

import { createStore, applyMiddleware, combineReducers } from 'redux'
import { Provider } from 'react-redux'
import { composeWithDevTools } from 'redux-devtools-extension';
import { Route, Router } from 'react-router'
import { ConnectedRouter, routerReducer, routerMiddleware } from 'react-router-redux'
import createHistory from 'history/createBrowserHistory'
import thunk from 'redux-thunk'

import reducers from './reducers'
import Header from './components/global/header'
import TabBar from './components/global/tab-bar'

import Stream from './containers/stream'
import Signin from './containers/sessions/signin'
import Signup from './containers/sessions/signup'

const history = createHistory()
const middleware = [thunk, routerMiddleware(history)]
const store = createStore(
  reducers,
  composeWithDevTools(applyMiddleware(...middleware))
)

ReactDOM.render(
  <Provider store={store}>
    <Router store={store} history={history}>
      <div>
        <Header />

        <Route exact path="/" component={Stream} />
        <Route exact path="/sessions/signin" component={Signin} />
        <Route exact path="/sessions/signup" component={Signup} />

        <TabBar />
      </div>
    </Router>
  </Provider>
  , document.getElementById('app')
)
