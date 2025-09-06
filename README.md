Let's break down the Sports Tournament Tracker project into manageable steps.

Step 1: Create Schema
We'll design four tables: Teams, Players, Matches, and Stats.

- Teams Table
    - team_id (primary key): unique identifier for each team
    - team_name: name of the team
- Players Table
    - player_id (primary key): unique identifier for each player
    - player_name: name of the player
    - team_id (foreign key): references the Teams table
- Matches Table
    - match_id (primary key): unique identifier for each match
    - team1_id and team2_id (foreign keys): references the Teams table
    - match_date: date of the match
    - score1 and score2: scores of both teams
- Stats Table
    - stat_id (primary key): unique identifier for each stat entry
    - player_id (foreign key): references the Players table
    - match_id (foreign key): references the Matches table
    - goals_scored, assists, yellow_cards, red_cards: player performance metrics
CREATE TABLE Teams (
  team_id INT PRIMARY KEY,
  team_name VARCHAR(255) NOT NULL
);

CREATE TABLE Players (
  player_id INT PRIMARY KEY,
  player_name VARCHAR(255) NOT NULL,
  team_id INT,
  FOREIGN KEY (team_id) REFERENCES Teams(team_id)
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

Step 2: Insert Sample Tournament Data
Let's insert some sample data into the tables.
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

Step 3: Write Queries for Match Results and Player Scores
Let's write queries to retrieve match results and player scores.
-- Match results
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

Step 4: Create Views for Leaderboards and Points Tables
Let's create views for leaderboards and points tables.
-- Leaderboard view
CREATE VIEW Leaderboard AS
SELECT 
  p.player_name,
  SUM(s.goals_scored) AS total_goals,
  SUM(s.assists) AS total_assists
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
GROUP BY p.player_name
