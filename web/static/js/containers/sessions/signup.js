import React from 'react'

const Signup = () => (
  <div className="c-container pa3">
    <form>
      <div className="mb3">
        <label className="db" htmlFor="first_name">First Name</label>
        <input className="db w-100" type="text" id="first_name" name="last_name" />
      </div>
      <div className="mb3">
        <label className="db" htmlFor="last_name">Last Name</label>
        <input className="db w-100" type="text" id="last_name" name="last_name" />
      </div>
      <div className="mb3">
        <label className="db" htmlFor="email">Email</label>
        <input className="db w-100" type="email" id="email" name="email" />
      </div>
      <div className="mb3">
        <label className="db" htmlFor="password">Password</label>
        <input className="db w-100" type="password" id="password" name="password" />
      </div>
      <div>
        <input type="submit" value="Sign Up" />
      </div>
    </form>
  </div>
)

export default Signup
