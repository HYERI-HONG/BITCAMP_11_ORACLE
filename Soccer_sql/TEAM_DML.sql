
--group by�� �̿��ؼ� �հ�, ���, �ִ�, �ּ� ���ϱ�
select
   (select m.team_name
   from teamz m
   where m.team_id like w.team_id) ����,
    count(w.team_id) ������,
    sum(w.mem_age) ������,
    max(w.mem_age) �����ִ�ġ,
    min(w.mem_age) �����ּ�ġ,
    avg(w.mem_age) �������
from teamw w
group by w.team_id
;

--���� column�� ����, ���� �Է��ϱ�
select * from teamw;

--�÷� ����
update teamw set roll ='';

--�÷��� member id������ ����, ���� �Է��ϱ�
update teamw set roll =
 case
    when mem_id like 'a1' then '����'
    when mem_id like 'h1' then '����'
    when mem_id like 'c1' then '����'
    when mem_id like 's1' then '����'
    else '����'
end
;
select * from subject;

select * from team;