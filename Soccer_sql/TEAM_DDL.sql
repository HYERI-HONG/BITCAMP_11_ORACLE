select * from tab;
drop table teamw;
drop table teamz;
--drop foreign key 

ALTER TABLE teamw ADD CONSTRAINT teamz_fk_team_id
	FOREIGN KEY(team_id) REFERENCES teamz(team_id);


create table teamz(
    team_id VARCHAR2(20) PRIMARY KEY,
    team_name VARCHAR2(20)
);

create table teamw(
    mem_id varchar2(20) PRIMARY KEY,
    team_id varchar2(20),
    mem_name varchar2(20),
    mem_age DECIMAL,
    roll varchar2(20)
);

insert into teamz(
    team_id, team_name
)
values(
    'ateam', 'Àú½ºÆ¼½º'
);
insert into teamz(
    team_id, team_name
)
values(
    'hteam', '¾Æ¸¶Á¶³×½º'
);
insert into teamz(
    team_id, team_name
)
values(
    'cteam', '°¡¿À°¶'
);
insert into teamz(
    team_id, team_name
)
values(
    'steam', '¾îº¥Á®½º'
);

	
--ateam
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a1','ateam','ÇüÁØ',34,'ÆÀÀå');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a2','ateam','¼¼ÀÎ',35,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a3','ateam','ÈñÅÂ',21,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a4','ateam','»óÈÆ',29,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a5','ateam','ÅÂÇü',25,'ÆÀ¿ø');

--hteam
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h1','hteam','Çý¸®',26,'ÆÀÀå');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h2','hteam','ÁöÀº',26,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h3','hteam','´Ü¾Æ',26,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h4','hteam','Àç°æ',30,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h5','hteam','ÁØ',27,'ÆÀ¿ø');

--cteam
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c1','cteam','ÃÖÁ¤ÈÆ',32,'ÆÀÀå');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c2','cteam','À±È£',31,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c3','cteam','°¡Àº',29,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c4','cteam','Á¤ÈÆ',23,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c5','cteam','½ÂÅÂ',30,'ÆÀ¿ø');

--steam
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s1','steam','½ÂÈ£',27,'ÆÀÀå');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s2','steam','¼ÒÁø',26,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s3','steam','ÀÌ½½',29,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s4','steam','ÁøÅÂ',26,'ÆÀ¿ø');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s5','steam','´©¸®',30,'ÆÀ¿ø');