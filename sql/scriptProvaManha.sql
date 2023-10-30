-- Exclui o banco de dados DBIMPOSTO se ele existir
DROP DATABASE IF EXISTS DBIMPOSTO;

-- Cria o banco de dados DBIMPOSTO
CREATE DATABASE DBIMPOSTO;

-- Usa o banco de dados DBIMPOSTO
USE DBIMPOSTO;

-- Cria a tabela PRODUTO para armazenar informações sobre produtos, incluindo o ICMS aplicado
CREATE TABLE PRODUTO (
    IDPRODUTO INT NOT NULL AUTO_INCREMENT, -- Identificador único do produto
    NOME VARCHAR(45),  -- Nome do produto
    ESTADO CHAR(2),  -- Estado onde o produto está à venda
    VALOR NUMERIC(8,2),  -- Valor do produto
    ICMS_PERCENTUAL NUMERIC(8,2),  -- Percentual de ICMS a ser aplicado
    ICMS_VALOR NUMERIC(8,2),  -- Valor do ICMS calculado
    PRIMARY KEY(IDPRODUTO)
);

-- Cria a tabela BASE_ICMS para armazenar os percentuais de ICMS por estado
CREATE TABLE BASE_ICMS (
    ESTADO CHAR(2) NOT NULL,  -- Sigla do estado
    ICMS_PERCENTUAL NUMERIC(8,2),  -- Percentual de ICMS por estado
    PRIMARY KEY(ESTADO)
);

-- Define um novo delimitador para criar gatilhos (triggers)
DELIMITER $$

-- Cria um gatilho (trigger) CR_PRODUTO_BI que é acionado antes da inserção de um produto na tabela PRODUTO
CREATE TRIGGER CR_PRODUTO_BI BEFORE INSERT ON PRODUTO FOR EACH ROW
BEGIN
    DECLARE vIMPOSTO NUMERIC(8,2);
    DECLARE vQTDE INT;

    -- Verifica se o estado existe na tabela BASE_ICMS
    SELECT COUNT(ICMS_PERCENTUAL)
    INTO vQTDE
    FROM BASE_ICMS
    WHERE ESTADO = NEW.ESTADO;

    IF vQTDE = 1 THEN
        -- O estado existe, recupera o ICMS_PERCENTUAL
        SELECT ICMS_PERCENTUAL
        INTO vIMPOSTO
        FROM BASE_ICMS
        WHERE ESTADO = NEW.ESTADO;

        -- Define o ICMS_PERCENTUAL do novo produto e calcula o ICMS_VALOR com base no valor do produto
        SET NEW.ICMS_PERCENTUAL = vIMPOSTO;
        SET NEW.ICMS_VALOR = NEW.VALOR * (vIMPOSTO / 100);
    ELSE 
        -- Lança um erro com uma mensagem personalizada se o estado não existe na tabela BASE_ICMS
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Campo de estado é inválido';
    END IF;
END $$

-- Cria um gatilho CR_PRODUTO_BU que é acionado antes da atualização de um produto na tabela PRODUTO
CREATE TRIGGER CR_PRODUTO_BU BEFORE UPDATE ON PRODUTO FOR EACH ROW
BEGIN
    DECLARE vIMPOSTO NUMERIC(8,2);
    DECLARE vQTDE INT;

    -- Verifica se o estado existe na tabela BASE_ICMS
    SELECT COUNT(ICMS_PERCENTUAL)
    INTO vQTDE
    FROM BASE_ICMS
    WHERE ESTADO = NEW.ESTADO;

    IF vQTDE = 1 THEN
        -- O estado existe, recupera o ICMS_PERCENTUAL
        SELECT ICMS_PERCENTUAL
        INTO vIMPOSTO
        FROM BASE_ICMS
        WHERE ESTADO = NEW.ESTADO;

        -- Define o ICMS_PERCENTUAL do produto atualizado e recalcula o ICMS_VALOR com base no valor do produto
        SET NEW.ICMS_PERCENTUAL = vIMPOSTO;
        SET NEW.ICMS_VALOR = NEW.VALOR * (vIMPOSTO / 100);
    ELSE 
        -- Lança um erro com uma mensagem personalizada se o estado não existe na tabela BASE_ICMS
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Campo de estado é inválido';
    END IF;
END $$

-- Restaura o delimitador padrão
DELIMITER ;

-- Insere valores na tabela BASE_ICMS para definir os percentuais de ICMS por estado
INSERT INTO BASE_ICMS VALUES('AC', 17);
INSERT INTO BASE_ICMS VALUES('AL', 18);
-- ...

-- Exercício:
-- Insere produtos na tabela PRODUTO e verifica se o ICMS é calculado corretamente

-- Seleciona todas as linhas da tabela PRODUTO
SELECT * FROM PRODUTO;

-- Seleciona todas as linhas da tabela BASE_ICMS
SELECT * FROM BASE_ICMS;
