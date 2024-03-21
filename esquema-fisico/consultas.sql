--CONSULTA COM GROUP BY/HAVING
--Nome dos enfermeiros que atendem mais de 1 paciente
select f.nome
from funcionario f inner join atende a on f.cpf = a.cpf_enfermeiro
group by f.nome
having count(*) > 1;

--CONSULTA COM JUNÇÃO INTERNA
--Nome dos receptores que receberam sangue com antigeno A
select r.nome
from receptor r inner join sangue_bom s on r.cpf = s.cpf_receptor
where s.antigeno_a = '1';

--CONSULTA COM JUNÇÃO EXTERNA
--CPF de todos os técnicos e seus respectivos sangues analisados
select t.cpf, s.cpf_doador, s.data_doacao
from tecnico_laboratoria t left outer join sangue_doado s on t.cpf = s.cpf_tecnico;

--CONSULTA COM SEMI-JOIN
--Nome dos receptores que receberam sangue com fator RH negativo
select r.nome
from receptor r
where r.cpf in (select s.cpf_receptor 
                from sangue_bom s 
                where s.fator_rh = '-');

--CONSULTA COM ANTI-JOIN
--Nome dos receptores que não receberam sangue
select r.nome
from receptor r
where not exists (select * 
                  from sangue_bom s 
                  where r.cpf = s.cpf_receptor);