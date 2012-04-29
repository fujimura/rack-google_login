# rack-google_login [<img src="https://secure.travis-ci.org/fujimura/rack-google_login.png"/>](http://travis-ci.org/fujimura/rack-google_login)

## Minimalist login for rack app with Google account

## Installation

Add to gemfile

    gem 'rack-google_login'

or install with

    gem install rack-google_login

## How to use

* Mount it
Mount before the main app and put configuration hash into it.
[example](https://github.com/fujimura/rack-google_login/blob/master/example/config.ru)

* Create login page
Use `Rack::GoogleLogin.authorization_uri` to get uri of Google OAuth 2.0 authoization endpoint.
[example](https://github.com/fujimura/rack-google_login/blob/master/example/app.rb#L15)

* Controll access with `session['user_info']`
Redirect user who is not authorized to login page.
If `user_info` was not found in `session`, the user is not yet authorized with Google.
[example](https://github.com/fujimura/rack-google_login/blob/master/example/app.rb#L5)


* Use `user_info`
[example](https://github.com/fujimura/rack-google_login/blob/master/example/app.rb#L29)

## Example
Simple sinatra app can be found [here](https://github.com/fujimura/rack-google_login/tree/master/example).

## TODO

* Configurable root
* Use refresh token
* Make scopes configurable
* Add more session store

## Contribution

All kind of pull requests are very welcome ;-)

## License

MIT Licence
