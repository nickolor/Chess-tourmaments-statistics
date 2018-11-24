--нет грязное чтение
set transaction isolation level read committed
begin transaction

--2
update players set RATING = 3333 where PLAYER_ID=5

--4
ROLLBACK