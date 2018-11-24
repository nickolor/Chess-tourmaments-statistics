-- cоздать схему владельцем которой будет пользоваьель  А. дать  права на инсерт ПОЛЬЗОВАТЕЛЮ c. 
--  создать еще пользователя c с прилегией селекта в тадлице дбо. пусть А выдаст c права 
--инсерта в новой схеме

-- как отменить with grant option 
-- удалить привилегии А и Б затрагивая только пользователя А



USE CHESS_TOURMAMENTS
 CREATE LOGIN  testlOG WITH PASSWORD = '123456'
 CREATE USER testuser_A FOR LOGIN testlOG
 GO
 create schema NOVAEA_SCHEMA AUTHORIZATION testuser_A 
 CREATE TABLE TABLITSA (STOLBETS INT)
 GO
 
  CREATE LOGIN  testlOG_c WITH PASSWORD = '1234'
 CREATE USER testuser_C FOR LOGIN testlOG_c
 go

 
 go
 EXECUTE AS USER = 'testuser_A'
 grant INSERT ON NOVAEA_SCHEMA.TABLITSA TO testuser_C
  revert
 GO

 GO


 EXECUTE AS USER = 'testuser_C'
 INSERT INTO NOVAEA_SCHEMA.TABLITSA VALUES (55)
  revert
 GO
 
  SELECT * FROM NOVAEA_SCHEMA.TABLITSA



create login [Татьяна-ПК\GB] from windows
create user usus for login [Татьяна-ПК\GB]


grant select
on dbo.players
to usus
