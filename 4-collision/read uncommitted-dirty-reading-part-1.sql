--грязное чтение
set transaction isolation level read uncommitted
begin transaction

--1)
select RATING from players where PLAYER_ID=5

 --3
 select RATING from players where PLAYER_ID=5

 --5
 select RATING from players where PLAYER_ID=5
 commit