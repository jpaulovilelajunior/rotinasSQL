SELECT
DISTINCT (matriculas.numero_matricula) AS numr_matri,
alunos.nome,
alunos.cpf

FROM turmas
LEFT JOIN turmas_fics
ON turmas.id = turmas_fics.id_turmas
LEFT JOIN turmas_fics_professores
ON turmas_fics.id = turmas_fics_professores.id_turmas_fics
LEFT JOIN matriculas
ON turmas_fics_professores.id = matriculas.id_turmas_fics_professores
LEFT JOIN alunos
ON alunos.id = matriculas.id_alunos

WHERE
turmas.nome ='TEC-CMF-TAQ-TNMPM-I1-2019'
#AND matriculas.r_turma = 'APTO'

ORDER BY
alunos.nome