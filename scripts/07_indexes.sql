
EXPLAIN ANALYZE
SELECT * FROM exame
WHERE tipo_exame = 'Raio-X' AND data_exame BETWEEN '2025-01-01' AND '2025-12-31';

CREATE INDEX idx_consulta_id_paciente ON consulta(id_paciente);


CREATE INDEX idx_exame_tipo_exame ON exame(tipo_exame);

CREATE INDEX idx_exame_tipo_data ON exame(tipo_exame, data_exame);


