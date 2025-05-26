INSERT INTO paciente VALUES
(1, 'Ana Clara Silva', '1990-03-12', 'F', '(11)98765-4321', 'Rua das Flores, 123'),
(2, 'Carlos Alberto Souza', '1982-11-05', 'M', '(21)99876-5432', 'Av. Brasil, 456');

INSERT INTO medico VALUES
(1, 'Dra. Beatriz Mendes', 'Cardiologia', 'CRM123456'),
(2, 'Dr. João Lima', 'Ortopedia', 'CRM654321');

INSERT INTO consulta VALUES
(1, 1, 1, '2025-05-20 09:00:00', 'Hipertensão leve'),
(2, 2, 2, '2025-05-19 14:30:00', 'Dor lombar');

INSERT INTO exame VALUES
(1, 1, 'Eletrocardiograma', 'Normal', '2025-05-20'),
(2, 2, 'Raio-X', 'Hérnia de disco detectada', '2025-05-19');

INSERT INTO internacao VALUES
(1, 1, 1, '2025-05-01 10:00:00', '2025-05-05 11:00:00', 'Avaliação cardiológica intensiva'),
(2, 2, 2, '2025-05-10 15:00:00', NULL, 'Tratamento ortopédico emergencial');

INSERT INTO internacao VALUES
(1, 1, 1, '2025-05-01 10:00:00', '2025-05-05 11:00:00', 'Avaliação cardiológica intensiva', 101),
(2, 2, 2, '2025-05-10 15:00:00', NULL, 'Tratamento ortopédico emergencial', 102);

INSERT INTO leito (id, numero_leito, ocupado) VALUES
(101, 'A101', FALSE), 
(102, 'A102', FALSE),
(103, 'B201', FALSE);

UPDATE leito SET ocupado = TRUE where id = 102;