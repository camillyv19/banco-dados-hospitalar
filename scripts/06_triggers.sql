CREATE TRIGGER log_trigger
AFTER INSERT OR UPDATE OR DELETE ON consulta
FOR EACH ROW
EXECUTE FUNCTION logar_consulta();


CREATE TRIGGER trigger_leito
AFTER INSERT ON internacao
FOR EACH ROW
EXECUTE FUNCTION atualizar_leito();


CREATE TRIGGER impedir_exclusao_medico
BEFORE DELETE ON medico
FOR EACH ROW
EXECUTE FUNCTION bloquear_medico();
