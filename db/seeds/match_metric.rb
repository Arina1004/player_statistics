puts '--Match_metric seeds begin --'
MatchMetric.create!([
  { player_id: 1, metric_id: 1, match_id: 1 },
  { player_id: 1, metric_id: 2, match_id: 1 },
  { player_id: 2, metric_id: 1, match_id: 1 },
  { player_id: 4, metric_id: 1, match_id: 1 },
  { player_id: 4, metric_id: 1, match_id: 3 },
  { player_id: 4, metric_id: 1, match_id: 4 },
  { player_id: 5, metric_id: 2, match_id: 4 },
  { player_id: 6, metric_id: 1, match_id: 4 },
  { player_id: 6, metric_id: 1, match_id: 5 },
  { player_id: 7, metric_id: 1, match_id: 5 },
  { player_id: 8, metric_id: 1, match_id: 5 },
  { player_id: 9, metric_id: 1, match_id: 5 }
])