--1
select count(*) AS "테이블의 수"
from tab;

--2
select team_name
"전체 축구팀 목록"
from team
order by team_name
;

--3
--포지션 종류(중복제거,없으면 신입으로 기재)
select distinct
nvl2(position,position,'신입') "포지션"
from player;

--4
--수원팀(ID: K02)골키퍼
select player_name "이름"
from player
where team_id ='K02'
    and position = 'GK'
order by player_name
;   

--5
--수원팀(ID: K02) && 키가 170 이상 선수 && 성이 고씨
select player_name "이름", position "포지션"
from player
where team_id like 'K02'
    and height >= 170
    and player_name like '고%'
order by player_name
;  

--6
--수원팀(ID: K02) 선수들 이름,
--키와 몸무게 리스트 (단위 cm 와 kg 삽입)
--키와 몸무게가 없으면 "0" 표시
--키 내림차순
select player_name || '선수' 이름,
    nvl2(height,height,'0') || 'cm' 키,
    nvl2(weight,weight,'0') || 'kg' 몸무게
from player
where team_id like 'K02'
order by height desc
;

--7
--수원팀(ID: K02) 선수들 이름,
--키와 몸무게 리스트 (단위 cm 와 kg 삽입)
--키와 몸무게가 없으면 "0" 표시
-- MI지수
--키 내림차순
--BMI = 몸무게 / 키² 로서, 여기서 몸무게는 kg, 키는 m 단위이다. 
--예를 들자면, 몸무게 55kg에 키 1.68m인 
--사람의 BMI는 55kg/(1.68m)^2 = 19.4이다
select player_name ||'선수' 이름,
    nvl2(height,height,'0') ||'cm' 키,
    nvl2(weight,weight,'0') ||'kg' 몸무게,
    round(weight/power((height/100),2),2) BMI비만지수
from player
where team_id like 'K02'
order by height desc
;  

--8
--수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
--GK 포지션인 선수
--팀명, 사람명 오름차순
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
--수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
--키가 180 이상 183 이하인 선수들
--키, 팀명, 사람명 오름차순
select p.height||'cm' 키,
       t.team_name 팀명,
       p.player_name 이름
from player p
join team t
on t.team_id like p.team_id
where t.team_id in('K02', 'K10')
    and height between 180 and 183
order by height,team_name,player_name
;

--10
--모든 선수들 중
--포지션을 배정받지 못한 선수들의 팀과 이름
--팀명, 사람명 오름차순
select t.team_name 팀명,
       p.player_name 이름
from player p
inner join team t
on t.team_id like p.team_id
where p.position is null
order by p.player_name,t.team_name
;

--11
--팀과 스타디움을 조인하여
--팀이름, 스타디움 이름 출력
select 
    t.team_name,
    s.stadium_name
from team t
    join stadium s
        on t.stadium_id like s.stadium_id
order by t.team_name, s.stadium_name
;  

--12 
--팀과 스타디움, 스케줄을 조인하여
--2012년 3월 17일에 열린 각 경기의
--팀이름, 스타디움, 어웨이팀 이름 출력
--다중테이블 join 을 찾아서 해결하시오.

select 
    t.team_name 팀명,
    m.stadium_name 스타디움,
    s.awayteam_id 원정팀ID,
    s.sche_date 스케줄날짜
from stadium m
    join team t 
        on t.stadium_id like m.stadium_id
    join schedule s 
        on m.stadium_id like s.stadium_id
where s.SCHE_DATE in(select sche_date from schedule where sche_date like '20120317')
order by t.team_name
;

--13
--2012년 3월 17일 경기에
--포항 스틸러스 소속 골키퍼(GK)
--선수, 포지션,팀명 (연고지포함),
--스타디움, 경기날짜를 구하시오
--연고지와 팀이름은 간격을 띄우시오
select 
    p.player_name 선수명,
    p.position 포지션,
    '포항 ' || t.team_name 팀명,
    m.stadium_name 스타디움,
    s.sche_date 스케줄날짜
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
--홈팀이 3점이상 차이로 승리한 경기의
--경기장 이름, 경기 일정
--홈팀 이름과 원정팀 이름을
--구하시오
select 
    m.stadium_name 스타디움,
    s.sche_date 경기날짜,
    t.region_name||' '||t.team_name 홈팀,
    a.region_name||' '||a.team_name 원정팀,
    s.home_score "홈팀 점수",
    s.away_score "원정팀 점수"
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
--STADIUM 에 등록된 운동장 중에서
--홈팀이 없는 경기장까지 전부 나오도록
--카운트 값은 20 , 
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
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보

