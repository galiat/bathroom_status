var bone = require('bonescript');
var request = require('request');
var inputPin = 'P8_19';
bone.pinMode(inputPin, bone.INPUT);

require('./config.js')

function updateStatus(statusChange) {
    console.log(JSON.stringify(statusChange));
    var status;
    if(statusChange.value===0) {
        status = 'closed';
    }else{
        status = 'open';
    }
    request.post(
      config.serverBase + '/update',
      { form: { status: status, name: config.bathroomName, secret: config.secret} },
      function (error, response, body) {
          if (!error && response.statusCode == 200) {
              console.log(body);
          }
      }
    );
}

bone.attachInterrupt(inputPin, true, bone.CHANGE, updateStatus);