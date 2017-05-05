import React from 'react'

const SummaryCard = ({ post }) => (
  <div className="card summary">
    <header className="card__header">
      <span className="card__header__speciesname">Species Common name</span>
      <span className="card__header__location">Location</span>
    </header>

    <img className="card__image" src={`https://placem.at/places?w=750&h=750&random=${post.id}`} />

    <div className="content">
      <p>{post.description}</p>
    </div>
  </div>
)

export default SummaryCard
