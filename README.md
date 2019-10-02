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
MatchMetric::CreateMatchMetric.new.call(params: {player: Player.find(1), metric: Metric.find(1), match: Match.find(1)})
```
_To update the metric:_

```sh
MatchMetric::UpdateMatchMetric.new.call(match_metric: MatchMetric.find(1), params: {player: Player.find(1), metric: Metric.find(1), match: Match.find(1)})
```
_To check whether a player has completed a metric for the previous 5 matches:_

```sh
 Player.check_match_metric(metric: Metric.find(1))
```

_To find the top 5 players for a specific metric among all players:_

```sh
Player::TopFivePlayers.new.call(params: { metric: Metric.find(1)})
```
_or among the team:_

```sh
Player::TopFivePlayers.new.call(params: { metric: Metric.find(1), team: Team.find(1)})
```

# Tests

_To run:_

```sh
 rspec
```