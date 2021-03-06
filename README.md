# Little Esty Shop

## Bulk Discounts

- Bulk discounts can be applied to a merchants items when bought over a quantity threshold, and then apply a discount based on a percentage. These discounts can be created, updated, and deleted.

## Overview

- This Rails application emulates a business intelligence application which displays records and their associated records, and allows users to perform CRUD actions on these records. Resources demonstrate one-to-many and many-to-many relationships.

## Heroku Deployment

- Status: Deployed
- Visit: https://blooming-escarpment-52891.herokuapp.com/

## Core Database Relationships

<img width="1006" alt="bulk_discounts_schema" src="/public/schema.png">


## CSV Tasks

This application uses custom rake tasks to import CSV data to database tables:
<ul>
   <li>To clear the CSV data: `rails csv_load:delete`</li>
   <li>To load all CSV files: `rails csv_load:all`</li>
   <li>To load individual CSV files: 'rails csv_load:{file}</li>
</ul>

## ActiveDesigner

- To create a visual of the database:
`active_designer --create ./db/schema.rb`

- To view it in a webpage:
`open active_designer/index.html`

## Gem Information

   ### Testing Gems
<ul>
   <li>RSpec</li>
   <li>SimpleCov</li>
   <li>Capybara</li>
   <li>ShouldaMatchers</li>
   <li>FactoryBot</li>
   <li>launchy</li>
   <li>Orderly</li>
   <li>Faker</li>

   ### API Gems
<li>Faraday</li>
<li>Webmock</li>
<li>VCR</li>
</ul

## Learning Goals

- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements

- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Setup

This project requires Ruby 2.5.3.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.
