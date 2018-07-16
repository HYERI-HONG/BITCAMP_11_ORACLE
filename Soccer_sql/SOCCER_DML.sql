--1
select count(*) AS "���̺��� ��"
from tab;

--2
select team_name
"��ü �౸�� ���"
from team
order by team_name
;

--3
--������ ����(�ߺ�����,������ �������� ����)
select distinct
nvl2(position,position,'����') "������"
from player;

--4
--������(ID: K02)��Ű��
select player_name "�̸�"
from player
where team_id ='K02'
    and position = 'GK'
order by player_name
;   

--5
--������(ID: K02) && Ű�� 170 �̻� ���� && ���� ��
select player_name "�̸�", position "������"
from player
where team_id like 'K02'
    and height >= 170
    and player_name like '��%'
order by player_name
;  

--6
--������(ID: K02) ������ �̸�,
--Ű�� ������ ����Ʈ (���� cm �� kg ����)
--Ű�� �����԰� ������ "0" ǥ��
--Ű ��������
select player_name || '����' �̸�,
    nvl2(height,height,'0') || 'cm' Ű,
    nvl2(weight,weight,'0') || 'kg' ������
from player
where team_id like 'K02'
order by height desc
;

--7
--������(ID: K02) ������ �̸�,
--Ű�� ������ ����Ʈ (���� cm �� kg ����)
--Ű�� �����԰� ������ "0" ǥ��
-- MI����
--Ű ��������
--BMI = ������ / Ű�� �μ�, ���⼭ �����Դ� kg, Ű�� m �����̴�. 
--���� ���ڸ�, ������ 55kg�� Ű 1.68m�� 
--����� BMI�� 55kg/(1.68m)^2 = 19.4�̴�
select player_name ||'����' �̸�,
    nvl2(height,height,'0') ||'cm' Ű,
    nvl2(weight,weight,'0') ||'kg' ������,
    round(weight/power((height/100),2),2) BMI������
from player
where team_id like 'K02'
order by height desc
;  

--8
--������(ID: K02) �� ������(ID: K10)������ �� ��
--GK �������� ����
--����, ����� ��������
select
    t.team_name,
    p.position,
    p.player_name
from player p
inner join team t
on t.team_id like p.team_id
where t.team_id in('K02', 'K10')
    and p.position like 'GK'
order by t.team_name, p.player_name
;

--9
--������(ID: K02) �� ������(ID: K10)������ �� ��
--Ű�� 180 �̻� 183 ������ ������
--Ű, ����, ����� ��������
select p.height||'cm' Ű,
       t.team_name ����,
       p.player_name �̸�
from player p
join team t
on t.team_id like p.team_id
where t.team_id in('K02', 'K10')
    and height between 180 and 183
order by height,team_name,player_name
;

--10
--��� ������ ��
--�������� �������� ���� �������� ���� �̸�
--����, ����� ��������
select t.team_name ����,
       p.player_name �̸�
from player p
inner join team t
on t.team_id like p.team_id
where p.position is null
order by p.player_name,t.team_name
;

--11
--���� ��Ÿ����� �����Ͽ�
--���̸�, ��Ÿ��� �̸� ���
select 
    t.team_name,
    s.stadium_name
from team t
    join stadium s
        on t.stadium_id like s.stadium_id
order by t.team_name, s.stadium_name
;  

--12 
--���� ��Ÿ���, �������� �����Ͽ�
--2012�� 3�� 17�Ͽ� ���� �� �����
--���̸�, ��Ÿ���, ������� �̸� ���
--�������̺� join �� ã�Ƽ� �ذ��Ͻÿ�.

select 
    t.team_name ����,
    m.stadium_name ��Ÿ���,
    s.awayteam_id ������ID,
    s.sche_date �����ٳ�¥
from stadium m
    join team t 
        on t.stadium_id like m.stadium_id
    join schedule s 
        on m.stadium_id like s.stadium_id
where s.SCHE_DATE in(select sche_date from schedule where sche_date like '20120317')
order by t.team_name
;

