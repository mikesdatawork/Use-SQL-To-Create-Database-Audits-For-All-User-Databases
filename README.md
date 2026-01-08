![MIKES DATA WORK GIT REPO](https://raw.githubusercontent.com/mikesdatawork/images/master/git_mikes_data_work_banner_01.png "Mikes Data Work")        

# Use SQL To Create Database [Audits] For All User Databases
**Post Date: July 10, 2014**        



## Contents    
- [About Process](##About-Process)  
- [SQL Logic](#SQL-Logic)  
- [Author](#Author)  
- [License](#License)       

## About-Process

<p>So you have your SQL Audit setup which is cool, but now you want to capture all the SELECT, INSERT, UPDATE, DELETES, EXECUTES, etc..
( By the way if you're somewhat new at SQL Auditing ApexSQL has an excellent post about it here: http://solutioncenter.apexsql.com/sql-server-database-auditing-techniques/ )
You can use this little script to create a uniform audit capture across all the databases. If you want to see each individual audit configuration; all you need to do is change the last line to this: select (@create_db_audits) for xml path("), type</p>  


## SQL-Logic
```SQL
use master;
set nocount on
 
declare @create_db_audits varchar(max)
set @create_db_audits = ''
select @create_db_audits = @create_db_audits + 'use [' + name + '];' + char(10) +
'create database audit specification [UserAccessAudit_' + name + ']' + char(10) + 'for server audit [MyServerAuditName]' + char(10) +
'add (select, insert, update, delete, execute, receive, references on database::' + name + ' by public)' + char(10) + 'with (state = on);' + char(10) + char(10)
from sys.databases where name not in ('master', 'model', 'msdb', 'tempdb')
 
exec (@create_db_audits) --for xml path(''), type
```


[![WorksEveryTime](https://forthebadge.com/images/badges/60-percent-of-the-time-works-every-time.svg)](https://shitday.de/)

## Author

[![Gist](https://img.shields.io/badge/Gist-MikesDataWork-<COLOR>.svg)](https://gist.github.com/mikesdatawork)
[![Twitter](https://img.shields.io/badge/Twitter-MikesDataWork-<COLOR>.svg)](https://twitter.com/mikesdatawork)
[![Wordpress](https://img.shields.io/badge/Wordpress-MikesDataWork-<COLOR>.svg)](https://mikesdatawork.wordpress.com/)

     
## License
[![LicenseCCSA](https://img.shields.io/badge/License-CreativeCommonsSA-<COLOR>.svg)](https://creativecommons.org/share-your-work/licensing-types-examples/)

![Mikes Data Work](https://raw.githubusercontent.com/mikesdatawork/images/master/git_mikes_data_work_banner_02.png "Mikes Data Work")

