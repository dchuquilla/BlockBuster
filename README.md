# BlockBuster

This is an API for managing BlockBuster life.

## Table of contents

- [BlockBuster](#blockbuster)
  - [Get the code and install](#get-the-code-and-install)
  - [Secrets](#secrets)
  - [Load database](#load-database)
  - [Sign UP a user](#sign-up-a-user)
  - [Login](#login)
  - [Movies endpoints](#movies-endpoints)
    - [List all movies](#list-all-movies)
    - [Pagination](#pagination)
      - [example](#example)
    - [Sorting](#sorting)
      - [Example](#example)
    - [Filtering](#filtering)
      - [Filtering operators](#filtering-operators)
      - [Example](#example-1)
    - [Searching movies](#searching-movies)
      - [Example](#example-2)
    - [Update a movie](#update-a-movie)
  - [Tickets](#tickets)
    - [validate/show a ticket endpoint](#validateshow-a-ticket-endpoint)
    - [Retrurn a ticket](#retrurn-a-ticket)

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

This command with print the credentials for admin and regular users, please save them into your notes.

## Sign UP a user

To sign up a user use `/signup` endpoint
With the following payload

```json
{
  "user": {
    "name": "tester",
    "email": "user999@blockbuster.com",
    "password": "P4ssW0rD"
  }
}
```

## Login

To login a user use this `POST /login` endpoint with this payload

```json
{
  "user": {
    "email": "user999@blockbuster.com",
    "password": "P4ssW0rD"
  }
}
```

This will return the access token into its response header under the Authorization key

```
Bearer eyJhbGc******
```

**Use this for the rest of the endpoints**

## Movies endpoints

### List all movies

Use the `GET /api/v1/movies.json` endpoint. _no payload needed_

### Pagination

All list endpoints are able to be paginated adding the following parameters to the URL

```ruby
page=1 # current page
per_page=1 # number of records per page

```

#### example

```cURL
GET /api/v1/movies.json?page=1&per_page=50
```

### Sorting

All list endpoints are able to sort adding the following parameters to the URL, s
ort can be multiple, see the example

```ruby
sort=column:direction,column:direction
# column => column name
# direction => asc/desc
```

#### Example

```ruby
# sort by added_date descending and title ascending
GET /api/v1/movies.json?sort=added_date:desc,title:asc
```

### Filtering

It is also possible to filter results bay adding this parameters to URL

```ruby
filter[column][operator_code]=value

# column => column name

# operator_code => see the list for reference

```

#### Filtering operators

| Operator Code | SQL Operator             |
| ------------- | ------------------------ |
| gte           | >=                       |
| lte           | <=                       |
| gt            | >                        |
| lt            | <                        |
| eql           | =                        |
| noteql        | !=                       |
| like          | like                     |
| in            | in                       |
| notin         | not in                   |
| null          | is null _or_ is not null |

Note: For the 'null' operator, _null_ as true and _not null_ as false

#### Example

```ruby
# filter by rental price less than $20 and available movies only
GET /api/v1/movies.json?filter[daily_rental_price][lt]=20&[available][eql]=true
```

### Searching movies

It is possible to search by movie title adding `search_for` parameter to the URL

```ruby
search_for=value
```

#### Example

```ruby
# look for a movie that its title containes 'Prestige' word
GET /api/v1/movies.json?search_for=Prestige
```

### Update a movie

**Only admins are allowed**
use the the endpoint `PUT /api/v1/movies/${id}.json` with the following payload.

```json
{
  "api_v1_movie": {
    "title": "Title updated",
    "daily_rental_price": "2"
  }
}
```

## Tickets

### validate/show a ticket endpoint

Use `GET GET /api/v1/tickets/validate/${code}.json` endpoint _no payload_

This has to show the following response payload or no ticket found.

```json
{
  "id": 50,
  "rent_id": 50,
  "code": "RENT-000050",
  "issue_date": "2023-03-25",
  "total_price": "143.16",
  "fine_state": "Apply Fine",
  "total_fine": "125.0"
}
```

### Retrurn a ticket

**Only admins are allowed**
Use `PATCH /api/v1/tickets/return/${code}.json`endpoint _no payload_

This has to show the following response payload or no ticket found.

```json
{
  "id": 50,
  "rent_id": 50,
  "code": "RENT-000050",
  "issue_date": "2023-04-10",
  "total_price": "15.56",
  "total_fine": "50.0",
  "state": "Returned"
}
```

Please notice the `state: returned`.
