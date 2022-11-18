SELECT * FROM matricula_0_cursos
WHERE matricula_0_cursos.date_time > '2022-07-01' 
#AND matricula_0_cursos.escola = 10
AND matricula_0_cursos.situacao = 'Ativo'
AND matricula_0_cursos.id = 4557
ORDER BY matricula_0_cursos.nome;

SELECT
	mun.nome,
	edt.tipo,
	cur.nome,
	cur.modalidade,
	cur.turno,
	COUNT(mat.id) AS 'inscritos'
FROM matricula_0_matriculados mat
INNER JOIN matricula_0_cursos cur ON cur.id = mat.curso
INNER JOIN matricula_0_editais edt ON edt.id = cur.edital
INNER JOIN matricula_0_escolas esc ON esc.id = edt.escola
INNER JOIN matricula_0_municipio mun ON mun.id = esc.municipio
WHERE
	UPPER(mun.nome) LIKE 'CERES'
	AND DATE_FORMAT(edt.data_publicao, '%Y-%m-%d') = '2022-07-01'
GROUP BY
	mun.id,
	edt.data_publicao,
	edt.tipo,
	cur.id,
	cur.modalidade,
	cur.turno
ORDER BY
	edt.data_publicao,
	edt.tipo,
	cur.nome,
	cur.modalidade DESC,
	cur.turno