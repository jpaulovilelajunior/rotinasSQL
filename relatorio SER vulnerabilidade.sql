SELECT
eixos.nome as eixo,
turmas.modalidade AS modalidade,
CASE
   WHEN turmas.tipo = 0 THEN 'CAPACITACAO'
   WHEN turmas.tipo = 1 THEN 'QUALIFICACAO'
   WHEN turmas.tipo = 2 THEN 'CURSO TECNICO'
   WHEN turmas.tipo = 3 THEN 'CURSO SUPERIOR'
END AS categoria,                       
CASE
	WHEN turmas.tipo <= 1 THEN turmas.nome_qualificacao
   WHEN turmas.tipo >= 2 THEN turmas.nome_curso
END AS curso,
turmas.nome,
turmas_fics.nome_fic AS 'Componentes',
alunos.nome AS 'Nomes_Alunos',
alunos.cpf,
alunos.endereco,
alunos.cadunico,
CASE
	WHEN alunos.origem = 0 THEN 'REDE PÚBLICA'
	WHEN alunos.origem = 1 THEN 'REDE PRIVADA'
END AS Origem,
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
END AS NomeProgramaSocial

FROM matriculas
LEFT JOIN alunos
ON alunos.id = matriculas.id_alunos
LEFT JOIN turmas_fics_professores
ON turmas_fics_professores.id = matriculas.id_turmas_fics_professores
LEFT JOIN turmas_fics
ON turmas_fics.id = turmas_fics_professores.id_turmas_fics
LEFT JOIN turmas
ON turmas.id = turmas_fics.id_turmas
LEFT JOIN eixos
ON eixos.id = turmas_fics.id_eixos

WHERE alunos.psocial_beneficiario = 1
AND matriculas.data_matricula > '2022-01-01'
AND turmas.tipo IN (0,1)

ORDER BY
turmas.id,
matriculas.id_alunos

