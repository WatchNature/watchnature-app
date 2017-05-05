import React from 'react'
import Header from './global/header'
import Stream from '../pages/stream'

class App extends React.Component {
  render() {
    return (
      <div>
        <Header />
        <Stream />
      </div>
    )
  }
}

export default App
