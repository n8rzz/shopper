[rbenv]: https://github.com/rbenv/rbenv
[rvm]: https://rvm.io/
[n]: https://www.npmjs.com/package/n
[nvm]: https://github.com/nvm-sh/nvm/blob/master/README.md#installing-and-updating
[Redis]: https://redis.io/download
[PostgreSQL]: https://www.postgresql.org/
[Foreman]: https://github.com/ddollar/foreman
[letter_opener]: https://github.com/ryanb/letter_opener

# Shopper

Create shopping lists with items and assemblies (groups of items)

## Prerequisites

* `ruby` - 2.7.0
* `node` - 11.10.1
* [Redis][Redis] - 5.0.7
* [PostgreSQL][PostgreSQL] - 11.3
* [Foreman][Foreman] - 0.87.0

It's highly recommened to use a version manager for both Ruby and Node.  Some popular ones are [rbenv][rbenv] or [rvm][rvm] for Ruby and [n][n] or [nvm][nvm] for node.

_A note about Ruby `2.7.0`_: As of this writing, you will need to add a few environment variables to squash some of the warnings in the output:

```bash
# add to ~/.basrc or ~/.zshrc
export RUBYOPT='-W:no-deprecated -W:no-experimental'
```

https://stackoverflow.com/questions/59491848/how-to-fix-rails-warning-messages-with-ruby-2-7-0

## Installation

```bash
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

## After seed

There will be an admin user available after db has been seeded.  See `db/seeds/02_users.rb` for email and password informaiton for this default user.

## Startup

The easiest way to get the app up and running is to run:

```bash
$ make start
```

This command requires the [Foreman][Foreman] gem to run.  This will automatically start both the `Rails` server and `Sidekiq`.  This app also uses the [letter_opener][letter_opener] gem for easy interaction with emails.

## Make

This project uses `make` to consilidate scripts and common tasks into a single place.  Have a look at the project's [Makefile](/Makefile) or run `$ make help` in your terminal to see the available commands.

## Database

There is a full copmlement of db seeds included in this project.  It's recommended to reset the db (`rails db:reset`) before starting on new work.
