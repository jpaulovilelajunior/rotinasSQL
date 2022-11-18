SELECT
	mun.nome,
	esc.nome,
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
	edt.id IN (254,257,318,253,258,319,253,255,317)
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
	cur.turno;
	
	
SELECT
	edt.date_time,
	edt.tipo,
	cur.nome AS Nome_Curso,
	cur.modalidade,
	cur.turno,
	esc.nome,
	mat.id,
	mat.nome_completo,
	mat.numero_cpf
FROM matricula_0_cursos cur
LEFT JOIN matricula_0_editais edt ON edt.id = cur.edital
LEFT JOIN matricula_0_matriculados mat ON mat.curso = cur.id
LEFT JOIN matricula_0_escolas esc ON esc.id = edt.escola
LEFT JOIN matricula_0_municipio mun ON mun.id = esc.municipio

WHERE
	edt.id IN (254,257,318,253,258,319,253,256,317)
ORDER BY
	edt.data_publicao,
	edt.tipo,
	cur.nome,
	cur.modalidade DESC,
	cur.turno,
	mat.nome_completo
	
