SELECT
matriculas.data_matricula,
CASE
   WHEN turmas.tipo <= 1 THEN turmas.nome_qualificacao
	WHEN turmas.tipo >= 2 THEN turmas.nome_curso
END AS Curso,
escolas.nome,
alunos.nome,
alunos.cpf,
alunos.cadunico,
CASE
   WHEN alunos.psocial_beneficiario = 1 THEN 'SIM'
	WHEN alunos.psocial_beneficiario = 0 THEN 'NÃO'
END AS Possui_prog_social,
CASE
	WHEN alunos.psocial_esfera = 0 THEN 'NENHUM'
	WHEN alunos.psocial_esfera = 1 THEN 'FEDERAL'
	WHEN alunos.psocial_esfera = 2 THEN 'ESTADUAL'
	WHEN alunos.psocial_esfera = 3 THEN 'MUNICIPAL'
END AS Esfera_Programa,
CASE
	WHEN alunos.psocial_programa = 0 THEN 'NENHUM'
	WHEN alunos.psocial_programa = 1 THEN 'PROGRAMA GOIAS SOCIAL'
	WHEN alunos.psocial_programa = 2 THEN 'BOLSA UNIVERSITÁRIA'
	WHEN alunos.psocial_programa = 3 THEN 'BOLSA FAMÍLIA'
	WHEN alunos.psocial_programa = 4 THEN 'AUXÍLIO EMERGENCIAL'
	WHEN alunos.psocial_programa = 5 THEN 'FUNDO PROTEGE'
	WHEN alunos.psocial_programa = 6 THEN 'OUTRO'
	WHEN alunos.psocial_programa = 7 THEN 'PROGRAMA COTEC SOCIAL'
END AS NomeProgramaSocial,
alunos.psocial_outro_programa

FROM matriculas
LEFT JOIN alunos
ON	matriculas.id_alunos = alunos.id
LEFT JOIN turmas_fics_professores
ON matriculas.id_turmas_fics_professores = turmas_fics_professores.id
LEFT JOIN turmas_fics
ON turmas_fics_professores.id_turmas_fics = turmas_fics.id
LEFT JOIN turmas
ON turmas_fics.id_turmas = turmas.id
LEFT JOIN escolas
ON turmas.id_escolas = escolas.id

WHERE matriculas.data_matricula BETWEEN '2022-01-01' AND '2022-04-30'
