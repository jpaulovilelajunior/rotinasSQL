SELECT
	alunos.id,
	alunos.data_cadastro,
	alunos.nome,
	alunos.cep,
	alunos.rg,
	alunos.titulo_eleitor,
	alunos.nome_mae,
	alunos.email,
	matriculas.data_matricula,
	turmas_fics.nome_fic,
   CASE
      WHEN turmas.tipo <= 1 THEN turmas.nome_qualificacao
      WHEN turmas.tipo >= 2 THEN turmas.nome_curso
   END AS curso,
   escolas.nome
	FROM alunos
	LEFT JOIN matriculas
	ON matriculas.id_alunos = alunos.id
	LEFT JOIN turmas_fics_professores
	ON turmas_fics_professores.id = matriculas.id_turmas_fics_professores
	LEFT JOIN turmas_fics
	ON turmas_fics.id = turmas_fics_professores.id_turmas_fics
	LEFT JOIN turmas
	ON turmas.id = turmas_fics.id_turmas
	LEFT JOIN escolas
	ON escolas.id = turmas.id_escolas
	WHERE alunos.data_cadastro > '2022-01-01'
		AND (LENGTH(alunos.cep) < 8
				OR alunos.rg = ''
				OR alunos.email = 'naotem@gmail.com'
				OR LENGTH(alunos.titulo_eleitor) < 12
				OR LENGTH(alunos.nome_mae)<3)