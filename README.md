# GraphQL Tennis Scores

This repo will help you setup a small React app that talks to a GraphQL endpoint.

The get up and running you have to complete these steps:

0. Clone this repo
1. [Create a free Hasura project and deploy it to Heroku](https://hasura.io/docs/1.0/graphql/manual/getting-started/heroku-simple.html)
2. Import a database structure and some sample contents
3. Generate a GraphQL Schema using Hasura
4. Explore the data using Hasura's playground (GraphiQL)
5. Configure the Apollo to talk to the graphql endpoint

## The tennis scores GraphQL endoint

We need a GraphQL endpoint to talk to. We will quickly setup our own using Heroku and Hasura.

### Want to create a new GraphQL app from scratch?

To setup something similar to this or a new project, you just need a few steps

1. Create a new React app (if you haven't already)
2. `npm install apollo-boost @apollo/react-hooks graphql`
3. basically just follow the steps here: https://www.apollographql.com/docs/react/get-started/
