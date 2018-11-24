--выбрать имена всех таблиц,  назначенным пользователем базы данных 


SELECT t.NAME 
FROM SYS.sysobjects as t
	WHERE [xtype] = 'U' AND 
	t.NAME != 'sysdiagrams' and
	t.[uid] = (
	SELECT [uid] FROM sys.sysusers
	WHERE NAME = USER_NAME()
	)
----------------------------------------------------------------------
	

--выбрать имя таблицы, имя столбца таблицы, признак того, допускает ли 
--данный столбец null-значения, название типа данных столбца таблицы,
--размер этого типа данных - для всех таблиц, созданных назначенным
-- пользователем базы данных и всех их столбцов 



select  A.name ,col.name, col.isnullable,tip.name, tip.length as [размер]
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
	

--выбрать название ограничения целостности (первичные и внешние ключи), имя таблицы,
--в которой оно находится, признак того, что это за ограничение 
--('PK' для первичного ключа и 'F' для внешнего) - для всех ограничений целостности, 
--созданных назначенным пользователем базы данных


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



--выбрать название внешнего ключа, имя таблицы, содержащей внешний ключ, имя таблицы,
--содержащей его родительский ключ - для всех внешних ключей,
--созданных назначенным пользователем базы данных.

select keys.name as [внешний ключ],DOCH.name as [дочерняя таблица], 
ROD.name as [родительская таблица] 
from SYS.sysreferences as [table]
	join sysobjects as keys on constid = id
	join sysobjects as DOCH on keys.parent_obj = DOCH.id 
	join sysobjects as ROD on [table].rkeyid = ROD.id
	where KEYS.[uid] = (
	SELECT [uid] FROM sys.sysusers
	WHERE NAME = USER_NAME()
	)
----------------------------------------------------------


--выбрать название представления, SQL-запрос, создающий это представление -
-- для всех представлений,
--созданных назначенным пользователем базы данных



select tab2.name AS [ПРЕДСТАВЛЕНИЕ], tab1.[text] AS [ЗАПРОС] 
from syscomments as tab1
	join sysobjects as tab2 on tab1.id = tab2.id
	where tab2.xtype = 'V' AND
	 TAB2.[uid] = (
	 SELECT [uid] FROM sys.sysusers
	WHERE NAME = USER_NAME()
	)



--выбрать название триггера, имя таблицы, для которой 
--определен триггер - для всех триггеров, 
--созданных назначенным пользователем базы данных


--1 ВАРИАНТ
select tab1.name AS [триггер],tab2.name AS [таблицa] 
from sys.triggers as tab1 
	join sysobjects as tab2 on tab1.parent_id = tab2.id
	where TAB2.[uid] = (SELECT [uid] FROM sys.sysusers
	WHERE NAME = user_name())


--2 ВАРИАНТ
select tab2.name AS [триггер],tab2.name AS [таблицa] 
from syscomments as tab1
	join sysobjects as tab2 on tab1.id = tab2.id
	where tab2.xtype = 'TR' AND
	TAB2.[uid] = (SELECT [uid] FROM sys.sysusers
	WHERE NAME = user_name())
--------------------------------------------------------
select * from INFORMATION_SCHEMA.COLUMNS