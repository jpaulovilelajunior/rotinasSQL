SELECT
CASE
   WHEN turmas.tipo <= 1 THEN turmas.nome_qualificacao
	WHEN turmas.tipo >= 2 THEN turmas.nome_curso
END AS Curso,
(SELECT COALESCE(SUM(t_f.carga_hr), 0)
   FROM turmas_fics t_f
   WHERE t_f.id_turmas = turmas_fics.id_turmas) AS carga_hr_turma,
turmas.data_inicio,
turmas.data_fim,
turmas_fics.nome_fic AS 'Nome Componente',
turmas.codigo_turma AS 'Codigo SIGA',
turmas_fics.carga_hr,
turmas_fics.dt_inicial,
turmas_fics.dt_final,
CASE
   WHEN turmas.tipo = 0 then 'CAPACITACAO'
   WHEN turmas.tipo = 1 then 'QUALIFICACAO'
   when turmas.tipo = 2 then 'CURSO TECNICO'
   when turmas.tipo = 3 then 'CURSO SUPERIOR'
END AS categoriaCurso,
escolas.nome AS 'Nome Escola',
municipios.nome AS 'Nome Cidade',
(SELECT professores.nome
   FROM turmas_fics_prof_equipe
   LEFT JOIN professores
	ON professores.id = turmas_fics_prof_equipe.id_professores
   LEFT JOIN turmas_fics_professores
	ON turmas_fics_professores.id = turmas_fics_prof_equipe.id_turmas_fics_professores
   WHERE turmas_fics_professores.id_turmas_fics = turmas_fics.id
   ORDER BY turmas_fics_professores.id,
            turmas_fics_prof_equipe.id
   LIMIT 1) AS professor_nome,
(SELECT professores.cpf
   FROM turmas_fics_prof_equipe
   LEFT JOIN professores
	ON professores.id = turmas_fics_prof_equipe.id_professores
   LEFT JOIN turmas_fics_professores
	ON turmas_fics_professores.id = turmas_fics_prof_equipe.id_turmas_fics_professores
   WHERE turmas_fics_professores.id_turmas_fics = turmas_fics.id
   ORDER BY turmas_fics_professores.id,
            turmas_fics_prof_equipe.id
   LIMIT 1) AS professor_CPF,
(SELECT professores.fone
   FROM turmas_fics_prof_equipe
   LEFT JOIN professores
	ON professores.id = turmas_fics_prof_equipe.id_professores
   LEFT JOIN turmas_fics_professores
	ON turmas_fics_professores.id = turmas_fics_prof_equipe.id_turmas_fics_professores
   WHERE turmas_fics_professores.id_turmas_fics = turmas_fics.id
   ORDER BY turmas_fics_professores.id,
            turmas_fics_prof_equipe.id
   LIMIT 1) AS professor_telefone,
(SELECT professores.email
   FROM turmas_fics_prof_equipe
   LEFT JOIN professores
	ON professores.id = turmas_fics_prof_equipe.id_professores
   LEFT JOIN turmas_fics_professores
	ON turmas_fics_professores.id = turmas_fics_prof_equipe.id_turmas_fics_professores
   WHERE turmas_fics_professores.id_turmas_fics = turmas_fics.id
   ORDER BY turmas_fics_professores.id,
            turmas_fics_prof_equipe.id
   LIMIT 1) AS professor_email,
alunos.nome,
alunos.cpf,
alunos.email,
alunos.fone



FROM turmas
LEFT JOIN turmas_fics
ON turmas.id = turmas_fics.id_turmas
LEFT JOIN escolas
ON escolas.id = turmas.id_escolas
LEFT JOIN municipios
ON municipios.id = escolas.id_municipios
LEFT JOIN turmas_fics_professores
ON turmas_fics_professores.id_turmas_fics = turmas_fics.id
LEFT JOIN matriculas
ON turmas_fics_professores.id = matriculas.id_turmas_fics_professores
LEFT JOIN alunos
ON alunos.id = matriculas.id_alunos

WHERE
#turmas.modalidade = 'EAD'
turmas.nome_qualificacao LIKE '%ONL'
AND turmas.data_inicio >= '2022-09-13'
AND turmas.`status` IN (0,1,2,3)
AND escolas.id IN (48,46,54)

ORDER BY escolas.id,
			turmas.id,
			alunos.id
