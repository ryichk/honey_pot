# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Ruby version

- 3.2.1

## Database creation

```sh
bin/rails db:create
```

## Database initialization

```sh
bin/rails db:migrate
```

## How to run the test suite

```sh
bin/rails test
```

## Deployment instructions

### .envの作成

```sh
cp .env.sample .env
```

- DEPLOY_SERVER_IPにサーバーのIPアドレスを設定

- DEPLOY_SERVER_USERにサーバーのユーザ名を設定

- REPO_URLにGitHubなどのリポジトリURL(SSH)を設定

### Deployコマンド

```sh
bundle exec cap production deploy
```
