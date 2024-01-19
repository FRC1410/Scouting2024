// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
import "foundation-sites"
import Rails from "@rails/ujs"
Rails.start()

window.jQuery = jquery
window.$ = jquery

$(function() {
    $(document).foundation();
    $(document).on("turbo:frame-load", () => {
        console.log('try reinit')
        Foundation.reInit('accordion');})
    $(document).on("turbo:frame-missing", () => {
        console.log('try reinit')
        Foundation.reInit('accordion');})

    Turbo.session.drive = false
})