--13
--2012�� 3�� 17�� ��⿡
--���� ��ƿ���� �Ҽ� ��Ű��(GK)
--����, ������,���� (����������),
--��Ÿ���, ��⳯¥�� ���Ͻÿ�
--�������� ���̸��� ������ ���ÿ�
select 
    p.player_name ������,
    p.position ������,
    '���� ' || t.team_name ����,
    m.stadium_name ��Ÿ���,
    s.sche_date �����ٳ�¥
from player p
    join team t 
        on p.team_id like t.team_id
        join stadium m
            on t.stadium_id like m.stadium_id
                join schedule s
                    on m.stadium_id like s.stadium_id
where t.team_id in(select team_id from team where team_id like 'K03')
    and p.position in(select position from player where position like 'GK')
    and s.SCHE_DATE in(select sche_date from schedule where sche_date like '20120317')
order by p.player_name
;

--14
--Ȩ���� 3���̻� ���̷� �¸��� �����
--����� �̸�, ��� ����
--Ȩ�� �̸��� ������ �̸���
--���Ͻÿ�
select 
    m.stadium_name ��Ÿ���,
    s.sche_date ��⳯¥,
    t.region_name||' '||t.team_name Ȩ��,
    a.region_name||' '||a.team_name ������,
    s.home_score "Ȩ�� ����",
    s.away_score "������ ����"
from schedule s
    join stadium m
        on s.stadium_id like m.stadium_id
    join team t
        on t.team_id like s.hometeam_id
    join team a
        on a.team_id like s.awayteam_id
where s.home_score >= s.away_score+3
order by s.sche_date
;

--15
--STADIUM �� ��ϵ� ��� �߿���
--Ȩ���� ���� �������� ���� ��������
--ī��Ʈ ���� 20 , 
select 
    m.stadium_name,
    m.stadium_id,
    m.seat_count,
    m.hometeam_id,
    t.e_team_name
from stadium m
    left join team t
        on m.stadium_id like t.STADIUM_ID
order by hometeam_id
;
--16
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����

--16/UNION VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02'
UNION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K07'
;
--16/OR VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02' 
    OR T.TEAM_ID LIKE 'K07'
;
--16/IN VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02', 'K07')
;
    
--17
--�Ҽ��� �Ｚ ������� ���� �������
--���� �巡�������� �������� ���� ����
--���������̿�
select
    t.team_name ����,
    p.player_name ������,
    p.position ������,
    p.back_no ��ѹ�,
    p.height Ű
from player p
    join team t
        on p.team_id like t.team_id
where
    t.team_id in(
    select t.team_id
    from team t
    where t.team_name in ('�Ｚ�������','�巡����')
    )
;

--18
--��ȣ�� ������ �Ҽ����� ������, ��ѹ�
select 
    t.team_name �Ҽ���,
    p.position ������,
    p.back_no ��ѹ�
from player p
    join team t
        on p.team_id like t.team_id
where 
    p.player_name like (
    select y.player_name 
    from player y
    where y.player_name like '��ȣ��')
;

--19
--������Ƽ���� MF ���Ű
select 
    round(avg(p.height),2) ���Ű
from player p
    join team t
        on p.team_id like t.team_id
where p.position in(
    select p.position
    from player p
    where p.position like 'MF')
    and t.team_name like '��Ƽ��'
;

--20
--2012�� ���� ����
select
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201201'
        ) JAN,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201202'
        ) FEB,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201203'
        ) MAR,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201204'
        ) APR,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201205'
        ) MAY,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201206'
        ) JUN,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201207'
        ) JUL,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201208'
        ) AUG,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201209'
        ) SEP,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201210'
        ) OCT,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201211'
        ) NOV,
        (select count(*)
        from schedule s
        where 
            substr(s.sche_date,0,6) like '201212'
        ) DEC
        from DUAL
;



