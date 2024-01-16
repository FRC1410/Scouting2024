# README

## Scouting 2024 ##

Welcome to the 2024 FRC Scouting App.

Let's get you setup to ship some features!

This is a Rails 7 App. These instructions are Mac specific. It would be great for someone to figure out how to get it up on Windows.

  * I assume you already have `git` since you are seeing this README.
  * First you will need `rbenv`.
  * Follow the instructions [here](https://github.com/rbenv/rbenv)
  * The easiest way on a mac is using [homebrew](https://brew.sh/)
  * If you have installed `brew` then run `brew install rben`
  * If you have already cloned this project locally then you will need to activate Ruby 3.0.3 by `cd`ing into the `Scouting1410` directory.
  * You can do this
    ```bash
        cd ..
        cd -  
    ```
  * Next you will need `yarn` to install the javascript packages.
  * If you installed `brew` then just `brew install yarn`
  * Run `yarn` inside the project directory and you should be g2g.
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
