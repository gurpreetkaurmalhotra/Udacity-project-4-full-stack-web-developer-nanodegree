-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- create a database named tournament
create database tournament;

-- switch to the newly created databse
\c tournament

-- table for the name of the players enrolled in the game
create table players(
    id serial PRIMARY KEY,
    name text
);

-- get the winner and loser name for each match
create table results(
    winner INTEGER references players,
    loser INTEGER references players,
    PRIMARY KEY(winner, loser)
);

-- This view tells how many wins each player has
create view wins as select players.id, count(results.winner) as wins from players left join results on players.id = results.winner group by players.id order by wins desc;
 
-- This view tells how may matches has been played
create view matches as select players.id, count(results.*) as matches from players left join results on players.id = results.winner or players.id = results.loser group by players.id order by players.id;

-- This view gives the list of players' name, their id, wins and matches played
create view standings as select players.id, players.name, wins.wins, matches.matches from players join wins on players.id = wins.id join matches on players.id = matches.id order by wins.wins desc, players.id asc;


