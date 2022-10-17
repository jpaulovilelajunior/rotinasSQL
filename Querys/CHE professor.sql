SELECT 
diario.duracao,
diario.data_aula,
turmas_fics.nome_fic,
case
   WHEN turmas.tipo <= 1 THEN turmas.nome_qualificacao
   WHEN turmas.tipo >= 2 THEN turmas.nome_curso
END AS nomeCurso,
diario.id_professores,
professores.nome
FROM diario
LEFT JOIN professores
ON professores.id = diario.id_professores
LEFT JOIN turmas_fics_professores
ON turmas_fics_professores.id = diario.id_turmas_fics_professores
LEFT JOIN turmas_fics
ON turmas_fics.id =turmas_fics_professores.id_turmas_fics
LEFT JOIN turmas
ON turmas.id = turmas_fics.id_turmas
WHERE diario.data_aula BETWEEN '2022-06-19' AND '2022-08-04' AND professores.id = 93;
