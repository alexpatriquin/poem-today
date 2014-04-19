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
//= require jquery_ujs
//= require turbolinks
//= require_tree .
 
    Twilio.Device.setup(gon.token,{"debug":true});
 
    $(document).ready(function() {
        $("#keillorbot").click(function() {
            speak();
        });
    });
 
    function speak() {
        var voice_title = $("#voice-title").val();
        var voice_poet = $("#voice-poet").val();
        var voice_content = $("#voice-content").val();
 
        $('#keillorbot').attr('disabled', 'disabled');
 
        Twilio.Device.connect({ 'voice_title':voice_title, 'voice_poet':voice_poet, 'voice_content':voice_content });
    }
 
    Twilio.Device.disconnect(function (conn) {
        $('#keillorbot').removeAttr('disabled');
    });