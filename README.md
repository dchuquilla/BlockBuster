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

## Pagination

All list endpoints are able to be paginated adding the following parameters to the URL

`
``ruby
page=1 # current page
per_page=1 # number of records per page

````

### example

```cURL
/a
pi/v1/movies.json?page=1&per_page=50
````

## Sorting

All list endpoints are able to sort adding the following parameters to the URL, s
ort can be multiple, see the example

```ruby
sort=column:direction,column:direction
# column => column name
# direction => asc/desc
```

### Example

```ruby
# sort by added_date descending and title ascending
/api/v1/movies.json?sort=added_date:desc,title:asc
```

## Filtering

It is also possible to filter results bay adding this parameters to URL

`
``ruby
filter[column][operator_code]=value

# column => column name

# operator_code => see the list for reference

````

### Filtering operators

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

### Example

```ruby
# filter by rental price less than $20 and available movies only
/api/v1/movies.json?filter[daily_rental_price][lt]=20&[available][eql]=true
````

## Searching movies

It is possible to search by movie title adding `search_for` parameter to the URL

```ruby
search_for=value
```

### Example

```ruby
# look for a movie that its title containes 'Prestige' word
/api/v1/movies.json?search_for=Prestige
```
