CREATE TABLE paciente (
    id_paciente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    sexo CHAR(1),
    telefone VARCHAR(20),
    endereco TEXT
);

CREATE TABLE medico (
    id_medico INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    crm VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE consulta (
    id_consulta INT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    data_consulta DATETIME NOT NULL,
    diagnostico TEXT,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
);

CREATE TABLE exame (
    id_exame INT PRIMARY KEY,
    id_consulta INT,
    tipo_exame VARCHAR(100),
    resultado TEXT,
    data_exame DATE,
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta)
);

CREATE TABLE internacao (
    id_internacao INT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    data_entrada DATETIME,
    data_saida DATETIME,
    motivo TEXT,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
);