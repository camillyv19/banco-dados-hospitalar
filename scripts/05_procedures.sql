CREATE OR REPLACE PROCEDURE resumo_paciente()
language plpgsql
AS $$
DECLARE

    paciente_cursor CURSOR FOR 
       SELECT id_paciente, nome FROM paciente;

    paciente_record RECORD;

    total_consultas INT;
    total_exames INT;
    total_internacoes INT;

BEGIN

    OPEN paciente_cursor;

    LOOP

       FETCH paciente_cursor INTO paciente_record;
       EXIT WHEN NOT FOUND;

        SELECT COUNT(*) INTO total_consultas
        FROM consulta
        WHERE id_paciente = paciente_record.id_paciente;

        SELECT COUNT(*) INTO total_exames
        FROM exame
        JOIN consulta ON exame.id_consulta = consulta.id_consulta
        WHERE consulta.id_paciente = paciente_record.id_paciente;

        SELECT COUNT(*) INTO total_internacoes
        FROM internacao
        WHERE id_paciente = paciente_record.id_paciente;
 

        RAISE NOTICE 'Paciente: % - Consultas: % - Exames: % - Internações: %', paciente_record.nome, total_consultas, total_exames, total_internacoes;
    END LOOP;

    CLOSE paciente_cursor;

 END;
 $$;

 
CREATE OR REPLACE PROCEDURE buscar_exame(IN tipo VARCHAR, IN data_inicial DATE, IN data_final DATE)
language plpgsql
AS $$
DECLARE

  busca_cursor CURSOR FOR
     SELECT paciente.nome, exame.tipo_exame, exame.data_exame FROM exame
     JOIN consulta ON exame.id_consulta = consulta.id_consulta
     JOIN paciente ON consulta.id_paciente = paciente.id_paciente
      WHERE (tipo IS NULL OR tipo_exame = tipo )
        AND (data_inicial IS NULL OR data_exame >= data_inicial)
        AND (data_final IS NULL OR data_exame <= data_final)
        ORDER BY data_exame;

  busca_record RECORD;

BEGIN
   OPEN busca_cursor;

    LOOP

     FETCH  busca_cursor INTO busca_record;
       EXIT WHEN NOT FOUND;

        RAISE NOTICE 'Paciente: %, Tipo: %, Data: %',
         busca_record.nome,  busca_record.tipo_exame,  busca_record.data_exame;
     END LOOP;

  CLOSE  busca_cursor;


 END;
 $$;


CREATE OR REPLACE PROCEDURE alta_paciente(id_paciente INT, data_alta DATE)
language plpgsql
AS $$
BEGIN
    IF data_alta IS NULL THEN
        UPDATE internacao
        SET data_saida = CURRENT_DATE
        WHERE internacao.id_paciente = id_paciente
        AND data_saida IS NULL;

    ELSE
        UPDATE internacao
        SET data_saida = data_alta
        WHERE internacao.id_paciente = id_paciente
        AND data_saida IS NULL;
    END IF;
END;
$$;  
 
