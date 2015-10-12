## Remote Server
run `cp bathroom-config-sample.json bathroom-config.json`
update config.json
Deploy code to server
If you want to run locally,
  1. type `rackup`
  1. visit localhost:9292

## Beagle

### Software/Server Setup
You'll need:
* beaglebone black
* microSD card
* usb wifi antenea
* Mini USB cable
* 5VDC adapter
1. Install debian on the beagle. [tutorial](http://beagleboard.org/getting-started).
1. Connect it to the internet. [tutorial](http://makezine.com/projects/easily-configure-wi-fi-for-the-beaglebone-black/)
  * Note that the 4 port USB hub is not needed. The USB wifi adapter can be directly plugged into the BeagleBone.
1. While it is connected to your computer, navigate to http://192.168.7.2:3000/ide.html
1. Copy and paste `bathroom.js` into `cloud9/autorun`
1. Copy and paste `config-sample.js` into `cloud9/autorun` as `config.js`
1. In the clound9 editor, update `serverbase`, `bathroomName`, `secret` values.
  * config.secret can remain blank.

### Sensor Setup
* reed switch aka magnetic door switch set [buy](https://www.sparkfun.com/products/13247)
* at least 2 jumper cables
* e-tape
* a way to mount it to the wall/door. I used velcro tape for this.

1) Determine What kind of reed swtich you have
  Reed switches can work two ways
    * NO means 'Normally Open' The digital input will be `0` when the door is closed
    * NC means 'Normally Closed' The digital input will be `0` when the door is open
  Some let you choose bewteen the two, others do not. The once that do not are usually NO, but check the documentation.
1) Connect the reed switch to the beaglebone.
  Use a [pinout chart](http://www.element14.com/community/servlet/JiveServlet/showImage/38-17874-209857/bbb-pinout.jpg) to connect the beagebone to the reed switch.
   * Connect power or `com` to P9_03 (VDD_3V3)
   * Connect the other end or the Normally Open connector to P0_19


1) I reccomend attaching it to the outside of the bathroom door rather than the inside to make maintainace more pleasent



## Slack
Follow slack's instructions for setting up a [Slash Command](https://adskbim360.slack.com/services/new/slash-commands)