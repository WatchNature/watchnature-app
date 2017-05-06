import React from 'react'

const Signin = () => (
  <div className="c-container pa3">
    <form>
      <div className="mb3">
        <label className="db" htmlFor="email">Email</label>
        <input className="db w-100" type="email" id="email" name="email" />
      </div>
      <div className="mb3">
        <label className="db" htmlFor="password">Password</label>
        <input className="db w-100" type="password" id="password" name="password" />
      </div>
      <div>
        <input type="submit" value="Sign In" />
      </div>
    </form>
  </div>
)

export default Signin
