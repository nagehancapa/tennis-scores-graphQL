import React from "react";
import Container from "@material-ui/core/Container";
import { makeStyles } from "@material-ui/core/styles";
import { Typography, Box } from "@material-ui/core";
import { useQuery, useSubscription } from "@apollo/react-hooks";
import ErrorIcon from "@material-ui/icons/Error";

import { GET_ALL_MATCHES, GET_LIVE_MATCHES } from "../graphql/queries";

const useStyles = makeStyles((theme) => ({
  root: {
    padding: "2em",
  },
}));

function MatchList() {
  const classes = useStyles();
  // const { loading, error, data } = useQuery(GET_ALL_MATCHES);
  const { data, error, loading } = useSubscription(GET_LIVE_MATCHES);

  if (loading) return "Loading...";
  if (error)
    return (
      <p>
        <ErrorIcon fontSize="large" />
        Error! ${error.message}
      </p>
    );

  return (
    <Container className={classes.root}>
      <Typography variant="h2">Live Scores</Typography>
      <Box>
        {data.matches.map((match) => (
          <article key={match.id}>
            <p>Match ID: {match.id}</p>
            <p>Match date: {match.started_at}</p>
            <ul>
              <li>
                {match.p1.name}{" "}
                {match.setts.map((score) => (
                  <p key={score.id}>{score.p1_score}</p>
                ))}
              </li>
              <li>
                {match.p2.name}{" "}
                {match.setts.map((score) => (
                  <p key={score.id}>{score.p2_score}</p>
                ))}
              </li>
            </ul>
            <hr />
          </article>
        ))}
      </Box>
    </Container>
  );
}

export default MatchList;