--21
--2012�� ���� ����� ����(GUBUN IS YES)�� ���Ͻÿ�
--����� 1��:20���
select
  (select
  count(*) 
from schedule 
where sche_date like '201201%')||'���' "1��",
   (select
   count(*)    
from schedule 
where sche_date like '201202%')||'���' "2��",
(select
  count(*) 
from schedule 
where sche_date like '201203%')||'���' "3��",

(select
  count(*) 
from schedule 
where sche_date like '201204%')||'���' "4��",

(select
  count(*) 
from schedule 
where sche_date like '201205%')||'���' "5��",

(select
  count(*) 
from schedule 
where sche_date like '201206%')||'���' "6��",

(select
  count(*) 
from schedule 
where sche_date like '201207%')||'���' "7��",

(select
  count(*) 
from schedule 
where sche_date like '201208%')||'���' "8��",

(select
  count(*) 
from schedule 
where sche_date like '201209%')||'���' "9��",

(select
  count(*) 
from schedule 
where sche_date like '201210%')||'���' "10��",

(select
  count(*) 
from schedule 
where sche_date like '201211%')||'���' "11��",

(select
  count(*) 
from schedule 
where sche_date like '201212%')||'���' "12��"

from dual
;


--22 
--2012�� 9�� 14�Ͽ� ������ ���� ���� ����Դϱ�?
--Ȩ�� :  /������ :
select 
    t1.team_name Ȩ��,
    t2.team_name ������
from schedule s
    join team t1
        on s.hometeam_id like t1.team_id
    join team t2
        on s.awayteam_id like t2.team_id 
where s.sche_date like '20120914'
;

    
--23
--Group by ���
--���� ������ ��
--������ũ 20��
--�巡���� 19��

select 
    count(p.player_id)||'��' ������,
    t.team_name ����
from
    team t
    join player p
        on t.team_id like p.team_id
group by
    t.team_name
order by t.team_name
;

--23
--�ٸ� ����
select 
    count(p.player_id)||'��' ������,
    (select 
        a.team_name
    from 
        team a
    where
        a.team_id = t.team_id) ����
from
    team t
    join player p
        on t.team_id like p.team_id
group by
    t.team_id
order by t.team_id
;

--24
--������ ������ �ѱ� ���
select 
    player_name,
    position,
    case
        when position is null then '����'
        when position like 'GK' then '��Ű��'
        when position like 'DF' then '�����'
        when position like 'MF' then '�̵��ʴ�'
        when position like 'FW' then '���ݼ�'
        else position
    end ������
from 
    player
where
    team_id like 'K08'
order by position
;

--25 rownum�̿��ؼ� ��ȣ �ű��
select 
    ROWNUM "NO.",
    A.����,
    A.������,
    A.������,
    A.��ѹ�,
    A.Ű
from
(SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID    
WHERE 
    T.TEAM_ID like (
    select t.team_id
    from team t
    where t.team_name like '�Ｚ�������')
order by height desc
) a
;

--25
--rownum �̿��ؼ� ��ȣ �ű�� �� ���� ����
--�Ｚ �������� Ű������ ž10 ���
select 
    ROWNUM "NO.",
    a.*
from
(SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID    
WHERE 
    T.TEAM_ID like (
    select t.team_id
    from team t
    where t.team_name like '�Ｚ�������')
    and p.height IS NOT NULL
    --and count(p.height) like 10
    --and ROWNUM <=10
order by height desc
) a
where ROWNUM <=10
;

--25
--�Ｚ �������� Ű������ 11~20������ 
select 
    b.*
from
(select 
    ROWNUM n,
    a.*
from
(SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID    
WHERE 
    T.TEAM_ID like (
    select t.team_id
    from team t
    where t.team_name like '�Ｚ�������')
    and p.height IS NOT NULL
order by height desc
) a) b
where b.N between 11 and 20
;

--26
--���� ������� ��� Ű����
--���� ���Ű�� ū ���� ���
select
    ROWNUM "NO.",
    a.*
from (select 
    (select ta.team_name
    from team ta
    where t.team_id like ta.team_id) ����
from player p
    join team t
        on p.team_id like t.team_id
where p.position like 'GK'
group by t.team_id
order by AVG(p.height) desc) a
where rownum <= 1
;

