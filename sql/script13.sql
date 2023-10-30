-- Desativando a configuração que impede atualizações inseguras
SET SQL_SAFE_UPDATES = 0;

-- Exclui o banco de dados DBCLASSIFICACAO se ele existir
DROP DATABASE IF EXISTS DBCLASSIFICACAO;

-- Cria o banco de dados DBCLASSIFICACAO
CREATE DATABASE DBCLASSIFICACAO;

-- Usa o banco de dados DBCLASSIFICACAO
USE DBCLASSIFICACAO;

-- Cria a tabela ALUNO para armazenar informações sobre alunos, incluindo a idade
CREATE TABLE ALUNO (
    IDALUNO INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único do aluno
    NOME VARCHAR(45),  -- Nome do aluno
    IDADE INT  -- Idade do aluno
);

-- Cria a tabela CLASSIFICACAO para armazenar estatísticas de alunos classificados por idade
CREATE TABLE CLASSIFICACAO (
    CRIANCAS INT, -- Contador de crianças
    JOVENS INT,  -- Contador de jovens
    ADULTOS INT  -- Contador de adultos
);

-- Insere uma linha na tabela CLASSIFICACAO para rastrear a quantidade de alunos em cada categoria
INSERT INTO CLASSIFICACAO VALUES (0, 0, 0);

-- Define um novo delimitador para criar gatilhos
DELIMITER $$

-- Cria um gatilho TR_ALUNO_AI que é acionado após a inserção de um aluno na tabela ALUNO
CREATE TRIGGER TR_ALUNO_AI AFTER INSERT ON ALUNO FOR EACH ROW
BEGIN 
    -- Verifica a idade do novo aluno e atualiza a tabela CLASSIFICACAO com base na idade
    IF NEW.IDADE < 10 THEN
        UPDATE CLASSIFICACAO SET CRIANCAS = CRIANCAS + 1;
    ELSEIF NEW.IDADE >= 10 AND NEW.IDADE < 18 THEN
        UPDATE CLASSIFICACAO SET JOVENS = JOVENS + 1;
    ELSEIF NEW.IDADE > 18 THEN
        UPDATE CLASSIFICACAO SET ADULTOS = ADULTOS + 1;
    END IF;
END $$

-- Cria um gatilho TR_ALUNO_AD que é acionado após a exclusão de um aluno na tabela ALUNO
CREATE TRIGGER TR_ALUNO_AD AFTER DELETE ON ALUNO FOR EACH ROW
BEGIN 
    -- Verifica a idade do aluno excluído e atualiza a tabela CLASSIFICACAO com base na idade
    IF OLD.IDADE < 10 THEN
        UPDATE CLASSIFICACAO SET CRIANCAS = CRIANCAS - 1;
    ELSEIF OLD.IDADE >= 10 AND OLD.IDADE < 18 THEN
        UPDATE CLASSIFICACAO SET JOVENS = JOVENS - 1;
    ELSE
        UPDATE CLASSIFICACAO SET ADULTOS = ADULTOS - 1;
    END IF;
END $$

-- Cria um gatilho TR_ALUNO_AU que é acionado após a atualização de um aluno na tabela ALUNO
CREATE TRIGGER TR_ALUNO_AU AFTER UPDATE ON ALUNO FOR EACH ROW
BEGIN 
    -- Verifica a idade antiga do aluno e atualiza a tabela CLASSIFICACAO com base na idade antiga
    IF OLD.IDADE < 10 THEN
        UPDATE CLASSIFICACAO SET CRIANCAS = CRIANCAS - 1;
    ELSEIF OLD.IDADE > 10 AND OLD.IDADE < 18 THEN
        UPDATE CLASSIFICACAO SET JOVENS = JOVENS - 1;
    ELSEIF OLD.IDADE > 18 THEN
        UPDATE CLASSIFICACAO SET ADULTOS = ADULTOS - 1;
    END IF;
    
    -- Verifica a nova idade do aluno e atualiza a tabela CLASSIFICACAO com base na nova idade
    IF NEW.IDADE < 10 THEN
        UPDATE CLASSIFICACAO SET CRIANCAS = CRIANCAS + 1;
    ELSEIF NEW.IDADE >= 10 AND NEW.IDADE < 18 THEN
        UPDATE CLASSIFICACAO SET JOVENS = JOVENS + 1;
    ELSEIF NEW.IDADE > 18 THEN
        UPDATE CLASSIFICACAO SET ADULTOS = ADULTOS + 1;
    END IF;
END $$

-- Define um novo delimitador para criar o gatilho TR_ALUNO_BI que é acionado antes da inserção de um aluno na tabela ALUNO
DELIMITER $$
CREATE TRIGGER TR_ALUNO_BI BEFORE INSERT ON ALUNO FOR EACH ROW
BEGIN
    -- Verifica se a idade é válida (não é negativa e não é nula)
    IF NEW.IDADE < 0 OR NEW.IDADE IS NULL THEN
        -- Lança um erro com uma mensagem personalizada se a idade for inválida
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Campo idade é inválido';
    END IF;
END $$

-- Restaura o delimitador padrão
DELIMITER ;

-- Insere dados na tabela ALUNO para testar os gatilhos
INSERT INTO ALUNO (NOME, IDADE) VALUES ('CARLOS', 19);
INSERT INTO ALUNO (NOME, IDADE) VALUES ('MATIAS', 18);
INSERT INTO ALUNO (NOME, IDADE) VALUES ('LUDMILLO', 17);
INSERT INTO ALUNO (NOME, IDADE) VALUES ('AYRTON', 8);

-- Exclui um aluno com nome 'MATIAS'
DELETE FROM ALUNO WHERE NOME = 'MATIAS';

-- Atualiza a idade de um aluno com nome 'AYRTON'
UPDATE ALUNO SET IDADE = 19 WHERE NOME = 'AYRTON';

-- Seleciona todas as linhas da tabela ALUNO
SELECT * FROM ALUNO;

-- Seleciona todas as linhas da tabela CLASSIFICACAO
SELECT * FROM CLASSIFICACAO;