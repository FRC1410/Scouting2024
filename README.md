# README

## Scouting 2024 ##

Welcome to the 2024 FRC Scouting App.

Let's get you setup to ship some features!

This is a Rails 7 App. These instructions are Mac specific. It would be great for someone to figure out how to get it up on Windows.

  * I assume you already have `git` since you are seeing this README.
  * First you will need `rbenv`.
  * On windows do this instead [rbenv windows](https://github.com/ccmywish/rbenv-for-windows)
  * Follow the instructions [here](https://github.com/rbenv/rbenv)
  * The easiest way on a mac is using [homebrew](https://brew.sh/)
  * If you have installed `brew` then run `brew install rben`
  * If you have already cloned this project locally then you will need to activate Ruby 3.0.3 by `cd`ing into the `Scouting1410` directory.
  * You can do this
    ```bash
        cd ..
        cd -  
    ```
  * If you are having trouble with `rbenv` or `brew` such as those cammands not showing up even after you install it may be an issue with your shell environment, `zsh`. You are running `zhh` if you see that at the top of your terminal window. Contact Lew if this is the case.
  * Next you will need `yarn` to install the javascript packages.
  * If you installed `brew` then just `brew install yarn`
  * Run `yarn` inside the project directory and you should be g2g.
  * Next type `bundle` to install gems
  * Next get the local database setup.
  * Run `rake db:create db:migrate db:seed`
  * Finally you need a `.env` inside `Scouting2420`. Create that file and add the following line so that Google Auth is disabled on your local install.
    ```bash
    AUTH_ENABLED=false
    ```
  * Next you need to grab all the ruby gems needed for the project.
  * Run `bundle install`
  * You are ready to give the app a test drive.
  * run `./bin/dev`
  * Go to [http://localhost:3000/](http://localhost:3000/)
  * Reach out on discord if you have any issues or errors.

# RESOURCES #

* I highly recommend you use the ItelliJ based ruby IDE `RubyMine` from [JetBrains](https://www.jetbrains.com/ruby/) which you should have full access to via you educational account. However, VSCode should also be fine. RubyMine has some really nice features for working on Rails projects.
* 
* Rails is written in Ruby. Its is a fun language that prioritizes developer happiness. 
  * https://ruby-doc.org/
  * https://www.ruby-lang.org/en/documentation/quickstart/
* Rails was one of the first Model View Controller frameworks. A Model represents the datastore, most often a table in a database. A View is teh visual representation of the data, most often a webpage. A controller hooks the view to the model. We are using Rails 7 which as of this writing is the latest version. (Rails 8 is coming soon)
  * https://guides.rubyonrails.org/ This talks about how Rails works.
  * https://api.rubyonrails.org/ this is the API documentation.
* Of course you can't do anything on the web without JavaScript and CSS. Knowing the basics of those two things is important.
  * https://developer.mozilla.org/en-US/docs/Web/JavaScript
  * https://developer.mozilla.org/en-US/docs/Web/CSS
* On that note, Rails 7 by default uses a lightweight javascript framework called Stimulus. See the `SelectController` in the app for an example.
  * https://stimulus.hotwired.dev/handbook/introduction
* Also, Rails 7 uses `Turbo` to do server side rendering of HTML that is then injected into the DOM so the entire page does not need to reload. If you don't know what that means, ask Lew.
  * https://turbo.hotwired.dev/handbook/introduction
* CSS is how webpages are made pretty but it can be hard. To help make it easier, we are using a CSS framework called `foundation-sites`.
  * https://get.foundation/sites/docs/
  * This has a ton of great video tutorials.
* Out of the box web forms are not very user friendly. We are using a javascript plugin called `tom-select` to make them fancier.
  * https://tom-select.js.org/


