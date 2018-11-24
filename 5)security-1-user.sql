use CHESS_TOURMAMENTS
DROP LOGIN testlogin
DROP USER testuser
go
CREATE LOGIN  testlogin WITH PASSWORD = '123456'
CREATE USER testuser FOR LOGIN testlogin
--������� ��� ��������� ������������
EXECUTE AS USER = 'testuser';
--���������,��� ����� ������ ������ ������������

SELECT * FROM PLAYERS --���������

INSERT INTO CLUBS VALUES ('������')--���������
revert

--1)����� SELECT, INSERT, UPDATE 

GRANT SELECT, INSERT, UPDATE
	ON PLAYERS 
	TO testuser;
-- ���������
EXECUTE AS USER = 'testuser';

revoke  SELECT, INSERT, UPDATE
	ON PLAYERS 
	TO testuser;

SELECT * FROM PLAYERS;--��������� ������

BEGIN TRANSACTION 
	INSERT INTO PLAYERS VALUES ('������ ����','1998',45,1,24,2001,4);--���������

	SELECT * FROM PLAYERS

ROLLBACK

BEGIN TRANSACTION 
	SELECT * FROM PLAYERS
	UPDATE PLAYERS 
		SET NAME = '����� �������' --�������� ��������
		WHERE PLAYER_ID = '1';

		SELECT * FROM PLAYERS
ROLLBACK

REVERT;
--2)����� SELECT � UPDATE ������ ��������� ��������.
GRANT SELECT, UPDATE 
	ON PLAYERS (NAME, YEAR_OF_BIRTH)
	TO testuser;
EXECUTE AS USER = 'testuser';

SELECT NAME, YEAR_OF_BIRTH FROM PLAYERS --���������



BEGIN TRANSACTION 
		SELECT * FROM PLAYERS

	UPDATE PLAYERS
		SET RATING = 777 --�������� ��������
		WHERE PLAYER_ID = '1';

		SELECT * FROM PLAYERS
ROLLBACK

REVERT;
--3)����� SELECT
GRANT SELECT 
	ON CLUBS
	TO testuser;

EXECUTE AS USER = 'testuser';

SELECT * FROM CLUBS;--���������

DELETE FROM CLUBS 
	WHERE CLUB_ID = 4;--�� ����� �������
REVERT;
--4)��������� ������ ������������ ����� ������� (SELECT) � �������������, ���������� � ������������ ������ �4

GRANT SELECT 
	ON Countries_statistics
	TO testuser;
EXECUTE AS USER = 'testuser';

SELECT * FROM Countries_statistics
REVERT;

--5)������� ����������� ���� ������ ���� ������,
-- ��������� �� ����� ������� (UPDATE �� ��������� �������) � �������������, 
--���������� � ������������ ������ �4, ��������� ������ ������������ ��������� ����.
CREATE ROLE TESTROLE;

GRANT UPDATE(NAME,PLAYERS) 
ON TITLES_STATISTIC 
	TO TESTROLE

ALTER ROLE TESTROLE ADD MEMBER testuser;
EXECUTE AS USER = 'testuser'

REVERT;

ALTER ROLE TESTROLE
	DROP MEMBER testuser;
DROP ROLE TESTROLE;

-------
CREATE USER l_user FOR LOGIN testlogin
drop user l_user
go
deny select on players to l_user
go
ALTER ROLE db_owner
	add MEMBER l_user;

	grant create table to l_user

grant alter on schema :: dbo to l_user
	execute as user = 'l_user'
	

	create table luser_table(st int)
	revert
	go
	drop table luser_table

	ALTER ROLE db_owner
	drop MEMBER l_user;

deny select on players to l_user

select * from players





	


