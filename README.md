# BlockBuster

This is an API for managing BlockBuster life.

## Get the code and install

```shell
git clone git@github.com:dchuquilla/BlockBuster.git
bundle
```

## Secrets

Please load secrets as env vars

```shell
export JWT_SECRET=your-secret-here
export PEPPER_KEY=your-secret-here
```

Also, please set db connection vars

```shell
export PSQL_USER=postgres-username-here
export PSQL_password=postgres-password-here
```

## Load database

```shell
rails db:create db:migrate db:seed
```

This command with print the credentials for admin users, please save them into your notes.
