#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != 'year' ]]
then 
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name ='$WINNER'")
      if [[ -z $WINNER_ID ]]
      then
        INSERT_WINNER=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
        
        echo $INSERT_WINNER
      fi
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name ='$OPPONENT'")
      if [[ -z $OPPONENT_ID ]]
      then
        INSERT_OPPONENT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
        echo $INSERT_OPPONENT
      fi
  GAME_ID_OPPONENT=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
  GAME_ID_WINNER=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
  GAME_INFO=$($PSQL "INSERT INTO games( year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR','$ROUND','$GAME_ID_WINNER','$GAME_ID_OPPONENT','$WINNER_GOALS','$OPPONENT_GOALS')")
fi
done