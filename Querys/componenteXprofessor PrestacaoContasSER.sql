SELECT
	programas.nome AS Programa,
	escolas.nome AS Equipamento_Publico,
	CASE
      WHEN MONTH(turmas.data_inicio) = 1  then 'JANEIRO'
      WHEN MONTH(turmas.data_inicio) = 2  then 'FEVEREIRO'
      WHEN MONTH(turmas.data_inicio) = 3  then 'MARÇO'
      WHEN MONTH(turmas.data_inicio) = 4  then 'ABRIL'
      WHEN MONTH(turmas.data_inicio) = 5  then 'MAIO'
      WHEN MONTH(turmas.data_inicio) = 6  then 'JUNHO'
      WHEN MONTH(turmas.data_inicio) = 7  then 'JULHO'
      WHEN MONTH(turmas.data_inicio) = 8  then 'AGOSTO'
      WHEN MONTH(turmas.data_inicio) = 9  then 'SETEMBRO'
      WHEN MONTH(turmas.data_inicio) = 10 then 'OUTUBRO'
      WHEN MONTH(turmas.data_inicio) = 11 then 'NOVEMBRO'
      WHEN MONTH(turmas.data_inicio) = 12 then 'DEZEMBRO'
   END AS Mes_oferta,
   turmas.modalidade,
   CASE
      WHEN turmas.tipo = 0 THEN 'CAPACITACAO'
      WHEN turmas.tipo = 1 THEN 'QUALIFICACAO'
      WHEN turmas.tipo = 2 THEN 'CURSO TECNICO'
      WHEN turmas.tipo = 3 THEN 'CURSO SUPERIOR'
   END AS categoria,
   eixos.nome AS Eixo_Tecnologico,
   CASE
      WHEN turmas.tipo <= 1 THEN turmas.nome_qualificacao
      WHEN turmas.tipo >= 2 THEN turmas.nome_curso
   END AS Curso,
   turmas.data_inicio,
   turmas.data_fim,
   turmas_fics.nome_fic AS Componente,
   turmas_fics.dt_inicial,
   turmas_fics.dt_final,
   CASE
      WHEN turmas_fics.status_fic = 0 then 'ABERTO'
      WHEN turmas_fics.status_fic = 1 then 'EM ANDAMENTO'
      WHEN turmas_fics.status_fic = 2 then 'CONCLUIDO'
	   WHEN turmas_fics.status_fic = 3 then 'CANCELADO'
   END AS status_comp,
   turmas_fics.carga_hr AS Carga_Horaria_Componente,
   (SELECT COALESCE(SUM(diario.duracao) / 60, 0)
		  FROM diario_frequencia
				LEFT JOIN matriculas
				ON (matriculas.id = diario_frequencia.id_matriculas)
		  		LEFT JOIN diario
				ON (diario.id = diario_frequencia.id_diario)
		  		LEFT JOIN turmas_fics_professores
				ON (turmas_fics_professores.id = diario.id_turmas_fics_professores)
		 		WHERE turmas_fics_professores.id_turmas_fics = turmas_fics.id
		 		GROUP BY matriculas.id_alunos
		 		ORDER BY 1 DESC
		 		LIMIT 1) AS carga_hr_exec,
	(turmas_fics.carga_hr -
	(SELECT COALESCE(SUM(diario.duracao) / 60, 0)
		  FROM diario_frequencia
				LEFT JOIN matriculas
				ON (matriculas.id = diario_frequencia.id_matriculas)
		  		LEFT JOIN diario
				ON (diario.id = diario_frequencia.id_diario)
		  		LEFT JOIN turmas_fics_professores
				ON (turmas_fics_professores.id = diario.id_turmas_fics_professores)
		 		WHERE turmas_fics_professores.id_turmas_fics = turmas_fics.id
		 		GROUP BY matriculas.id_alunos
		 		ORDER BY 1 DESC
		 		LIMIT 1)) AS Carga_Hr_A_Executar,
	turmas.turno,
	(SELECT professores.nome
      FROM turmas_fics_prof_equipe
      LEFT JOIN professores
		ON professores.id = turmas_fics_prof_equipe.id_professores
      LEFT JOIN turmas_fics_professores
		ON turmas_fics_professores.id = turmas_fics_prof_equipe.id_turmas_fics_professores
      WHERE turmas_fics_professores.id_turmas_fics = turmas_fics.id
   	ORDER BY turmas_fics_professores.id,
               turmas_fics_prof_equipe.id
      LIMIT 1) as professor_nome,
   (SELECT professores.cpf
   	FROM turmas_fics_prof_equipe
   	LEFT JOIN professores
   	ON professores.id = turmas_fics_prof_equipe.id_professores
   	LEFT JOIN turmas_fics_professores
   	ON turmas_fics_professores.id = turmas_fics_prof_equipe.id_turmas_fics_professores
   	WHERE	turmas_fics_professores.id_turmas_fics = turmas_fics.id
   	ORDER BY turmas_fics_professores.id,
   				turmas_fics_prof_equipe.id
   	LIMIT 1) AS professor_cpf
	
	FROM programas
	LEFT JOIN turmas
	ON	programas.id = turmas.id_programas
	LEFT JOIN escolas
	ON escolas.id = turmas.id_escolas
	LEFT JOIN turmas_fics
	ON turmas_fics.id_turmas = turmas.id
	LEFT JOIN eixos
	ON eixos.id = turmas_fics.id_eixos

	
		
	WHERE turmas.data_inicio BETWEEN '2022-07-01' AND '2022-09-01'