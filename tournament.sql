-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


-- Step 1: Drop and Re-create database
--------------------------------------
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;


-- Step 2: CONNECT to newly created database
--------------------------------------------
\c tournament;


-- Step 3: Create the TABLEs
----------------------------
-- Contains list of player ids and player names
CREATE TABLE players (
    p_id SERIAL PRIMARY KEY,
    p_name VARCHAR(30)
);

--Contains list of match id, winner and loser player ids
CREATE TABLE matches (
    m_id SERIAL,
    winner_p_id SERIAL REFERENCES players(p_id),
    loser_p_id SERIAL REFERENCES players(p_id)
);


-- Step 2: Create the VIEWs
---------------------------
-- "standings" view is based on left outer join between players table and a
-- complex subquery. The complex subquery is used to find the "wins", "losses"
-- & "matches_played" to create the standings.
-- "Why left outer join": To include players even if they have not played a
-- match yet
CREATE OR REPLACE VIEW standings (p_id, p_name, wins, matches_played) AS
    SELECT players.p_id, p_name, wins, matches_played
    FROM players LEFT OUTER JOIN
                (   SELECT a.p_id, sum(a.wins) wins, sum(a.losses) losses,
                            sum(a.wins) + sum(a.losses) matches_played
                    FROM
                        (
                            SELECT w.p_id, w.wins, 0 losses
                            FROM --wins count subquery
                                (SELECT p_id, count(winner_p_id)  wins
                                FROM players LEFT OUTER JOIN matches
                                ON p_id = winner_p_id
                                GROUP BY p_id) w

                            UNION ALL

                            SELECT l.p_id, 0 wins, l.losses
                            FROM --losses count subquery
                                (SELECT p_id, count(loser_p_id)  losses
                                FROM players LEFT OUTER JOIN matches
                                ON p_id = loser_p_id
                                GROUP BY p_id) l

                        ) a
                     GROUP BY p_id
                ) player_status
    ON players.p_id = player_status.p_id;