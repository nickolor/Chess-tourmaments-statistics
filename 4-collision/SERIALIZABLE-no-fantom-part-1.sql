--нет фантома
set transaction isolation level SERIALIZABLE
begin transaction


--1
SELECT RATING FROM PLAYERS WHERE rating>2350

 --3
SELECT RATING FROM PLAYERS WHERE rating>2350
COMMIT

