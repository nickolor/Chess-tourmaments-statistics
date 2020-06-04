--пример невыполнения потери изменений
set transaction isolation level read uncommitted

BEGIN TRANSACTION

--2
UPDATE players SET rating=333 WHERE player_id=5


--4
select rating from players WHERE player_id=5

 commit
 