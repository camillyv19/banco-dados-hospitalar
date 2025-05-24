
SELECT 
    p.id_paciente,
    p.nome,
    (SELECT COUNT(*) FROM consulta c WHERE c.id_paciente = p.id_paciente) AS total_consultas
FROM paciente p;


SELECT 
    sub.id_paciente,
    sub.qtd_exames
FROM (
    SELECT c.id_paciente, COUNT(e.id_exame) AS qtd_exames
    FROM consulta c
    LEFT JOIN exame e ON c.id_consulta = e.id_consulta
    GROUP BY c.id_paciente
) AS sub
WHERE sub.qtd_exames > (
    SELECT AVG(cnt) FROM (
        SELECT COUNT(e.id_exame) AS cnt
        FROM consulta c
        LEFT JOIN exame e ON c.id_consulta = e.id_consulta
        GROUP BY c.id_paciente
    ) AS media
);

SELECT 
    p.id_paciente,
    p.nome
FROM paciente p
WHERE EXISTS (
    SELECT 1 FROM internacao i WHERE i.id_paciente = p.id_paciente
);

SELECT 
    m.id_medico,
    m.nome
FROM medico m
WHERE NOT EXISTS (
    SELECT 1 FROM consulta c WHERE c.id_medico = m.id_medico
);

SELECT 
    m.id_medico,
    m.nome,
    COUNT(DISTINCT c.id_consulta) AS total_consultas,
    SUM(COALESCE(ex_sub.total_exames, 0)) AS total_exames
FROM medico m
LEFT JOIN consulta c ON m.id_medico = c.id_medico
LEFT JOIN (
    SELECT e.id_consulta, COUNT(*) AS total_exames
    FROM exame e
    GROUP BY e.id_consulta
) ex_sub ON c.id_consulta = ex_sub.id_consulta
GROUP BY m.id_medico, m.nome;
