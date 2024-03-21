**Funcionário** (<u>CPF</u>, Nome, Data_de_Ingresso, Salario)

**Congresso** (Código, Sigla)

**Paciente** (CPF, Nome, Data_de_Nascimento, Idade)

**Contatos** (CPF, contatos)
    CPF → Paciente (CPF)

**Receptor** (CPF, Nome, Hospital, Doença)

**Doador** (CPF, Horas_em_jejum, Comorbidades)

CPF → Paciente (CPF)

**Enfermeiro** (CPF, Cofen, Chefe)

CPF → Funcionário (CPF)

Chefe → Enfermeiro (CPF)

**Técnico_Laboratorial** (CPF, Função)

CPF → Funcionário (CPF)

**Inspetor** (CPF, Formação)

CPF → Funcionário (CPF)

**Projeto** (ID, Instituição, Título, [CPF_inspetor]!)

CPF_inspetor → Inspetor (CPF)

**Sangue_Doado** (CPF, Data, CPF_tecnico)

CPF → Doador(CPF)

CPF_tecnico → Técnico_Laboratorial(CPF)

**Sangue_Bom** (CPF, Data, CPF_recep, Antígeno_A, Antígeno_B, Fator_RH)

(CPF, Data)→ Sangue_Doado (CPF, Data)

CPF_recep → Receptor (CPF)

**Sangue_Ruim** (CPF, Data, Chagas, Aids, Hepatite, Sífilis)

(CPF, Data)→ Sangue_Doado (CPF, Data)

**Vinculado** ( CPF_tecnico, CPF_sangue, Data_sangue, ID_projeto)

CPF_tecnico → Técnico_Laboratorial (CPF)

(CPF_sangue, Data_sangue) → Sangue_ruim  (CPF, Data)

ID_projeto → Projeto (ID)

**Atende** (CPF_paciente , CPF_enfermeiro)

CPF_paciente → Paciente (CPF)

CPF_enfermeiro → Enfermeiro (CPF)

**Prêmio** (ID, Descriçao)

**Participa** (CPF_func, COD_congresso, Data, ID_premio)

CPF_func → Funcionario (CPF)

ID_premio → Premio (ID)

COD_congresso → Congresso (Codigo)
