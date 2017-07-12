<template>
  <div class="spinner">
    <div class="bounce1"></div>
    <div class="bounce2"></div>
    <div class="bounce3"></div>
  </div>
</template>

<style lang="stylus" scoped>
.spinner
  width: 70px
  display: inline-block

.spinner > div
  width: 10px
  height: 10px
  background-color: #1981bf
  border-radius: 100%
  display: inline-block
  animation: sk-bouncedelay 1.4s infinite ease-in-out both

.spinner .bounce1
  animation-delay: -0.32s

.spinner .bounce2
  animation-delay: -0.16s

@-webkit-keyframes
  0$, 80$, 100$
    -webkit-transform: scale(0)
  40$
    -webkit-transform: scale(1)

@keyframes
  0$, 80$, 100$
    -webkit-transform: scale(0)
    transform: scale(0)
  40$
    -webkit-transform: scale(1)
    transform: scale(1)
</style>
