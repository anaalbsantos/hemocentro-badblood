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

    CONSTRAINT DOADOR_PK PRIMARY KEY (CPF),
    CONSTRAINT DOADORPACIENTE_FK FOREIGN KEY (CPF) REFERENCES PACIENTE(CPF) ON DELETE CASCADE,
    CONSTRAINT CHK_HORAS_JEJUM CHECK (HORAS_JEJUM BETWEEN 0 AND 24)
);

-- CRIA TABELA PREMIO
CREATE TABLE PREMIO(
    ID VARCHAR(4),
    DESRIÇÃO VARCHAR(80),

    CONSTRAINT PREMIO_PK PRIMARY KEY (ID)
);

-- CRIA TABELA TECNICO_LABORATORIAL
CREATE TABLE TECNICO_LABORATORIO(
    CPF VARCHAR(4),
    FUNCAO VARCHAR(80),

    CONSTRAINT TECNICO_PK PRIMARY KEY(CPF),
    CONSTRAINT TECNICOFUNCIONARIO_FK FOREIGN KEY (CPF) REFERENCES FUNCIONARIO(CPF) ON DELETE CASCADE
);

--CRIA TABELA CONTATOS
CREATE TABLE CONTATOS(
    CPF VARCHAR(4),
    CONTATOS VARCHAR(80),

    CONSTRAINT CONTATOS_PK PRIMARY KEY(CPF, CONTATOS),
    CONSTRAINT CONTATOSPACIENTE_FK FOREIGN KEY (CPF) REFERENCES PACIENTE(CPF) ON DELETE CASCADE
);

--CRIA TABELA ENFERMEIRO
CREATE TABLE ENFERMEIRO(
    CPF VARCHAR(4),
    CONFEN VARCHAR(4),
    CHEFE VARCHAR(4),

    CONSTRAINT ENFERMEIRO_PK PRIMARY KEY(CPF),
    CONSTRAINT ENFERMEIROFUNCIONARIO_FK FOREIGN KEY (CPF) REFERENCES FUNCIONARIO(CPF) ON DELETE CASCADE,
    CONSTRAINT ENFERMEIROCHEFE_FK FOREIGN KEY (CHEFE) REFERENCES ENFERMEIRO(CPF) ON DELETE CASCADE
);

--CRIA TABELA SANGUE DOADO
CREATE TABLE SANGUE_DOADO(
    CPF_DOADOR VARCHAR (4),
    DATA_DOACAO DATE,
    CPF_FUNCIONARIO VARCHAR(4),

    CONSTRAINT SANGUE_DOADO_PK PRIMARY KEY(CPF_DOADOR,DATA_DOACAO),
    CONSTRAINT SANGUE_DOADO_DOADOR_FK FOREIGN KEY (CPF_DOADOR) REFERENCES DOADOR(CPF) ON DELETE CASCADE,
    CONSTRAINT SANGUE_DOADO_FUNC_FK FOREIGN KEY (CPF_FUNCIONARIO) REFERENCES FUNCIONARIO(CPF) ON DELETE CASCADE
);

--CRIA TABELA PROJETO
CREATE TABLE PROJETO(
    ID_PROJETO VARCHAR(4),
    INSTITUICAO_SIGLA VARCHAR(4),
    TITULO VARCHAR(4),
    CPF_TECNICO VARCHAR(4) NOT NULL UNIQUE,

    CONSTRAINT PROJETO_PK PRIMARY KEY(ID_PROJETO),
    CONSTRAINT PROJETO_TECNICO_FK FOREIGN KEY (CPF_TECNICO) REFERENCES TECNICO_LABORATORIO(CPF) ON DELETE CASCADE
); 

--CRIA TABELA SANGUE BOM
CREATE TABLE SANGUE_BOM(
    CPF_SANGUE_DOADO VARCHAR(4),
    DATA_DOACAO DATE,
    CPF_RECEPTOR VARCHAR(4),
    ANTIGENO_A VARCHAR(1),
    ANTIGENO_B VARCHAR(1),
    FATOR_RH VARCHAR(1),

    CONSTRAINT SANGUE_BOM_PK PRIMARY KEY(CPF_SANGUE_DOADO,DATA_DOACAO),
    CONSTRAINT SANGUE_BOM_SANGUE_DOADO_FK FOREIGN KEY (CPF_SANGUE_DOADO,DATA_DOACAO) REFERENCES SANGUE_DOADO(CPF_DOADOR,DATA_DOACAO) ON DELETE CASCADE,
    CONSTRAINT SANGUE_BOM_RECEPTOR_FK FOREIGN KEY (CPF_RECEPTOR) REFERENCES RECEPTOR(CPF) ON DELETE CASCADE
);