--16/UNION VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02'
UNION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K07'
;
--16/OR VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02' 
    OR T.TEAM_ID LIKE 'K07'
;
--16/IN VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02', 'K07')
;
    
--17
--소속이 삼성 블루윙즈 팀인 선수들과
--전남 드래곤즈팀인 선수들의 선수 정보
--서브쿼리이용
select
    t.team_name 팀명,
    p.player_name 선수명,
    p.position 포지션,
    p.back_no 백넘버,
    p.height 키
from player p
    join team t
        on p.team_id like t.team_id
where
    t.team_id in(
    select t.team_id
    from team t
    where t.team_name in ('삼성블루윙즈','드래곤즈')
    )
;

--18
--최호진 선수의 소속팀과 포지션, 백넘버
select 
    t.team_name 소속팀,
    p.position 포지션,
    p.back_no 백넘버
from player p
    join team t
        on p.team_id like t.team_id
where 
    p.player_name like (
    select y.player_name 
    from player y
    where y.player_name like '최호진')
;

--19
--대전시티즌의 MF 평균키
select 
    round(avg(p.height),2) 평균키
from player p
    join team t
        on p.team_id like t.team_id
where p.position in(
    select p.position
    from player p
    where p.position like 'MF')
    and t.team_name like '시티즌'
;

--20
--2012년 월별 경기수
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
--2012년 월별 진행된 경기수(GUBUN IS YES)를 구하시오
--출력은 1월:20경기
select
  (select
  count(*) 
from schedule 
where sche_date like '201201%')||'경기' "1월",
   (select
   count(*)    
from schedule 
where sche_date like '201202%')||'경기' "2월",
(select
  count(*) 
from schedule 
where sche_date like '201203%')||'경기' "3월",

(select
  count(*) 
from schedule 
where sche_date like '201204%')||'경기' "4월",

(select
  count(*) 
from schedule 
where sche_date like '201205%')||'경기' "5월",

(select
  count(*) 
from schedule 
where sche_date like '201206%')||'경기' "6월",

(select
  count(*) 
from schedule 
where sche_date like '201207%')||'경기' "7월",

(select
  count(*) 
from schedule 
where sche_date like '201208%')||'경기' "8월",

(select
  count(*) 
from schedule 
where sche_date like '201209%')||'경기' "9월",

(select
  count(*) 
from schedule 
where sche_date like '201210%')||'경기' "10월",

(select
  count(*) 
from schedule 
where sche_date like '201211%')||'경기' "11월",

(select
  count(*) 
from schedule 
where sche_date like '201212%')||'경기' "12월"

from dual
;


--22 
--2012년 9월 14일에 벌어질 경기는 어디와 어디입니까?
--홈팀 :  /원정팀 :
select 
    t1.team_name 홈팀,
    t2.team_name 원정팀
from schedule s
    join team t1
        on s.hometeam_id like t1.team_id
    join team t2
        on s.awayteam_id like t2.team_id 
where s.sche_date like '20120914'
;

    
--23
--Group by 사용
--팀별 선수의 수
--아이파크 20명
--드래곤즈 19명

select 
    count(p.player_id)||'명' 팀원수,
    t.team_name 팀명
from
    team t
    join player p
        on t.team_id like p.team_id
group by
    t.team_name
order by t.team_name
;

--23
--다른 버전
select 
    count(p.player_id)||'명' 팀원수,
    (select 
        a.team_name
    from 
        team a
    where
        a.team_id = t.team_id) 팀명
from
    team t
    join player p
        on t.team_id like p.team_id
group by
    t.team_id
order by t.team_id
;

--24
--선수들 포지션 한글 출력
select 
    player_name,
    position,
    case
        when position is null then '없음'
        when position like 'GK' then '골키퍼'
        when position like 'DF' then '수비수'
        when position like 'MF' then '미드필더'
        when position like 'FW' then '공격수'
        else position
    end 포지션
