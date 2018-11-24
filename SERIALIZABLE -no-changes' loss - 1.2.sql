
set transaction isolation level Serializable
begin transaction

--3
UPDATE PLAYERS SET rating = rating +200
 where PLAYERS.PLAYER_ID=5
 --5
 COMMIT
----------
go

