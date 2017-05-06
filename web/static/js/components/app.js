import React from 'react'
import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom'

import Header from './global/header'
import Stream from '../pages/stream'

class App extends React.Component {
  render() {
    return (
      <Router>
        <div>
          <Header />

          <Route exact path="/" component={Stream} />
        </div>
      </Router>
    )
  }
}

export default App
