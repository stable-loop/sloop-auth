# sloop-auth

Authentication and documentation controllers, views, and layouts for Rails applications.

## Installation

Add the gem to the host application's `Gemfile`:

```ruby
gem "sloop-auth", github: "stable-loop/sloop-auth", require: "sloop/auth"
```

Install the dependencies:

```bash
bundle install
```

The gem loads Devise, Haml, Google OAuth2, and OmniAuth Rails CSRF protection. Its Devise initializer is loaded by the engine, including the host application's `Cred` Google OAuth credentials.

## Initialization

From the root of the host Rails application, run:

```bash
bundle exec sloop-auth init
```

This copies the authentication files required by the host application:

- `db/migrate/20261127172027_devise_create_users.rb`
- `db/migrate/20261127172028_add_fields_to_user.rb`
- `app/policies/application_policy.rb`
- `app/models/user.rb`
- `spec/models/user_spec.rb`
- `spec/factories/users.rb`

The files are stored as templates in the gem and copied into the corresponding
paths in the current host application. Existing files with the same names are
replaced. After copying them, the command runs:

```bash
bin/rails db:migrate
```

The command removes the generated `application.html.erb`, `mailer.html.erb`,
`mailer.text.erb`, and `pwa/manifest.json.erb` view files when present.
It also creates empty `app/assets/images/nav_dark.png` and
`app/assets/images/nav_light.png` files when needed.

It also adds the Devise and Google sign-in routes directly to
`config/routes.rb` if they are not already present:

```ruby
devise_for :users, controllers: {
  omniauth_callbacks: "users/omniauth_callbacks",
  sessions: "users/sessions",
  registrations: "users/registrations"
}
post "users/google_sign_in", to: "users/google_sign_ins#create"
```

The initializer also adds the documentation routes and the authenticated root
for `DocsController`.

## Included controllers

- `DocsController`
- `Users::GoogleSignInsController`
- `Users::OmniauthCallbacksController`
- `Users::RegistrationsController`
- `Users::SessionsController`

The gem also provides the `User::SloopAuth` concern, which configures Devise,
Google OAuth, password complexity validation, and `User.from_google`.

## Included views

- Devise views under `app/views/devise`
- Documentation views and partials under `app/views/docs`
- `application` and `docs` layouts
- Layout partials for the navbar, settings, footer, flash messages, JavaScript, and metadata
- Layout component partial `layouts/components/_peer_link`
- Data partials used by the navbar

The engine gives Devise controllers priority for the Devise views supplied by the gem without changing view lookup priority for the host application's other controllers.
