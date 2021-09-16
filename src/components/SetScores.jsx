/* eslint-disable no-unused-expressions */
/* eslint-disable no-plusplus */
import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import TableCell from "@material-ui/core/TableCell";

const useStyles = makeStyles(() => ({
  winner: {
    fontWeight: "bold",
  },
  loser: {
    fontWeight: "normal",
  },
  set: {
    textAlign: "center",
    borderBottom: "none",
    paddingLeft: "0",
    width: "13%",
  },
}));

const SetScores = (props) => {
  const classes = useStyles();
  const { sets, playerRef, matchId } = props;

  const tableCells = sets.map((set, idx) => {
    const score = set[`${playerRef}_score`];
    const classNames = [classes.set];

    if (playerRef === "p1") {
      set.p1_score > set.p2_score && classNames.push(classes.winner);
    } else {
      set.p2_score > set.p1_score && classNames.push(classes.winner);
    }

    return (
      <TableCell key={`${matchId}-${idx}`} className={classNames.join(" ")}>
        {score}
      </TableCell>
    );
  });

  const fillCount = 3 - sets.length;

  for (let i = 0; i < fillCount; i++) {
    tableCells.push(
      <TableCell key={i + Math.random()} className={classes.set} />
    );
  }

  return tableCells;
};

export default SetScores;
