SELECT
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
   	LIMIT 1) AS professor_cpf,
	turmas_fics.nome_fic


FROM turmas_fics
LEFT JOIN turmas
ON turmas.id = turmas_fics.id_turmas

WHERE turmas.nome = 'TEC-CMF-TAQ-TNMPM-I1-2019'
ORDER BY turmas_fics.nome_fic
