 
    var token = $('#token').data('token')
    Twilio.Device.setup(token,{"debug":true});
 
    $(document).ready(function() {
        $("#keillorbot").click(function() {
            speak();
        });
    });
 
    function speak() {
        var poem_title = $("#poem-title").val();
        var poem_poet = $("#poem-poet").val();
        var poem_content = $("#poem-content").val();
 
        $('#keillorbot').attr('disabled', 'disabled');
 
        Twilio.Device.connect({ 'poem_title':poem_title, 'poem_poet':poem_poet, 'poem_content':poem_content });
    }
 
    Twilio.Device.disconnect(function (conn) {
        $('#keillorbot').removeAttr('disabled');
    });