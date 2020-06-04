--тупик
set transaction isolation level repeatable read 
SET DEADLOCK_PRIORITY 0
begin transaction

--2
select RATING from players where PLAYER_ID=6
--4
update players set RATING = 3333 where PLAYER_ID=5
commit