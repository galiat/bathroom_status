var b = require('bonescript');
var request = require('request');
var inputPin = 'P8_19';
b.pinMode(inputPin, b.INPUT);

function updateStatus(x) {
    console.log(JSON.stringify(x));
    var status;
    if(x.value===0) {
        status = 'closed';
    }else{
        status = 'open';
    }
    request.post(
      'http://bathroomstatus.herokuapp.com/update',
      { form: { status: status } },
      function (error, response, body) {
          if (!error && response.statusCode == 200) {
              console.log(body);
          }
      }
    );
}

b.attachInterrupt(inputPin, true, b.CHANGE, updateStatus);