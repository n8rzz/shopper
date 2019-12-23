# Shopper

Create shopping lists with items and assemblies (groups of items)

## Running locally

### Verify Ruby and Node

* `ruby` - 2.6.4
* `node` - 11.10.1

### Installation

```bash
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ rails start
```

### After seed

There will be an admin user available after db has been seeded.  See `db/seeds/02_users.rb` for email and password informaiton for this default user.
