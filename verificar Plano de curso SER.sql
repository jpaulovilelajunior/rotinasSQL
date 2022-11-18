SELECT
eixos.nome,
qualificacoes.nome,
qualificacoes.nome_curto,
qualificacoes_arquivos.plano_curso_arquivo

FROM qualificacoes
left JOIN qualificacoes_arquivos
ON qualificacoes.id = qualificacoes_arquivos.id_qualificacoes
LEFT JOIN eixos
ON eixos.id = qualificacoes.id_eixos

WHERE qualificacoes.id >= 3247
AND qualificacoes_arquivos.plano_curso_arquivo IS NULL