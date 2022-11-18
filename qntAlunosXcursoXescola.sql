   SELECT   
		turmas.id,
		case
		   WHEN turmas.tipo <= 1 THEN turmas.nome_qualificacao
         WHEN turmas.tipo >= 2 THEN turmas.nome_curso
       END AS nomeCurso,
       turmas.nome,
       turmas.data_inicio,
       turmas.data_fim,
      turmas.id_escolas,
      case
      	when turmas.tipo = 0 then 'CAPACITACAO'
      	when turmas.tipo = 1 then 'QUALIFICACAO'
      	when turmas.tipo = 2 then 'CURSO TECNICO'
      	when turmas.tipo = 3 then 'CURSO SUPERIOR'
   	end as categoriaCurso,
      escolas.nome,
   	count(DISTINCT(matriculas.id_alunos)) AS qtde_matriculas
      from matriculas
         left join turmas_fics_professores on (turmas_fics_professores.id = matriculas.id_turmas_fics_professores)
         left join turmas_fics on (turmas_fics.id = turmas_fics_professores.id_turmas_fics)
         left join turmas on (turmas.id = turmas_fics.id_turmas)
         left join escolas on (turmas.id_escolas = escolas.id)
      where turmas.data_inicio between '2022-09-01' and '2022-12-30'
      group by turmas.id,
      turmas.id_escolas,
      turmas.tipo
      ORDER BY qtde_matriculas