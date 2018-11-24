--тупик
set transaction isolation level repeatable read 
SET DEADLOCK_PRIORITY 5
begin transaction

--1
select RATING from players where PLAYER_ID=5
--3
update players set RATING = 3333 where PLAYER_ID=6
commit