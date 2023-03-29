#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


cat games.csv | while IFS="," read YEAR ROUND TEAM1 TEAM2 kek kek
do
  if [[ $TEAM1 != winner ]]
  then
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM1'")
    if [[ -z $TEAM_ID ]]
    then
      INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM1')")
    fi
  fi
  if [[ $TEAM2 != opponent ]]
  then
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM2'")
    if [[ -z $TEAM_ID ]]
    then
      INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM2')")
    fi
  fi
done


cat games.csv | while IFS=',' read YEAR ROUND TEAM1 TEAM2 GOALS1 GOALS2
do
  if [[ $TEAM1 != winner ]]
  then
    TEAM1_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM1'")
    TEAM2_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM2'")
    $PSQL "SELECT CAST ($YEAR AS INTEGER)"
    $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
    VALUES('$YEAR', '$ROUND', '$TEAM1_ID', '$TEAM2_ID', '$GOALS1', '$GOALS2')"
  fi
done