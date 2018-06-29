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
    'ateam', '����Ƽ��'
);
insert into teamz(
    team_id, team_name
)
values(
    'hteam', '�Ƹ����׽�'
);
insert into teamz(
    team_id, team_name
)
values(
    'cteam', '������'
);
insert into teamz(
    team_id, team_name
)
values(
    'steam', '�����'
);

	
--ateam
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a1','ateam','����',34,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a2','ateam','����',35,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a3','ateam','����',21,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a4','ateam','����',29,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('a5','ateam','����',25,'����');

--hteam
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h1','hteam','����',26,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h2','hteam','����',26,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h3','hteam','�ܾ�',26,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h4','hteam','���',30,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('h5','hteam','��',27,'����');

--cteam
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c1','cteam','������',32,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c2','cteam','��ȣ',31,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c3','cteam','����',29,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c4','cteam','����',23,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('c5','cteam','����',30,'����');

--steam
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s1','steam','��ȣ',27,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s2','steam','����',26,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s3','steam','�̽�',29,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s4','steam','����',26,'����');
insert into teamw( mem_id, team_id, mem_name, mem_age,roll)
values('s5','steam','����',30,'����');