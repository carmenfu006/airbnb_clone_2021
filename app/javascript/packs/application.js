// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// import './stripe'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"

// because the script tag is looking for a global variable so we gonna create one
// collect all the arguments
// trigger a custom event when google map is ready to broadcast out to all of the stimulus controller so we can listen to it
window.initMap = function(...args) {
  const event = document.createEvent("Events")
  event.initEvent("google-maps-callbacks", true, true)
  event.args = args
  window.dispatchEvent(event)
}