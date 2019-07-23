puts '--Match seeds begin --'
Match.create!([
  { name: "One - Two", date: '2019-01-01',teams: Team.where(id: [1, 2])},
  { name: "One - Two", date: '2019-03-05', teams: Team.where(id: [1, 2]) },
  { name: "Two - Three", date: '2019-05-12',teams: Team.where(id: [2, 3]) },
  { name: "One - Three", date: '2019-06-16',teams: Team.where(id: [1, 3])},
  { name: "Two - Three", date: '2019-07-18',teams: Team.where(id: [2, 3] )}
])
