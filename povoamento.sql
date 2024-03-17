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
VALOR VARCHAR(4) PRIMARY KEY 
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
CONSTRAINT ESCREVE_PK PRIMARY KEY (CPF, MAT),
CONSTRAINT ESCREVEPESQUISADOR_FK FOREIGN KEY (CPF) REFERENCES PESQUISADOR ON DELETE CASCADE,
CONSTRAINT ESCREVEARTIGO_FK FOREIGN KEY (MAT) REFERENCES ARTIGO ON DELETE CASCADE,
CONSTRAINT CHK_DOADOR_HORAS CHECK (HORAS_JEJUM BETWEEN 0 AND 24)
);







