SET
    sql_mode =(
        SELECT
            REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY,', '')
    );
SELECT
	#professores.id,
	professores.nome,
	professores.cpf,
	professores.email,
	DATE_FORMAT(diario.data_aula,"%M") Lanc_Mes,
	DATE_FORMAT(diario.data_aula, "%Y") AS lanc_Ano,
	escolas.nome,
	sum(diario.duracao)/60 AS QntHoras
	
FROM diario
	LEFT JOIN professores ON professores.id = diario.id_professores
	LEFT JOIN turmas_fics_professores ON turmas_fics_professores.id = diario.id_turmas_fics_professores
	LEFT JOIN turmas_fics ON turmas_fics.id = turmas_fics_professores.id_turmas_fics
	LEFT JOIN turmas ON turmas.id = turmas_fics.id_turmas
	LEFT JOIN escolas ON escolas.id = turmas.id_escolas
WHERE 
	diario.data_aula BETWEEN '2022-09-01' AND '2022-09-20'
	AND escolas.nome = "SEBASTIÃO DE SIQUEIRA"
	#AND escolas.id IN (48,46,54,39) AND professores.id = 649
GROUP BY
DATE_FORMAT(diario.data_aula, "%M"),
escolas.nome,
professores.nome
ORDER BY
	escolas.nome,
	professores.nome,
	DATE_FORMAT(diario.data_aula, "%Y"),
	DATE_FORMAT(diario.data_aula, "%m");
