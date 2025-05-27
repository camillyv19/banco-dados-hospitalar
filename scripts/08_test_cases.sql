--TESTANDO AS FUNCTIONS

 -- Teste da função nome_completo_paciente
SELECT 'Paciente 1:' AS descricao, nome_completo_paciente(1) AS resultado;
SELECT 'Paciente 2:' AS descricao, nome_completo_paciente(2) AS resultado;

 -- Teste da função consultas_do_medico
SELECT 'Consultas do médico 1:' AS descricao;
SELECT * FROM consultas_do_medico(1);

SELECT 'Consultas do médico 2:' AS descricao;
SELECT * FROM consultas_do_medico(2);

 --Teste da função verificar_ocupado
SELECT 'Leito 101:' AS descricao, verificar_ocupado(101) AS situacao;

SELECT 'Leito 102:' AS descricao, verificar_ocupado(102) AS situacao;

SELECT 'Leito 103:' AS descricao, verificar_ocupado(103) AS situacao;


