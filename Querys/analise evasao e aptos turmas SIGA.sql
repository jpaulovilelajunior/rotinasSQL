SET
    sql_mode =(
        SELECT
            REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY,', '')
    );
    

SELECT
mt.id_alunos,
tf.nome_eixo,
esc.nome AS Escola_Nome,
CASE
	WHEN t.tipo <= 1 then t.nome_qualificacao
	WHEN t.tipo >= 2 then t.nome_curso
END AS Curso_nome,
t.nome AS nome_SIGA,
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
END AS 'StatusTurma',
t.data_inicio,
t.data_fim,
tf.nome_fic,
tf.carga_hr AS horas_componente,
alunos.nome,
mt.r_freq AS frequencia_componente,
mt.r_media AS nota_componente,
mt.r_fic AS resultado_componente


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

