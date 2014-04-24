// $(document).ready(function() {
//     var token = $('#token').data('token');
//     Twilio.Device.setup(token,{"debug":true});
//     $("#keillorbot").click(function() {
//         speak();
//     });    

//     function speak() {
//         var voice_title = $("#voice-title").val();
//         var voice_poet = $("#voice-poet").val();
//         var voice_content = $("#voice-content").val();
 
//         $('#keillorbot').attr('disabled', 'disabled');
 
//         Twilio.Device.connect({ 'voice_title':voice_title, 'voice_poet':voice_poet, 'voice_content':voice_content });
//     }
 
//     Twilio.Device.disconnect(function (conn) {
//         $('#keillorbot').removeAttr('disabled');
//     });
// });