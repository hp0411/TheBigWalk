# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Start your ruby environment

If you installed ruby + rails through rvm - do rvm use 2.7.4
If you see `RVM is not a function, selecting rubies with 'rvm use ...' will not work.` - enter `/bin/bash --login` in the terminal.

## Start your local server

Enter `rails s`
You should see something like this:
```
=> Booting Puma
=> Rails 7.0.2.2 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.6.2 (ruby 2.7.4-p191) ("Birdie's Version")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 47078
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
```

Preview the app at `http://127.0.0.1:3000`

## Start your rails terminal to play with the data through the loaded app

`rails c`

## This app can now be run through Docker

This is not necessary but is nice :slightly_smiling_face:

Docker automatically sets up postgresql, rails, connects them, runs any migrations we may have added, and starts the server with a single command.

You can use it on any computer that you have docker installed on.

Docker installation for Ubuntu: https://docs.docker.com/engine/install/ubuntu/

Docker installation for Windows is just a single click on download and install: https://www.docker.com/get-started

Then both postgresql and the rails server can be started by `cd`-ing into the app directory and entering `docker-compose up`
