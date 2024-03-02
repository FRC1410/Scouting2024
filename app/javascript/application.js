// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
import "foundation-sites"
import Rails from "@rails/ujs"

Rails.start()

window.jQuery = jquery
window.$ = jquery
window.checkConnection = function () {
    $.ajax('/healthcheck2.json',
        {
            error: function () {
                $('body').addClass('offline')
                $('body').prepend("<div class='offline'>YOU ARE OFFLINE</div>")
            }
        }
    ).then(() => {
        $('body').removeClass('offline')
        $('div.offline').remove()
    })
    setTimeout(window.checkConnection, 1000);
}

$(function () {
    $(document).foundation();
    Turbo.session.drive = false
    if (window.doHealthcheck) {
        setTimeout(window.checkConnection, 1000);
    }
})

window.addEventListener( "pageshow", function ( event ) {
    var historyTraversal = event.persisted ||
        ( typeof window.performance != "undefined" &&
            window.performance.navigation.type === 2 );
    if ( historyTraversal ) {
        // Handle page restore.
        window.location.reload();
    }
});