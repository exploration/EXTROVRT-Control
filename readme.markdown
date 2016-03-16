# EXTROVRT Control
Author: Donald L. Merand for [Explo](http://www.explo.org)

This is a simple [Sinatra](http://sinatrarb.com) application designed to:
- Make it easy to control multiple [EXTROVRT](https://github.com/exploration/EXTROVRT)s
- Allow EXTROVRT control via the keyboard

# Setup
- You'll need to have a server that can handle Sinatra. [Passenger](https://www.phusionpassenger.com/) seems to work pretty well.
- Copy `Rakefile.example` to `Rakefile` if you want to use the script-watching and deploy methods I use. You'll need to install [SCSS/SASS](http://sass-lang.com/) and [CoffeeScript](http://coffeescript.org/) if you want to make modifications to the stylesheets or scripts.
- Copy `config.example.yml` to `config.yml` and fill out the relevant data with your own authentication information, [Adafruit IO Key](http://adafruit.io), and so forth.

## Adafruit IO Setup
You'll want to create a feed for each robot you plan to run named `extrovrt-robotname`. So, for example, if you wanted a robot named "Gale", you'd create a feed in Adafruit IO called `extrovrt-gale`. You can change the name of the "base feed" from `extrovrt` if you want to, in `config.yml`. If you want an access log, you can specify the name of that feed in `config.yml` as well.
