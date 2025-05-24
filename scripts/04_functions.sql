CREATE OR REPLACE FUNCTION nome_completo_paciente(id_paciente INT)
RETURNS TEXT AS $$
DECLARE
    resultado TEXT;
BEGIN
    SELECT nome || ' ' || sobrenome INTO resultado
    FROM paciente
    WHERE id = id_paciente;

    RETURN resultado;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION consultas_do_medico(id_medico INT)
RETURNS TABLE(consulta_id INT, data DATE) AS $$
BEGIN
    RETURN QUERY
    SELECT id, data_consulta
    FROM consulta
    WHERE medico_id = id_medico;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_ocupado(leito_id INT)
RETURNS TEXT AS $$
DECLARE
    ocupado BOOLEAN;
BEGIN
    SELECT ocupado INTO ocupado FROM leito WHERE id = leito_id;

    IF ocupado THEN
        RETURN 'Leito ocupado';
    ELSE
        RETURN 'Leito livre';
    END IF;
END;
$$ LANGUAGE plpgsql;
