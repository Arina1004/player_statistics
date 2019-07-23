# Сonsole application

# Installation

Install Bundler, если нет. Установить нужные гемы:

```sh
gem install bundler
bundle install
```

To apply migration

```sh
bundle exec rake db:migrate
```

Fill the database with test data:

```sh
bundle exec rake db:seed
```

# How use

Run rails console:

```sh
bundle exec rails console
```

_To assign a player metric:_

```sh
MatchMetric::CreateMatchMetric.new.call(params: {player_id: 1, metric_id: 1, match_id: 1})
```
_To update the metric:_

```sh
MatchMetric::UpdateMatchMetric.new.call(match_metric_id: 1, params: {player_id: 1, metric_id: 1, match_id: 1})
```
_To check whether a player has completed a metric for the previous 5 matches:_

```sh
 Player.check_match_metric(metric_id)
```

_To find the top 5 players for a specific metric among all players:_

```sh
Player::TopFivePlayers.new.call(params: { metric_id: 1})
```
_or among the team:_

```sh
Player::TopFivePlayers.new.call(params: { metric_id: 1, team_id: 1})
```

# Tests

_To run:_

```sh
 rspec
```