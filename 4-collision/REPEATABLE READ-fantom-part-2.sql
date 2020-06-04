--фантом
set transaction isolation level REPEATABLE READ
begin transaction


-- 2
INSERT INTO PLAYERS VALUES
('Popov Nikolay',1998,36,1,52,4000,4); 
COMMIT
 
 delete  from PLAYERS where RATING=4000
