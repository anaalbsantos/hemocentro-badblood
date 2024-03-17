-------------------
-- CRIAÇÃO DO BD --
-------------------

-- CRIA TABELA FUNCIONARIO
CREATE TABLE FUNCIONARIO(
CPF VARCHAR(4),
NOME VARCHAR(80) CONSTRAINT NN_FUNC_NOME NOT NULL,
NASCIMENTO DATE,
CONSTRAINT PK_USUARIOS PRIMARY KEY (CPF),
CONSTRAINT AK_USU_CPF UNIQUE (NOME, NASCIMENTO)
);

-- CRIA TABELA SALARIO
CREATE TABLE SALARIO(
VALOR NUMBER(4,2) PRIMARY KEY 
);

-- CRIA TABELA PACIENTE
CREATE TABLE PACIENTE(
CPF VARCHAR(4),
NOME VARCHAR(80) NOT NULL,
DATA_DE_NASCIMENTO DATE,
IDADE NUMBER(4,2) NOT NULL,
CONSTRAINT PK_PACIENTE PRIMARY KEY (CPF),
CONSTRAINT CHK_PACIENTE_IDADE CHECK (IDADE BETWEEN 1 AND 99)
);

-- CRIA TABELA RECEPTOR
CREATE TABLE RECEPTOR(
CPF VARCHAR(4),
NOME VARCHAR(80) NOT NULL,
HOSPITAL VARCHAR(80) NOT NULL,
DOENCA VARCHAR(80),
CONSTRAINT RECEPTOR_PK PRIMARY KEY (CPF)
);

CREATE TABLE DOADOR(
CPF VARCHAR(4),
HORAS_JEJUM NUMBER(4,2) NOT NULL,
COMORBIDADES VARCHAR(80),
CONSTRAINT DOADOR_PK PRIMARY KEY (CPF, MAT),
CONSTRAINT DOADORPACIENTE_FK FOREIGN KEY (CPF) REFERENCES PACIENTE ON DELETE CASCADE,
CONSTRAINT CHK_HORAS_JEJUM CHECK (HORAS_JEJUM BETWEEN 0 AND 24)
);

-- CRIA TABELA BONUS_HORAS_EXTRA
CREATE TABLE BONUS_HORAS(
    HORAS_TRABALHADAS NUMBER(4,2),
    VALOR NUMBER(4,2),
    CONSTRAINT SALARIO_PK PRIMARY KEY (HORAS_TRABALHADAS)
);

-- CRIA TABELA TECNICO_LABORATORIAL
CREATE TABLE TECNICO_LABORATORIO(
    CPF VARCHAR(4),
    FUNCAO VARCHAR(80),
    CONSTRAINT TECNICO_PK PRIMARY KEY(CPF),
    CONSTRAINT TECNICOFUNCIONARIO_FK FOREIGN KEY (CPF) REFERENCES FUNCIONARIO ON DELETE CASCADE
);





