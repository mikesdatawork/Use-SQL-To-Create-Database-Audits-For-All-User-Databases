use master;
set nocount on
 
declare @create_db_audits varchar(max)
set @create_db_audits = ''
select @create_db_audits = @create_db_audits + 'use [' + name + '];' + char(10) +
'create database audit specification [UserAccessAudit_' + name + ']' + char(10) + 'for server audit [MyServerAuditName]' + char(10) +
'add (select, insert, update, delete, execute, receive, references on database::' + name + ' by public)' + char(10) + 'with (state = on);' + char(10) + char(10)
from sys.databases where name not in ('master', 'model', 'msdb', 'tempdb')
 
exec (@create_db_audits) --for xml path(''), type
