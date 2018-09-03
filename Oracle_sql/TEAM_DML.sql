
--group by를 이용해서 합계, 평균, 최대, 최소 구하기
select
   (select m.team_name
   from teamz m
   where m.team_id like w.team_id) 팀명,
    count(w.team_id) 팀원수,
    sum(w.mem_age) 나이합,
    max(w.mem_age) 나이최대치,
    min(w.mem_age) 나이최소치,
    avg(w.mem_age) 나이평균
from teamw w
group by w.team_id
;

--역할 column에 팀장, 팀원 입력하기
select * from teamw;

--컬럽 비우기
update teamw set roll ='';

--컬럼에 member id값으로 팀장, 팀원 입력하기
update teamw set roll =
 case
    when mem_id like 'a1' then '팀장'
    when mem_id like 'h1' then '팀장'
    when mem_id like 'c1' then '팀장'
    when mem_id like 's1' then '팀장'
    else '팀원'
end
;
select * from subject;

select * from team;