--27
--�� ���ܺ� ������ ���Ű�� �Ｚ �����������
--���Ű���� ���� ���� �̸��� �ش� ���� ���Ű��
--���Ͻÿ�

select 
    (select tb.team_name
    from team tb
    where tb.team_id like t.team_id) ����,
    round(avg(p.height),2) ���Ű 
from player p
    join team t
        on p.team_id like t.team_id
group by t.team_id
having avg(p.height)<(
        select avg(pa.height)
        from player pa
            join team ta
                on pa.team_id like ta.team_id
        where ta.team_name like '�Ｚ�������')
;

--28
--2012�� ����߿��� �������� ���� ū ��� ����


select
    rownum n,
    a.*
from(
select 
    ta.team_name ������,
    th.team_name Ȩ��,
    s.sche_date ��⳯¥
from schedule s
    join team th
        on th.team_id like s.hometeam_id
        join team ta
            on ta.team_id like s.awayteam_id
where s.sche_date like '2012%'
    and (s.home_score-s.away_score) is not null
order by abs(s.home_score-s.away_score) desc) a
where rownum <2
;

--28 �� ���� ����
SELECT A.*
FROM(SELECT
        K.SCHE_DATE ��⳯¥,
        HT.TEAM_NAME || ' VS ' || AT.TEAM_NAME ���,
        CASE
            WHEN K.HOME_SCORE >= K.AWAY_SCORE THEN (K.HOME_SCORE - K.AWAY_SCORE)
            ELSE K.AWAY_SCORE - K.HOME_SCORE
        END ������
     FROM
        SCHEDULE K
        JOIN TEAM HT
            ON K.HOMETEAM_ID LIKE HT.TEAM_ID
        JOIN TEAM AT
            ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
     WHERE
        K.SCHE_DATE LIKE '2012%'
        AND K.GUBUN LIKE 'Y'
    
     ORDER BY ������ DESC) A
WHERE ROWNUM LIKE 1
;

SELECT
        K.SCHE_DATE MATCHDATE,
        HT.TEAM_NAME || ' VS ' || AT.TEAM_NAME MATCH,
        CASE
            WHEN K.HOME_SCORE >= K.AWAY_SCORE THEN (K.HOME_SCORE - K.AWAY_SCORE)
            ELSE K.AWAY_SCORE - K.HOME_SCORE
        END SCOREGAP
     FROM
        SCHEDULE K
        JOIN TEAM HT
            ON K.HOMETEAM_ID LIKE HT.TEAM_ID
        JOIN TEAM AT
            ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
     WHERE
        K.SCHE_DATE LIKE '2012%'
        AND K.GUBUN LIKE 'Y'
    
     ORDER BY SCOREGAP DESC
     ;

--29
--�¼������ ��Ÿ��� ���� �ű��
select
    rownum "����",
    a.*
from 
(select s.stadium_name ��Ÿ���,
        s.seat_count �¼���
from stadium s
order by s.seat_count desc) a 
;

--30
--2012�� ���� �¸� ������ ���� �ű��
SELECT 
    A.WINNER,
    COUNT(A.WINNER) �¸�
FROM(SELECT
        K.SCHE_DATE ��⳯¥,
        CASE
            WHEN K.HOME_SCORE > K.AWAY_SCORE THEN HT.TEAM_NAME
            WHEN K.AWAY_SCORE > K.HOME_SCORE THEN AT.TEAM_NAME
            ELSE '���º�'
        END WINNER
     FROM SCHEDULE K
            JOIN TEAM HT
                ON K.HOMETEAM_ID LIKE HT.TEAM_ID
            JOIN TEAM AT
                ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
     WHERE
        K.GUBUN LIKE 'Y'
        AND K.SCHE_DATE LIKE '2012%'
    )A
WHERE A.WINNER NOT LIKE '���º�'
GROUP BY A.WINNER
ORDER BY �¸� DESC
;



    
   







                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              







