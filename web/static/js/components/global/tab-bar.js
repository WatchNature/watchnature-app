import React from 'react'
import { Link } from 'react-router-dom'

const TabBar = () => (
  <div className="bc-blue fixed bottom-0 left-0 w-100 tc white pa3">
    <Link
      className="white no-underline ttu"
      to="/"
    >
      New
    </Link>
  </div>
)

export default TabBar
