use vinaykumar
go

CREATE TABLE Teams (team_id INT PRIMARY KEY,
  team_name VARCHAR(50) NOT NULL
);

CREATE TABLE Players (
  player_id INT PRIMARY KEY,
  player_name VARCHAR(255) NOT NULL,
  team_id INT,
  FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE Matches (
  match_id INT PRIMARY KEY,
  team1_id INT,
  team2_id INT,
  match_date DATE,
  score1 INT,
  score2 INT,
  FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
  FOREIGN KEY (team2_id) REFERENCES Teams(team_id)
);

CREATE TABLE Stats (
  stat_id INT PRIMARY KEY,
  player_id INT,
  match_id INT,
  goals_scored INT,
  assists INT,
  yellow_cards INT,
  red_cards INT,
  FOREIGN KEY (player_id) REFERENCES Players(player_id),
  FOREIGN KEY (match_id) REFERENCES Matches(match_id)
);

INSERT INTO Teams (team_id, team_name) VALUES
  (1, 'Team A'),
  (2, 'Team B'),
  (3, 'Team C');

INSERT INTO Players (player_id, player_name, team_id) VALUES
  (1, 'Player 1', 1),
  (2, 'Player 2', 1),
  (3, 'Player 3', 2),
  (4, 'Player 4', 3);

INSERT INTO Matches (match_id, team1_id, team2_id, match_date, score1, score2) VALUES
  (1, 1, 2, '2025-09-01', 3, 1),
  (2, 2, 3, '2025-09-02', 2, 2),
  (3, 1, 3, '2025-09-03', 1, 0);

INSERT INTO Stats (stat_id, player_id, match_id, goals_scored, assists, yellow_cards, red_cards) VALUES
  (1, 1, 1, 2, 1, 0, 0),
  (2, 2, 1, 1, 0, 1, 0),
  (3, 3, 2, 1, 1, 0, 0);

  SELECT 
  m.match_id,
  t1.team_name AS team1_name,
  t2.team_name AS team2_name,
  m.score1,
  m.score2
FROM Matches m
JOIN Teams t1 ON m.team1_id = t1.team_id
JOIN Teams t2 ON m.team2_id = t2.team_id;

-- Player scores
SELECT 
  p.player_name,
  SUM(s.goals_scored) AS total_goals
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
GROUP BY p.player_name;

-- Leaderboard view

SELECT 
  p.player_name,
  SUM(s.goals_scored) AS total_goals,
  SUM(s.assists) AS total_assists
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
GROUP BY p.player_name