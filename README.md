# BlockBuster

This is an API for managing BlockBuster life.

## Get code and install

```shell
git clone git@github.com:dchuquilla/BlockBuster.git
bundle
```

Load datavase

```shell
rails db:create db:migrate db:seeds
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
