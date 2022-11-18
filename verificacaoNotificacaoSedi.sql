SET
    sql_mode =(
        SELECT
            REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY,', '')
    );
#54 é bittencourt, 46 é rassi, 48 sarah, basileu 39

SELECT
	#professores.nome,
	DATE_FORMAT(diario.data_aula,"%M") Lanc_Mes,
	DATE_FORMAT(diario.data_aula, "%Y") AS lanc_Ano,
	escolas.nome,
	SUM(diario.duracao)/60 AS QntHoras
	#SUM(
	#	CASE WHEN turmas.tipo = 0 THEN diario.duracao / 60 ELSE 0 END) AS 'Horas_Capacitacao',
	#SUM(
	#	CASE WHEN turmas.tipo = 1 THEN diario.duracao / 60 ELSE 0 END) AS 'Horas_Qualificacao',
	#SUM(
	#	CASE WHEN turmas.tipo = 2 THEN diario.duracao / 60 ELSE 0 END) AS 'Horas_Tecnico',
	#SUM(
	#	CASE WHEN turmas.tipo = 3 THEN diario.duracao / 60 ELSE 0 END) AS 'Horas_Superior'
	
FROM diario
	LEFT JOIN professores ON professores.id = diario.id_professores
	LEFT JOIN turmas_fics_professores ON turmas_fics_professores.id = diario.id_turmas_fics_professores
	LEFT JOIN turmas_fics ON turmas_fics.id = turmas_fics_professores.id_turmas_fics
	LEFT JOIN turmas ON turmas.id = turmas_fics.id_turmas
	LEFT JOIN escolas ON escolas.id = turmas.id_escolas
WHERE 
	diario.data_aula BETWEEN '2022-05-01' AND '2022-08-31' AND escolas.id IN (48,46,54)
GROUP BY
#professores.nome,
DATE_FORMAT(diario.data_aula, "%M"),
escolas.nome
ORDER BY 
	#professores.nome,
	DATE_FORMAT(diario.data_aula, "%Y"),
	DATE_FORMAT(diario.data_aula, "%m"),
	escolas.nome
