## Remote Server Setup
1. run `cp bathroom-config-sample.json bathroom-config.json`
1. update config.json. `bathroom_name` will be what people type into slack so keep that short.
1. Deploy code to server. The [heroku](http://heroku.com) free tier will work well for this.

### To run locally
1. type `rackup`
1. visit localhost:9292

## Beagle Bone

### Software/Server Setup
You'll need:
* BeagleBone black
* microSD card
* USB wifi antenea
* miniUSB cable
* 5VDC power adapter
1. Install debian on the beagle via [tutorial](http://beagleboard.org/getting-started).
1. Connect it to the internet via [tutorial](http://makezine.com/projects/easily-configure-wi-fi-for-the-beaglebone-black/).
  * Note that the 4-port USB hub is not needed. The USB wifi adapter can be directly plugged into the BeagleBone.
1. While it is connected to your computer via USB, navigate to http://192.168.7.2:3000/ide.html
1. Copy and paste `bathroom.js` into `cloud9/autorun`.
1. Copy and paste `config-sample.js` into `cloud9/autorun` as `config.js`.
  * `bathroom_name` in the config on Beagle should be the same as `name` in the remote server's config
1. In the clound9 editor, update `serverbase`, `bathroomName`, `secret` values.
  * config.secret can remain blank.
1. Unplug the USB cable, but keep the 5VDC power adapter plugged in.

### Sensor Setup
You'll need:
* reed switch aka magnetic door switch set [Buy here](https://www.sparkfun.com/products/13247)
  * Note: If your switch does not come with a second part you'll also need to procure simple magnet.
* at least 2 jumper cables (or something longer)
* e-tape
* a way to mount it to the wall/door. I used velcro tape for this.

1. Determine What kind of reed swtich you have
  Reed switches can work two ways. Some let you choose which mode to use, others do not. The once that do not are usually 'NO', but check the documentation.
    * NO means 'Normally Open' The digital input will be `0` when the door is closed
    * NC means 'Normally Closed' The digital input will be `0` when the door is open
1. Connect the reed switch to the BeagleBone.
  Use a [pinout chart](http://www.element14.com/community/servlet/JiveServlet/showImage/38-17874-209857/bbb-pinout.jpg) to connect the beagebone to the reed switch.
    * Connect power or 'com' to P9_03 (VDD_3V3)
    * Connect the other end or the Normally Open connector to P0_19
1. Test it out! 
  1. Tail your remote server's logs
  1. Plug the BeagleBone into your computer via USB
  1. Simulate a closed door by bringing the reed switch connected to the BeagleBone into the proximity of the magnet
  1. Check the logs. There should be a http POST.
  1. If there isn't one it's time to troubleshoot. 

### Install
Figure out how you are going to mount it. The BeagleBone will need to remain plugged into the power adapter and the reed switch will need to reach the doorframe. I reccomend attaching everything to the outside of the bathroom door rather than the inside to make maintainace more pleasent.

1. Secure the wire connections with e-tape.
1. Plug the 5VDC power adapter in near the door. 
1. Secure the beaglebone ( I used velco tape)
1. Attach the connected part of the reed switch to the door frame.
1. Attach the loose part of the reedswitch to the door so that when the door is shut, the switch will trigger.

## Slack
Follow slack's instructions for setting up a [Slash Command](https://my.slack.com/services/new/slash-commands)
