SELECT
alunos.id,
alunos.nome AS 'NomeAluno',
matriculas.data_matricula AS 'DataMatricula',
	   case
	     when matriculas.status = 0 then 'MATRICULADO'
	     when matriculas.status = 1 then 'CANCELADO'
	     when matriculas.status = 2 then 'DESISTENTE'
	     when matriculas.status = 3 then 'EVADIDO'
	     when matriculas.status = 4 then 'CONCLUIDO'
	     when matriculas.status = 5 then 'FALECIDO'
	     when matriculas.status = 6 then 'ABANDONO'
	     when matriculas.status = 7 then 'TRANSFERIDO'
	     when matriculas.status = 8 then 'TRANCADO'
	   end AS 'Status Matricula',
	   matriculas.id_turmas_fics_professores,
	   turmas_fics.nome_fic AS 'NomeComponente',
	   turmas_fics.carga_hr AS 'CHComponente',
	    
		(select coalesce(sum(diario.duracao) / 60, 0)
		  from diario_frequencia
		  left join matriculas on (matriculas.id = diario_frequencia.id_matriculas)
		  left join diario on (diario.id = diario_frequencia.id_diario)
		  left join turmas_fics_professores on (turmas_fics_professores.id = diario.id_turmas_fics_professores)
		 where turmas_fics_professores.id_turmas_fics = turmas_fics.id
		 group by matriculas.id_alunos
		 order by 1 desc
		 limit 1) AS 'C.HExecutadaComponente',
	   
	   matriculas.r_freq AS 'Freq.Componente',
	   matriculas.r_media AS 'NotaComponente',
	   matriculas.r_fic AS 'ResultadoComponente',
	   matriculas.r_turma AS 'ResultadoTurma',
	   
	   
	   case
      	when turmas.tipo <= 1 then turmas.nome_qualificacao
        	when turmas.tipo >= 2 then turmas.nome_curso
   	end as Curso,
		turmas.nome AS 'CodigoSIGA',
   	case
      	when turmas.tipo = 0 then 'CAPACITACAO'
      	when turmas.tipo = 1 then 'QUALIFICACAO'
      	when turmas.tipo = 2 then 'CURSO TECNICO'
      	when turmas.tipo = 3 then 'CURSO SUPERIOR'
   	end as Categoria,
   	case
      	when turmas.`status` = 0 then 'ABERTO'
      	when turmas.`status` = 1 then 'EM ANDAMENTO'
      	when turmas.`status` = 2 then 'CONCLUIDO'
	 		when turmas.`status` = 3 then 'CANCELADO'
   	end AS 'StatusTurma',
   	turmas.data_inicio,
   	turmas.data_fim
	   
	   FROM matriculas
	   LEFT JOIN alunos
	   ON (matriculas.id_alunos = alunos.id)	   
	   LEFT	JOIN turmas_fics_professores
	   ON	(matriculas.id_turmas_fics_professores=turmas_fics_professores.id)	   
	   LEFT	JOIN	turmas_fics
	   ON	(turmas_fics_professores.id_turmas_fics = turmas_fics.id)
	   LEFT	JOIN	turmas
	   ON (turmas_fics.id_turmas=turmas.id)
	   
	   WHERE turmas.data_inicio BETWEEN '2022-01-01' AND '2022-04-25'	