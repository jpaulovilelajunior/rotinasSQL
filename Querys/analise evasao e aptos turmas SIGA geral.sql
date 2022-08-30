
SELECT 
tf.nome_eixo AS Eixo,
esc.nome AS Escola_Nome,
CASE
	WHEN t.tipo <= 1 then t.nome_qualificacao
	WHEN t.tipo >= 2 then t.nome_curso
END AS Curso_nome,
t.nome AS Codigo_SIGA,
CASE
	WHEN t.tipo = 0 then 'CAPACITACAO'
	WHEN t.tipo = 1 then 'QUALIFICACAO'
   WHEN t.tipo = 2 then 'CURSO TECNICO'
   WHEN t.tipo = 3 then 'CURSO SUPERIOR'
END AS Categoria,
CASE
   WHEN t.`status` = 0 then 'ABERTO'
   WHEN t.`status` = 1 then 'EM ANDAMENTO'
   WHEN t.`status` = 2 then 'CONCLUIDO'
	WHEN t.`status` = 3 then 'CANCELADO'
END AS 'Status_Turma',
t.data_inicio AS Data_Inicio_Turma,
t.data_fim AS Data_Fim_Turma,
tf.nome_fic AS Componente,
CASE
   WHEN tf.status_fic = 0 then 'ABERTO'
   WHEN tf.status_fic = 1 then 'EM ANDAMENTO'
   WHEN tf.status_fic = 2 then 'CONCLUIDO'
	WHEN tf.status_fic = 3 then 'CANCELADO'
END AS 'Status_Componente',
tf.carga_hr AS Horas_Componente,
COUNT(mt.id) AS Qnt_Matriculas,
SUM(CASE WHEN mt.r_freq > 75 THEN 1 ELSE 0 END) AS Qnt_Frequ,
SUM(CASE WHEN mt.r_fic = 'APTO' THEN 1 ELSE 0 END) AS Qnt_Aptos,
SUM(tf.carga_hr * (mt.r_freq/100)) AS Execucao

FROM matriculas AS mt
LEFT JOIN alunos
ON mt.id_alunos = alunos.id
LEFT JOIN turmas_fics_professores AS fp
ON mt.id_turmas_fics_professores = fp.id
LEFT JOIN turmas_fics AS tf
ON fp.id_turmas_fics = tf.id
LEFT	JOIN turmas AS t
ON tf.id_turmas = t.id
LEFT	JOIN escolas AS esc
ON t.id_escolas = esc.id

WHERE mt.data_matricula > '2022-01-01'

GROUP BY mt.id_turmas_fics_professores
			
