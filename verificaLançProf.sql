SELECT
	diario.data_aula,
	diario.duracao,
	diario.objetivo,
	diario.metodologia,
	diario.recursos_didaticos,
	diario.bibliografia,
	diario.avaliacao,
	diario.conteudo,
	escolas.nome AS Nome_Escola,
	CASE
   	WHEN turmas.tipo <= 1 THEN turmas.nome_qualificacao
   	WHEN turmas.tipo >= 2 THEN turmas.nome_curso
	END AS Curso,
	turmas.nome,
	turmas_fics.nome_fic AS Nome_Componente,
	turmas_fics.dt_inicial AS Inicio_comp,
	turmas_fics.dt_final AS Fim_comp,
	CASE
   	WHEN turmas_fics.status_fic = 0 then 'ABERTO'
   	WHEN turmas_fics.status_fic = 1 then 'EM ANDAMENTO'
   	WHEN turmas_fics.status_fic = 2 then 'CONCLUIDO'
		WHEN turmas_fics.status_fic = 3 then 'CANCELADO'
	END AS Status_comp,
	professores.nome,
	professores.cpf

FROM diario
LEFT JOIN professores
ON professores.id = diario.id_professores
LEFT	JOIN turmas_fics_professores
ON turmas_fics_professores.id = diario.id_turmas_fics_professores
LEFT JOIN turmas_fics
ON turmas_fics.id = turmas_fics_professores.id_turmas_fics
LEFT JOIN turmas
ON turmas.id = turmas_fics.id_turmas
LEFT JOIN escolas
ON escolas.id = turmas.id_escolas

WHERE diario.data_aula > '2022-08-01'
AND (LENGTH(diario.objetivo) < 20
OR LENGTH(diario.metodologia) < 10
OR LENGTH(diario.recursos_didaticos) < 8
OR LENGTH(diario.bibliografia) < 10
OR LENGTH(diario.avaliacao) < 10
OR LENGTH(diario.conteudo) < 10
OR diario.duracao <> 60)
AND turmas.modalidade = 'PRESENCIAL'
#AND escolas.nome = "SEBASTIÃO DE SIQUEIRA"
#AND escolas.id IN (54,46,48)