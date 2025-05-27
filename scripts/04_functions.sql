CREATE OR REPLACE FUNCTION nome_completo_paciente(id_paciente INT)
RETURNS TEXT AS $$
DECLARE
    resultado TEXT;
BEGIN
    SELECT nome INTO resultado
    FROM paciente p
    WHERE p.id_paciente = nome_completo_paciente.id_paciente;

    RETURN resultado;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION consultas_do_medico(id_medico INT)
RETURNS TABLE(consulta_id INT, data DATE) AS $$
BEGIN
    RETURN QUERY
    SELECT id_consulta, data_consulta
    FROM consulta 
    WHERE consulta.id_medico =  consultas_do_medico.id_medico;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verificar_ocupado(leito_id INT)
RETURNS TEXT AS $$
DECLARE
    ocupacao BOOLEAN;
BEGIN
    SELECT ocupado INTO ocupacao
    FROM leito
     WHERE leito.id = verificar_ocupado.leito_id;

    IF ocupacao THEN
        RETURN 'Leito ocupado';
    ELSE
        RETURN 'Leito livre';
    END IF;
END;
$$ LANGUAGE plpgsql;


--functions de trigger

CREATE OR REPLACE FUNCTION logar_consulta()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_consulta (acao) VALUES (TG_OP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION atualizar_leito()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE leito SET ocupado = TRUE WHERE id = NEW.leito_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION bloquear_medico()
RETURNS TRIGGER AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total FROM consulta WHERE medico_id = OLD.id;

    IF total > 0 THEN
        RAISE EXCEPTION 'Médico com consultas não pode ser excluído';
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
