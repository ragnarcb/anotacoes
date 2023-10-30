-- Desativando a configuração que impede atualizações inseguras
SET SQL_SAFE_UPDATES = 0;

-- Excluindo o banco de dados DBESTATISTICA se ele existir
DROP DATABASE IF EXISTS DBESTATISTICA;

-- Criando o banco de dados DBESTATISTICA
CREATE DATABASE DBESTATISTICA;

-- Usando o banco de dados DBESTATISTICA
USE DBESTATISTICA;

-- Criando a tabela PESSOA para armazenar informações sobre pessoas
CREATE TABLE PESSOA (
    IDPESSOA INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Identificador único da pessoa
    NOME VARCHAR(45),  -- Nome da pessoa
    SEXO CHAR(1)  -- Gênero da pessoa (F para feminino, M para masculino)
);

-- Criando a tabela ESTATISTICA para armazenar estatísticas de homens e mulheres
CREATE TABLE ESTATISTICA (
    HOMEM INT, -- Contador de homens
    MULHER INT  -- Contador de mulheres
);

-- Inserindo uma linha na tabela ESTATISTICA para rastrear a quantidade de pessoas
INSERT INTO ESTATISTICA VALUES (0, 0);

-- Definindo um novo delimitador para criar triggers
DELIMITER $$

-- Criando um gatilho (trigger) TR_PESSOA_AI que é acionado após a inserção de uma nova pessoa na tabela PESSOA
CREATE TRIGGER TR_PESSOA_AI AFTER INSERT ON PESSOA FOR EACH ROW
BEGIN
    -- Verificando o valor do campo SEXO na nova pessoa
    IF NEW.SEXO = 'F' THEN
        -- Atualizando a tabela ESTATISTICA para aumentar o contador de mulheres
        UPDATE ESTATISTICA SET MULHER = MULHER + 1;
    ELSEIF NEW.SEXO = 'M' THEN
        -- Atualizando a tabela ESTATISTICA para aumentar o contador de homens
        UPDATE ESTATISTICA SET HOMEM = HOMEM + 1;
    END IF;
END $$

-- Criando um gatilho TR_PESSOA_AD que é acionado após a exclusão de uma pessoa na tabela PESSOA
CREATE TRIGGER TR_PESSOA_AD AFTER DELETE ON PESSOA FOR EACH ROW
BEGIN
    -- Verificando o valor do campo SEXO na pessoa excluída
    IF OLD.SEXO = 'F' THEN
        -- Atualizando a tabela ESTATISTICA para diminuir o contador de mulheres
        UPDATE ESTATISTICA SET MULHER = MULHER - 1;
    ELSEIF OLD.SEXO = 'M' THEN
        -- Atualizando a tabela ESTATISTICA para diminuir o contador de homens
        UPDATE ESTATISTICA SET HOMEM = HOMEM - 1;
    END IF;
END $$

-- Criando um gatilho TR_PESSOA_AU que é acionado após a atualização de uma pessoa na tabela PESSOA
CREATE TRIGGER TR_PESSOA_AU AFTER UPDATE ON PESSOA FOR EACH ROW
BEGIN
    -- Verificando o valor antigo do campo SEXO
    IF OLD.SEXO = 'F' THEN
        -- Atualizando a tabela ESTATISTICA para diminuir o contador de mulheres
        UPDATE ESTATISTICA SET MULHER = MULHER - 1;
    ELSEIF OLD.SEXO = 'M' THEN
        -- Atualizando a tabela ESTATISTICA para diminuir o contador de homens
        UPDATE ESTATISTICA SET HOMEM = HOMEM - 1;
    END IF;

    -- Verificando o novo valor do campo SEXO
    IF NEW.SEXO = 'F' THEN
        -- Atualizando a tabela ESTATISTICA para aumentar o contador de mulheres
        UPDATE ESTATISTICA SET MULHER = MULHER + 1;
    ELSEIF NEW.SEXO = 'M' THEN
        -- Atualizando a tabela ESTATISTICA para aumentar o contador de homens
        UPDATE ESTATISTICA SET HOMEM = HOMEM + 1;
    END IF;
END $$

-- Criando um gatilho TR_PESSOA_BI que é acionado antes da inserção de uma pessoa na tabela PESSOA
CREATE TRIGGER TR_PESSOA_BI BEFORE INSERT ON PESSOA FOR EACH ROW
BEGIN
    -- Verificando se o valor do campo SEXO é inválido (não é 'F' ou 'M' ou é nulo)
    IF (NEW.SEXO NOT IN ('F', 'M')) OR (NEW.SEXO IS NULL) THEN
        -- Lançando um erro com uma mensagem personalizada
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Campo sexo é inválido';
    END IF;
END $$

-- Criando um gatilho TR_PESSOA_BU que é acionado antes da atualização de uma pessoa na tabela PESSOA
CREATE TRIGGER TR_PESSOA_BU BEFORE UPDATE ON PESSOA FOR EACH ROW
BEGIN
    -- Verificando se o valor do campo SEXO é inválido (não é 'F' ou 'M' ou é nulo)
    IF (NEW.SEXO NOT IN ('F', 'M')) OR (NEW.SEXO IS NULL) THEN
        -- Lançando um erro com uma mensagem personalizada
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Campo sexo é inválido';
    END IF;
END $$

-- Restaurando o delimitador padrão
DELIMITER ;

-- Selecionando todas as linhas da tabela PESSOA
SELECT * FROM PESSOA;

-- Selecionando todas as linhas da tabela ESTATISTICA
SELECT * FROM ESTATISTICA;

-- Inserindo uma pessoa de nome 'ANA' e gênero 'F' na tabela PESSOA
INSERT INTO PESSOA(NOME, SEXO) VALUES('ANA', 'F');

-- Inserindo uma pessoa de nome 'JOAO' e gênero 'M' na tabela PESSOA
INSERT INTO PESSOA(NOME, SEXO) VALUES('JOAO', 'M');

-- Excluindo a pessoa de nome 'JOAO' da tabela PESSOA
DELETE FROM PESSOA WHERE NOME = 'JOAO';

-- Atualizando o gênero da pessoa de nome 'ANA' para 'M' na tabela PESSOA
UPDATE PESSOA SET SEXO = 'M' WHERE NOME = 'ANA';
