import gql from "graphql-tag";

export const GET_ALL_MATCHES = gql`
  query AllMatches {
    matches(order_by: { started_at: desc }) {
      id
      started_at
      p1 {
        name
      }
      p2 {
        name
      }
      setts {
        p1_score
        p2_score
      }
    }
  }
`;

export const GET_LIVE_MATCHES = gql`
  subscription LiveMatches {
    matches(
      order_by: { started_at: desc }
      where: { finished: { _eq: false } }
    ) {
      id
      started_at
      p1 {
        name
      }
      p2 {
        name
      }
      setts {
        p1_score
        p2_score
      }
      winner_ref
    }
  }
`;

export const GET_FINISHED_MATCHES = gql`
  query FinishedMatches {
    matches(
      order_by: { started_at: desc }
      where: { finished: { _eq: true } }
    ) {
      id
      started_at
      p1 {
        name
      }
      p2 {
        name
      }
      setts {
        p1_score
        p2_score
      }
      winner_ref
    }
  }
`;
