-------------------
-- CRIAÇÃO DO BD --
-------------------

-- CRIA TABELA FUNCIONARIO
CREATE TABLE FUNCIONARIO(
    CPF VARCHAR(4),
    NOME VARCHAR(80) CONSTRAINT NN_FUNC_NOME NOT NULL,
    NASCIMENTO DATE,
    SALARIO NUMBER(5),
    
    CONSTRAINT PK_USUARIOS PRIMARY KEY (CPF),
    CONSTRAINT AK_USU_CPF UNIQUE (NOME, NASCIMENTO) --??
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
    CPF_TECNICO VARCHAR(4),

    CONSTRAINT SANGUE_DOADO_PK PRIMARY KEY(CPF_DOADOR,DATA_DOACAO),
    CONSTRAINT SANGUE_DOADO_DOADOR_FK FOREIGN KEY (CPF_DOADOR) REFERENCES DOADOR(CPF) ON DELETE CASCADE,
    CONSTRAINT SANGUE_DOADO_TEC_FK FOREIGN KEY (CPF_TECNICO) REFERENCES TECNICO_LABORATORIO(CPF) ON DELETE CASCADE
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
    CONSTRAINT SANGUE_RUIM_SANGUE_DOADO_FK FOREIGN KEY (CPF_SANGUE_DOADO,DATA_DOACAO) REFERENCES SANGUE_DOADO(CPF_DOADOR,DATA_DOACAO) ON DELETE CASCADE
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

-- qtde de registros inseridos: 8
insert into FUNCIONARIO values ('1231','Rui','01-JAN-1990', 20000); --enfermeiro
insert into FUNCIONARIO values ('1241','Lucas','13-DEC-1980', 5000); --tecnico
insert into FUNCIONARIO values ('1251','Paula','21-MAR-1995', 30000); --tecnico
insert into FUNCIONARIO values ('1261','Ana','15-JUN-2000', 14000); --tecnico
insert into FUNCIONARIO values ('1271','Pedro','11-JAN-2000', 50000); --tecnico
insert into FUNCIONARIO values ('1281','Luan','11-FEB-1999', 40000); --enfermeiro
insert into FUNCIONARIO values ('1291','Maria','31-JAN-1992', 25000); --enfermeiro
insert into FUNCIONARIO values ('1221','Marcos','20-APR-2001', 24000); --enfermeiro
insert into FUNCIONARIO values ('1222','Gustavo','20-APR-2001', 1200); --tecnico

-- qtde de registros inseridos: 7
insert into PACIENTE values ('2111','Matheus','22-JAN-1990',34);
insert into PACIENTE values ('2112','Luana','01-JAN-1990',34);
insert into PACIENTE values('2113','Taylor','13-DEC-1989',34);
insert into PACIENTE values('2114','Luca','30-JUL-1985',38);
insert into PACIENTE values('2115','Paulo','15-JUL-2002',21);
insert into PACIENTE values('2116','Anne','19-SEP-2004',19);
insert into PACIENTE values('2117','Sara','07-JAN-2000',24); --não é doador

--qtde de registros inseridos: 7
insert into RECEPTOR values('3111','Mateus','Hospital Oswaldo Cruz','Cancer');
insert into RECEPTOR values('3112','Luane','Hospital das Clinicas','Dengue');
insert into RECEPTOR values('3113','Joana','Hospital Getulio Vargas','Hepatite');
insert into RECEPTOR values('3114','Luke','Hospital Portugues','Rubeola');
insert into RECEPTOR values('3115','Paul','Hospital da Psiquiátrico David Oscar','Sarampo');
insert into RECEPTOR values('3116','Anna','Hospital da Mulher','Alopércia');
insert into RECEPTOR values('3117','Sarah','Hospital Barao de Lucena','AIDS');

--dados inseridos: 6
insert into DOADOR values('2111',12,'Nenhuma');
insert into DOADOR values('2112',10,'Diabetes');
insert into DOADOR values('2113',11,'Hipertensão');
insert into DOADOR values('2114',8,'Obesidade');
insert into DOADOR values('2115',2,'Nenhuma');
insert into DOADOR values('2116',19,'Austismo');

--dados inseridos: 5
insert into PREMIO values('1111','Certificado: Melhor Projeto');
insert into PREMIO values('2222','Certificado: Melhor Apresentação');
insert into PREMIO values('3333','Biscoito Negresco');
insert into PREMIO values('4444','Coca-zero');
insert into PREMIO values('5555','1000 reais');

--dados inseridos: 4
insert into TECNICO_LABORATORIO values('1241','Sorologia');
insert into TECNICO_LABORATORIO values('1251','Hematologia');
insert into TECNICO_LABORATORIO values('1261','Imunologia');
insert into TECNICO_LABORATORIO values('1271','Bioquimica');
insert into TECNICO_LABORATORIO values('1222','Bioquimica');

--dados inseridos: 7
insert into CONTATOS values('2111','999999999');
insert into CONTATOS values('2112','888888888');
insert into CONTATOS values('2113','777777777');
insert into CONTATOS values('2114','666666666');
insert into CONTATOS values('2115','555555555');
insert into CONTATOS values('2116','444444444');
insert into CONTATOS values('2117','333333333');

--dados inseridos: 4
insert into ENFERMEIRO(CPF,CONFEN) values('1281','1234');
insert into ENFERMEIRO values('1291','1235','1281');
insert into ENFERMEIRO values('1231','1236','1291');
insert into ENFERMEIRO values('1221','1237','1281');


insert into SANGUE_DOADO values('2111','01-JAN-2020','1241');
insert into SANGUE_DOADO values('2112','02-JAN-2020','1241');
insert into SANGUE_DOADO values('2112','03-FEB-2020','1251');
insert into SANGUE_DOADO values('2113','03-FEB-2020','1261');
insert into SANGUE_DOADO values('2114','04-FEB-2020','1271');
insert into SANGUE_DOADO values('2115','04-FEB-2020','1271');

insert into SANGUE_BOM values('2111','01-JAN-2020','3111','1','0','+');
insert into SANGUE_BOM values('2112','02-JAN-2020','3112','1','1','+');
insert into SANGUE_BOM values('2112','03-FEB-2020','3113','0','0','-');
insert into SANGUE_BOM values('2113','03-FEB-2020','3114','1','0','+');

insert into SANGUE_RUIM values('2114','04-FEB-2020','0','0','0','0');
insert into SANGUE_RUIM values('2115','04-FEB-2020','0','1','0','1');

insert into PROJETO values('1111','UFPE','Pjt1','1241');
insert into PROJETO values('2222','UFPE','Pjt2','1251');
insert into PROJETO values('3333','UPE','Pjt3','1261');

insert into VINCULADO values('1241','2114','04-FEB-2020','1111');
insert into VINCULADO values('1251','2115','04-FEB-2020','2222');
insert into VINCULADO values('1261','2115','04-FEB-2020','3333');

insert into ATENDE values('2111','1281');
insert into ATENDE values('2112','1291');
insert into ATENDE values('2113','1231');
insert into ATENDE values('2114','1221');
insert into ATENDE values('2115','1281');
insert into ATENDE values('2116','1291');
insert into ATENDE values('2117','1231');

insert into CONGRESSO values('0001','SBP1');
insert into CONGRESSO values('0002','SBC1');
insert into CONGRESSO values('0003','SBC2');
insert into CONGRESSO values('0004','SBP2');

insert into PARTICIPA values('1241','0001','01-JAN-2020','1111');
insert into PARTICIPA values('1251','0002','02-JAN-2020','2222');
insert into PARTICIPA values('1261','0003','03-FEB-2020','3333');
insert into PARTICIPA values('1271','0004','04-FEB-2020','4444');
insert into PARTICIPA values('1281','0004','04-FEB-2020','5555');

