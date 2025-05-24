CREATE TABLE IF NOT EXISTS log_consulta (
    id SERIAL PRIMARY KEY,
    acao TEXT,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION logar_consulta()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_consulta (acao) VALUES (TG_OP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_trigger
AFTER INSERT OR UPDATE OR DELETE ON consulta
FOR EACH ROW
EXECUTE FUNCTION logar_consulta();

CREATE OR REPLACE FUNCTION atualizar_leito()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE leito SET ocupado = TRUE WHERE id = NEW.leito_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_leito
AFTER INSERT ON internacao
FOR EACH ROW
EXECUTE FUNCTION atualizar_leito();

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

CREATE TRIGGER impedir_exclusao_medico
BEFORE DELETE ON medico
FOR EACH ROW
EXECUTE FUNCTION bloquear_medico();
