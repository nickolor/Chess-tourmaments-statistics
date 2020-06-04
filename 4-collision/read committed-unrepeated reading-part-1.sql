--неповтор€ющиес€ значени€
set transaction isolation level READ COMMITTED
BEGIN TRANSACTION

--2
update PLAYERS SET RATING=555 WHERE PLAYER_ID=5
--3
COMMIT
