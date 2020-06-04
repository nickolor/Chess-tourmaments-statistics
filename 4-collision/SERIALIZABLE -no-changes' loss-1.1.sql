--
set transaction isolation level Serializable
begin transaction

--2
UPDATE PLAYERS SET rating = rating+100 
where PLAYERS.PLAYER_ID=5
--4
COMMIT

select @@TRANCOUNT

UPDATE PLAYERS SET rating = 2175
where PLAYERS.PLAYER_ID=5