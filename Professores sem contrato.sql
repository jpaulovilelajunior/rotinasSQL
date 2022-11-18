SELECT * FROM sec_log
WHERE sec_log.application = 'professores_form' AND sec_log.`action` = 'insert' AND sec_log.inserted_date > '2021-09-01';

SELECT 
professores.id,
professores.nome,
professores.fone,
professores.email,
professores_contratos.contrato_trabalho

FROM professores
LEFT JOIN professores_contratos
ON professores.id = professores_contratos.id_professores

WHERE professores.id > 1903