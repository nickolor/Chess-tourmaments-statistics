--пример невыполнения потери изменений
set transaction isolation level read uncommitted

BEGIN TRANSACTION


--1
UPDATE players SET rating=111 WHERE player_id=5

--3
 ROLLBACK
