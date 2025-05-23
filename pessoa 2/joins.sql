SELECT 
    c.id_consulta,
    p.nome AS nome_paciente,
    m.nome AS nome_medico,
    c.data_consulta
FROM consulta c
INNER JOIN paciente p ON c.id_paciente = p.id_paciente
INNER JOIN medico m ON c.id_medico = m.id_medico;

SELECT 
    p.id_paciente,
    p.nome,
    e.id_exame,
    e.tipo_exame
FROM paciente p
LEFT JOIN consulta c ON p.id_paciente = c.id_paciente
LEFT JOIN exame e ON c.id_consulta = e.id_consulta;

SELECT 
    e.id_exame,
    e.tipo_exame,
    c.id_consulta,
    p.nome AS nome_paciente
FROM exame e
RIGHT JOIN consulta c ON e.id_consulta = c.id_consulta
RIGHT JOIN paciente p ON c.id_paciente = p.id_paciente;

SELECT 
    m.id_medico,
    m.nome AS nome_medico,
    c.id_consulta,
    c.data_consulta
FROM medico m
FULL JOIN consulta c ON m.id_medico = c.id_medico;

SELECT 
    p.id_paciente,
    p.nome,
    co.total_consultas,
    ex.total_exames
FROM paciente p
LEFT JOIN (
    SELECT id_paciente, COUNT(*) AS total_consultas
    FROM consulta
    GROUP BY id_paciente
) co ON p.id_paciente = co.id_paciente
LEFT JOIN (
    SELECT c.id_paciente, COUNT(e.id_exame) AS total_exames
    FROM consulta c
    LEFT JOIN exame e ON c.id_consulta = e.id_consulta
    GROUP BY c.id_paciente
) ex ON p.id_paciente = ex.id_paciente;
