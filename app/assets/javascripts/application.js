// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require modernizr.custom
//= require bootstrap_1
//= require jquery.validationEngine-en
//= require jquery.validationEngine
//= require jquery.flexslider-min
//= require modernizr
//= require jquery.cslider
//= require back-to-top
//= require jquery.sticky
//= require app
//= require index
// require_tree .

$(document).on('ready page:load', function() {
    $("#formID").validationEngine();
    $('.onlyinteger').bind('keypress', function(e) {
        return !(e.which !== 8 && e.which !== 0 &&
                (e.which < 48 || e.which > 57) && e.which !== 46);
    });
});