-- CRIA TABELA SANGUE RUIM
CREATE TABLE SANGUE_RUIM(
    CPF_SANGUE_DOADO VARCHAR(4),
    DATA_DOACAO DATE,
    CHAGAS VARCHAR(1),
    AIDS VARCHAR(1),
    HEPATITE VARCHAR(1),
    SIFILIS VARCHAR(1),

    CONSTRAINT SANGUE_RUIM_PK PRIMARY KEY(CPF_SANGUE_DOADO,DATA_DOACAO),
    CONSTRAINT SANGUE_RUIM_SANGUE_DOADO_FK FOREIGN KEY (CPF_SANGUE_DOADO,DATA_DOACAO) REFERENCES SANGUE_DOADO(CPF_DOADOR,DATA_DOACAO) ON DELETE CASCADE,
);

--CRIA TABELA VINCULADO
CREATE TABLE VINCULADO(
    CPF_TECNICO VARCHAR(4),
    CPF_SANGUE_RUIM VARCHAR(4),
    DATA_DOACAO DATE,
    ID_PROJETO VARCHAR(4),

    CONSTRAINT VINCULADO_PK PRIMARY KEY(CPF_TECNICO,CPF_SANGUE_RUIM,DATA_DOACAO,ID_PROJETO),
    CONSTRAINT VINCULADO_TECNICOFK FOREIGN KEY (CPF_TECNICO) REFERENCES TECNICO_LABORATORIO(CPF) ON DELETE CASCADE,
    CONSTRAINT VINCULADO_SANGUE_RUIM_FK FOREIGN KEY (CPF_SANGUE_RUIM,DATA_DOACAO) REFERENCES SANGUE_RUIM(CPF_SANGUE_DOADO,DATA_DOACAO) ON DELETE CASCADE,
    CONSTRAINT VINCULADO_PROJETO_FK FOREIGN KEY (ID_PROJETO) REFERENCES PROJETO(ID_PROJETO) ON DELETE CASCADE
);

--CRIA TABELA ATENDE
CREATE TABLE ATENDE(
    CPF_PACIENTE VARCHAR(4),
    CPF_ENFERMEIRO VARCHAR(4),

    CONSTRAINT ATENDE_PK PRIMARY KEY(CPF_PACIENTE, CPF_ENFERMEIRO),
    CONSTRAINT ATENDE_PACIENTE_FK FOREIGN KEY (CPF_PACIENTE) REFERENCES PACIENTE(CPF) ON DELETE CASCADE,
    CONSTRAINT ATENDE_ENFERMEIRO_FK FOREIGN KEY (CPF_ENFERMEIRO) REFERENCES ENFERMEIRO(CPF) ON DELETE CASCADE
);

--CRIA TABELA CONGRESSO
CREATE TABLE CONGRESSO(
    CODIGO VARCHAR(4),
    SIGLA VARCHAR (4),

    CONSTRAINT CODIGO_PK PRIMARY KEY(CODIGO)
);

--CRIA TABELA PARTICIPA
CREATE TABLE PARTICIPA(
    CPF_FUNCIONARIO VARCHAR(4),
    COD_CONGRESSO VARCHAR(4),
    DATA_PARTICIPA DATE,
    ID_PREMIO VARCHAR(4),

    CONSTRAINT PARTICIPA_PK PRIMARY KEY(CPF_FUNCIONARIO, COD_CONGRESSO,DATA_PARTICIPA),
    CONSTRAINT PARTICIPA_FUNCIONARIO_FK FOREIGN KEY (CPF_FUNCIONARIO) REFERENCES FUNCIONARIO(CPF) ON DELETE CASCADE,
    CONSTRAINT PARTICIPA_CONGRESSO_FK FOREIGN KEY (COD_CONGRESSO) REFERENCES CONGRESSO(CODIGO) ON DELETE CASCADE,
    CONSTRAINT PARTICIPA_PREMIO_FK FOREIGN KEY (ID_PREMIO) REFERENCES PREMIO(ID) ON DELETE CASCADE
);


insert into FUNCIONARIO values ('1231','Rui',TO_DATE('01/01/1990','DD/MM/YYYY'));
insert into FUNCIONARIO values ('1241','Lucas',TO_DATE('01/01/1990','DD/MM/YYYY'));
insert into FUNCIONARIO values ('1251','Paula',TO_DATE('01/01/1990','DD/MM/YYYY'));
insert into FUNCIONARIO values ('1261','Ana',TO_DATE('01/01/1990','DD/MM/YYYY'));
insert into FUNCIONARIO values ('1271','Pedro',TO_DATE('01/01/1990','DD/MM/YYYY'));
insert into FUNCIONARIO values ('1281','Luan',TO_DATE('01/01/1990','DD/MM/YYYY'));
insert into FUNCIONARIO values ('1291','Maria',TO_DATE('01/01/1990','DD/MM/YYYY'));

insert into PACIENTE values ('2111','Matheus',TO_DATE('20/01/1990','DD/MM/YYYY'),20);
insert into PACIENTE values ('2112','Luana',TO_DATE('01/01/1990','DD/MM/YYYY'),30);