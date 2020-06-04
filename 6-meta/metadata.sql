--������� ����� ���� ������,  ����������� ������������� ���� ������ 


SELECT t.NAME 
FROM SYS.sysobjects as t
	WHERE [xtype] = 'U' AND 
	t.NAME != 'sysdiagrams' and
	t.[uid] = (
	SELECT [uid] FROM sys.sysusers
	WHERE NAME = USER_NAME()
	)
----------------------------------------------------------------------
	

--������� ��� �������, ��� ������� �������, ������� ����, ��������� �� 
--������ ������� null-��������, �������� ���� ������ ������� �������,
--������ ����� ���� ������ - ��� ���� ������, ��������� �����������
-- ������������� ���� ������ � ���� �� �������� 



select  A.name ,col.name, col.isnullable,tip.name, tip.length as [������]
 from sys.sysobjects AS A
	join sys.syscolumns AS col on A.id = col.id
	join sys.systypes as tip on col.xtype = tip.xtype
	
		WHERE A.xtype = 'U' AND 
		a.NAME != 'sysdiagrams' and
	A.[uid] = (
	SELECT [uid] FROM sys.sysusers WHERE NAME = USER_NAME()
	)
	group by A.name ,col.name, col.isnullable,tip.name, tip.length
-----------------------------------------------------------------------------
	

--������� �������� ����������� ����������� (��������� � ������� �����), ��� �������,
--� ������� ��� ���������, ������� ����, ��� ��� �� ����������� 
--('PK' ��� ���������� ����� � 'F' ��� ��������) - ��� ���� ����������� �����������, 
--��������� ����������� ������������� ���� ������


SELECT KEYS.NAME, [TABLES].NAME , KEYS.[XTYPE]
FROM SYS.sysobjects AS KEYS,
 SYS.sysobjects AS [TABLES]
WHERE KEYS.parent_obj = [TABLES].id AND
[TABLES].NAME != 'sysdiagrams' and
(KEYS.[XTYPE] = 'PK' OR KEYS.[XTYPE] = 'F')
AND KEYS.[uid] = (
SELECT [uid] FROM sys.sysusers 
	WHERE NAME = USER_NAME()
)
---------------------------------------------



--������� �������� �������� �����, ��� �������, ���������� ������� ����, ��� �������,
--���������� ��� ������������ ���� - ��� ���� ������� ������,
--��������� ����������� ������������� ���� ������.

select keys.name as [������� ����],DOCH.name as [�������� �������], 
ROD.name as [������������ �������] 
from SYS.sysreferences as [table]
	join sysobjects as keys on constid = id
	join sysobjects as DOCH on keys.parent_obj = DOCH.id 
	join sysobjects as ROD on [table].rkeyid = ROD.id
	where KEYS.[uid] = (
	SELECT [uid] FROM sys.sysusers
	WHERE NAME = USER_NAME()
	)
----------------------------------------------------------


--������� �������� �������������, SQL-������, ��������� ��� ������������� -
-- ��� ���� �������������,
--��������� ����������� ������������� ���� ������



select tab2.name AS [�������������], tab1.[text] AS [������] 
from syscomments as tab1
	join sysobjects as tab2 on tab1.id = tab2.id
	where tab2.xtype = 'V' AND
	 TAB2.[uid] = (
	 SELECT [uid] FROM sys.sysusers
	WHERE NAME = USER_NAME()
	)



--������� �������� ��������, ��� �������, ��� ������� 
--��������� ������� - ��� ���� ���������, 
--��������� ����������� ������������� ���� ������


--1 �������
select tab1.name AS [�������],tab2.name AS [������a] 
from sys.triggers as tab1 
	join sysobjects as tab2 on tab1.parent_id = tab2.id
	where TAB2.[uid] = (SELECT [uid] FROM sys.sysusers
	WHERE NAME = user_name())


--2 �������
select tab2.name AS [�������],tab2.name AS [������a] 
from syscomments as tab1
	join sysobjects as tab2 on tab1.id = tab2.id
	where tab2.xtype = 'TR' AND
	TAB2.[uid] = (SELECT [uid] FROM sys.sysusers
	WHERE NAME = user_name())
--------------------------------------------------------
select * from INFORMATION_SCHEMA.COLUMNS