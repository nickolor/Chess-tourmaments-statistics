--при занесении занятого шахматистом места рейтинг шахматиста, 
--занявшего место не ниже 3-го увеличивается на величину: 
  --    ( 4 - место ) * квалификационный уровень турнира, 
--а рейтинг шахматиста из первой десятки и занявшего место 
--ниже двадцатого понижается на величину: 
 --       0,1 * занятое место.
 ----------------------------------------------------------------------------------


 DROP trigger Rating_change
 GO

create trigger Rating_change  on participations
after insert
as

UPDATE PLAYERS
SET PLAYERS.RATING += (4 - inserted.PLACE) * TOURMAMENTS.T_LEVEL
FROM PLAYERS,inserted,TOURMAMENTS
WHERE inserted.PLAYER_ID = PLAYERS.PLAYER_ID AND 
inserted.TOURMAMENT_ID = TOURMAMENTS.TOURMAMENT_ID AND
inserted.PLACE IN (1,2,3)

UPDATE PLAYERS
SET PLAYERS.RATING -= 0.1*inserted.PLACE
FROM PLAYERS,inserted
WHERE inserted.PLAYER_ID = PLAYERS.PLAYER_ID AND 
inserted.PLACE > 20 AND
inserted.START_NUMBER <= 10
GO

---------------------------------------------

-- создать таблицу с добавленным игроком , новым рейтингом, датой добавления, йд турнира участия


create table logi(
player_id int,
rating int,
data_add date,
tiurmament_id int
)

go

drop trigger logirovanie
go

create trigger logirovanie on participations
after insert
as

insert into logi 
select inserted.player_id , PLAYERS.RATING + (4 - inserted.PLACE) * TOURMAMENTS.T_LEVEL  ,
convert(date,getdate()),inserted.TOURMAMENT_ID 
FROM PLAYERS,inserted,TOURMAMENTS
WHERE inserted.PLAYER_ID = PLAYERS.PLAYER_ID AND 
inserted.TOURMAMENT_ID = TOURMAMENTS.TOURMAMENT_ID AND
inserted.PLACE IN (1,2,3)
 

 insert into logi 
select inserted.player_id , PLAYERS.RATING - 0.1*inserted.PLACE ,
convert(date,getdate()),inserted.TOURMAMENT_ID 
FROM PLAYERS,inserted
WHERE inserted.PLAYER_ID = PLAYERS.PLAYER_ID AND 
inserted.PLACE > 20 AND
inserted.START_NUMBER <= 10


GO


---------------------------------------------



BEGIN TRAN

select * from logi




INSERT INTO participations(TOURMAMENT_ID,PLAYER_ID,START_NUMBER,PLACE,PARTICIPATION_STATUS)
VALUES(1,3,1,2,1),(1,4,2,3,0)

select * from logi
ROLLBACK


BEGIN TRAN


select * from logi



INSERT INTO participations(TOURMAMENT_ID,PLAYER_ID,START_NUMBER,PLACE,PARTICIPATION_STATUS)
VALUES(1,3,3,25,1),(1,4,5,54,0)


select * from logi

ROLLBACK


select player_id, rating from PLAYERS




