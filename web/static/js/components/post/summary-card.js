import React from 'react'
import distanceInWordsToNow from 'date-fns/distance_in_words_to_now'

const Metabar = ({ post }) => (
  <div className="pa3 pb0 dt">
    <div className="dtc" style={{background: '#efefef', height: '50px', width: '50px', borderRadius: '100%'}}></div>
    <div className="pl3 dtc v-mid">
      <span className="db">{post.user.full_name}</span>
      <span className="db">{distanceInWordsToNow(post.inserted_at)} ago</span>
    </div>
  </div>
)

const SummaryCard = ({ post }) => (
  <div className="bg-white mb3">
    <header className="cf pa3">
      <span className="fl">Species Common name</span>
      <span className="fr">Location</span>
    </header>

    <div style={{height: '336px', width: '100%', background: '#000'}}></div>

    <Metabar post={post} />

    <div className="pa3">
      <p className="ma0">{post.description}</p>
    </div>
  </div>
)

export default SummaryCard