from 
    player
where
    team_id like 'K08'
order by position
;

--25 rownum이용해서 번호 매기기
select 
    ROWNUM "NO.",
    A.팀명,
    A.선수명,
    A.포지션,
    A.백넘버,
    A.키
from
(SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID    
WHERE 
    T.TEAM_ID like (
    select t.team_id
    from team t
    where t.team_name like '삼성블루윙즈')
order by height desc
) a
;

--25
--rownum 이용해서 번호 매기기 더 나은 버전
--삼성 블루윙즈에서 키순으로 탑10 출력
select 
    ROWNUM "NO.",
    a.*
from
(SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID    
WHERE 
    T.TEAM_ID like (
    select t.team_id
    from team t
    where t.team_name like '삼성블루윙즈')
    and p.height IS NOT NULL
    --and count(p.height) like 10
    --and ROWNUM <=10
order by height desc
) a
where ROWNUM <=10
;

--25
--삼성 블루윙즈에서 키순으로 11~20위까지 
select 
    b.*
from
(select 
    ROWNUM n,
    a.*
from
(SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID    
WHERE 
    T.TEAM_ID like (
    select t.team_id
    from team t
    where t.team_name like '삼성블루윙즈')
    and p.height IS NOT NULL
order by height desc
) a) b
where b.N between 11 and 20
;

--26
--팀별 골기퍼의 평균 키에서
--가장 평균키가 큰 팀명 출력
select
    ROWNUM "NO.",
    a.*
from (select 
    (select ta.team_name
    from team ta
    where t.team_id like ta.team_id) 팀명
from player p
    join team t
        on p.team_id like t.team_id
where p.position like 'GK'
group by t.team_id
order by AVG(p.height) desc) a
where rownum <= 1
;

--27
--각 구단별 선수를 평균키가 삼성 블루윙즈팀의
--평균키보다 작은 팀의 이름과 해당 팀의 평균키를
--구하시오

select 
    (select tb.team_name
    from team tb
    where tb.team_id like t.team_id) 팀명,
    round(avg(p.height),2) 평균키 
from player p
    join team t
        on p.team_id like t.team_id
group by t.team_id
having avg(p.height)<(
        select avg(pa.height)
        from player pa
            join team ta
                on pa.team_id like ta.team_id
        where ta.team_name like '삼성블루윙즈')
;

--28
--2012년 경기중에서 점수차가 가장 큰 경기 전부


select
    rownum n,
    a.*
from(
select 
    ta.team_name 원정팀,
    th.team_name 홈팀,
    s.sche_date 경기날짜
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

--28 더 나은 버전
SELECT A.*
FROM(SELECT
        K.SCHE_DATE 경기날짜,
        HT.TEAM_NAME || ' VS ' || AT.TEAM_NAME 경기,
        CASE
            WHEN K.HOME_SCORE >= K.AWAY_SCORE THEN (K.HOME_SCORE - K.AWAY_SCORE)
            ELSE K.AWAY_SCORE - K.HOME_SCORE
        END 점수차
     FROM
        SCHEDULE K
        JOIN TEAM HT
            ON K.HOMETEAM_ID LIKE HT.TEAM_ID
        JOIN TEAM AT
            ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
     WHERE
        K.SCHE_DATE LIKE '2012%'
        AND K.GUBUN LIKE 'Y'
    
     ORDER BY 점수차 DESC) A
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
--좌석수대로 스타디움 순서 매기기
select
    rownum "순위",
    a.*
from 
(select s.stadium_name 스타디움,
        s.seat_count 좌석수
from stadium s
order by s.seat_count desc) a 
;

--30
--2012년 구단 승리 순으로 순위 매기기
SELECT 
    A.WINNER,
    COUNT(A.WINNER) 승리
FROM(SELECT
        K.SCHE_DATE 경기날짜,
        CASE
            WHEN K.HOME_SCORE > K.AWAY_SCORE THEN HT.TEAM_NAME
            WHEN K.AWAY_SCORE > K.HOME_SCORE THEN AT.TEAM_NAME
            ELSE '무승부'
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
WHERE A.WINNER NOT LIKE '무승부'
GROUP BY A.WINNER
ORDER BY 승리 DESC
;



    
   







                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              







