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
 

    $(document).ready(function() {
        var token = gon.token
        Twilio.Device.setup(token,{"debug":true});

        $("#twilio_talk").click(function() {
            speak();
        });
    });
 
    function speak() {
        var dialogue = $("#dialogue").val();
        var voice = $('input:radio[name=voice]:checked').val();
 
        $('#twilio_talk').attr('disabled', 'disabled');
 
        Twilio.Device.connect({ 'dialogue' : dialogue, 'voice' : voice });
    }
 
    Twilio.Device.disconnect(function (conn) {
        $('#twilio_talk').removeAttr('disabled');
    });