CREATE TABLE DEPTO (
    nomedepto TEXT,
    coddepto_PK serial,
    PRIMARY KEY (coddepto_PK)
);

CREATE TABLE PROFESSOR (
    codprof_PK serial PRIMARY KEY,
    codepto_FK serial,
    codtit_FK serial,
    nomeprof TEXT
);

CREATE TABLE TITULACAO (
    nometit TEXT,
    codtit_PK serial PRIMARY KEY
);

CREATE TABLE DISCIPLINA (
    coddepto_PFK serial,
    numdisc_PK serial,
    nomedisc TEXT,
    creditodisc serial,
    PRIMARY KEY (numdisc_PK, coddepto_PFK)
);

CREATE TABLE PREREQ (
    codepto_PFK serial,
    numdisc_PFK serial,
    coddeptoprereq_PK serial,
    numdiscprereq_PK serial,
    PRIMARY KEY (codepto_PFK, numdisc_PFK, coddeptoprereq_PK, numdiscprereq_PK)
);

CREATE TABLE PROFTURMA (
    coddepto_PFK serial,
    numdisc_PFK serial,
    anosem_PFK serial,
    silgatur_PFK serial,
    codprof_PFK serial,
    PRIMARY KEY (coddepto_PFK, numdisc_PFK, anosem_PFK, silgatur_PFK, codprof_PFK)
);

CREATE TABLE TURMA (
    coddepto_PFK serial,
    numdisc_PFK serial,
    anosem_PK serial,
    silatur_PK serial,
    capacidade serial,
    PRIMARY KEY (coddepto_PFK, numdisc_PFK, anosem_PK, silatur_PK)
);

CREATE TABLE HORARIO (
    codepto_PFK serial,
    numdisc_PFK serial,
    anosem_PFK serial,
    siglatur_PFK serial,
    diasem_PK serial,
    horainicio_PK serial,
    codpredio_FK serial,
    numsala_FK serial,
    numhoras serial,
    PRIMARY KEY (codepto_PFK, numdisc_PFK, anosem_PFK, siglatur_PFK, diasem_PK, horainicio_PK)
);

CREATE TABLE SALA (
    codpredio_PFK serial,
    numsala_PK serial,
    descricaosala serial,
    capacidade serial,
    PRIMARY KEY (codpredio_PFK, numsala_PK)
);

CREATE TABLE PREDIO (
    codpredio_PK serial PRIMARY KEY,
    descricaopredio TEXT
);
 
ALTER TABLE PROFESSOR ADD CONSTRAINT FK_PROFESSOR_1
    FOREIGN KEY (codtit_FK)
    REFERENCES TITULACAO (codtit_PK);
 
ALTER TABLE PROFESSOR ADD CONSTRAINT FK_PROFESSOR_2
    FOREIGN KEY (codepto_FK)
    REFERENCES DEPTO (coddepto_PK);
 
ALTER TABLE DISCIPLINA ADD CONSTRAINT FK_DISCIPLINA_2
    FOREIGN KEY (coddepto_PFK)
    REFERENCES DEPTO (coddepto_PK);
 
ALTER TABLE PREREQ ADD CONSTRAINT FK_PREREQ_2
    FOREIGN KEY (codepto_PFK, numdisc_PFK)
    REFERENCES DISCIPLINA (coddepto_PFK, numdisc_PK);
 
ALTER TABLE PROFTURMA ADD CONSTRAINT FK_PROFTURMA_2
    FOREIGN KEY (coddepto_PFK, numdisc_PFK, anosem_PFK, silgatur_PFK)
    REFERENCES TURMA (coddepto_PFK, numdisc_PFK, anosem_PK, silatur_PK);
 
ALTER TABLE PROFTURMA ADD CONSTRAINT FK_PROFTURMA_3
    FOREIGN KEY (codprof_PFK)
    REFERENCES PROFESSOR (codprof_PK);
 
ALTER TABLE TURMA ADD CONSTRAINT FK_TURMA_2
    FOREIGN KEY (coddepto_PFK, numdisc_PFK)
    REFERENCES DISCIPLINA (coddepto_PFK, numdisc_PK);
 
ALTER TABLE HORARIO ADD CONSTRAINT FK_HORARIO_2
    FOREIGN KEY (codepto_PFK, numdisc_PFK, anosem_PFK, siglatur_PFK)
    REFERENCES TURMA (coddepto_PFK, numdisc_PFK, anosem_PK, silatur_PK);
 
ALTER TABLE HORARIO ADD CONSTRAINT FK_HORARIO_3
    FOREIGN KEY (codpredio_FK, numsala_FK)
    REFERENCES SALA (codpredio_PFK, numsala_PK);
 
ALTER TABLE SALA ADD CONSTRAINT FK_SALA_2
    FOREIGN KEY (codpredio_PFK)
    REFERENCES PREDIO (codpredio_PK);
 
ALTER TABLE SALA ADD CONSTRAINT FK_SALA_3
    FOREIGN KEY (descricaosala)
    REFERENCES PREDIO (codpredio_PK);