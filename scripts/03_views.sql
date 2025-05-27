CREATE VIEW vw_consultas_pacientes AS
SELECT p.nome, c.data_consulta
FROM paciente p
JOIN consulta c ON p.id_paciente = c.id_paciente;
