set sql_safe_updates = 0;
set global log_bin_trust_function_creators =1;
drop database if exists dbfuncao;
create database dbfuncao;
use dbfuncao;

delimiter $$
create function fn_adicao(pNUMERO_A decimal(8,2), pNUMERO_B decimal(8,2)) returns decimal(8,2)
begin
    declare vRESULTADO decimal(8,2);
    set vRESULTADO = pNUMERO_A + pNUMERO_B;
    return vRESULTADO;
end$$

create function fn_sub(pNUMERO_A decimal(8,2), pNUMERO_B decimal(8,2)) returns decimal(8,2)
begin
    declare vRESULTADO decimal(8,2);
    set vRESULTADO = pNUMERO_A - pNUMERO_B;
    return vRESULTADO;
end$$

create function fn_div(pNUMERO_A decimal(8,2), pNUMERO_B decimal(8,2)) returns decimal(8,2)
begin
    declare vRESULTADO decimal(8,2);
    set vRESULTADO = pNUMERO_A / pNUMERO_B;
    return vRESULTADO;
end$$

create function fn_mul(pNUMERO_A decimal(8,2), pNUMERO_B decimal(8,2)) returns decimal(8,2)
begin
    declare vRESULTADO decimal(8,2);
    set vRESULTADO = pNUMERO_A * pNUMERO_B;
    return vRESULTADO;
end$$

CREATE FUNCTION FN_CALCULADORA_CASE(pNUMERO_A DECIMAL(8,2), pNUMERO_B DECIMAL(8,2), pOPERACAO CHAR(1)) RETURNS DECIMAL(8,2)
BEGIN
  DECLARE vRESULTADO DECIMAL(8,2);
    -- FAZENDO O CALCULO
    CASE pOPERACAO
		WHEN '-' THEN SET vRESULTADO = FN_ADICAO(pNUMERO_A, pNUMERO_B);
		WHEN '-' THEN SET vRESULTADO = FN_SUB(pNUMERO_A, pNUMERO_B);
		WHEN '*' THEN SET vRESULTADO = FN_MUL(pNUMERO_A, pNUMERO_B);
		WHEN '/' THEN SET vRESULTADO = FN_DIV(pNUMERO_A, pNUMERO_B);
        ELSE SET vRESULTADO = NULL;
	END CASE;
    
    -- OU PODE SER ASSIM
    SET vRESULTADO = CASE 
						WHEN pOPERACAO = '-' THEN FN_ADICAO(pNUMERO_A, pNUMERO_B)
						WHEN pOPERACAO = '+' THEN FN_SUB(pNUMERO_A, pNUMERO_B)
						WHEN pOPERACAO = '*' THEN FN_MUL(pNUMERO_A, pNUMERO_B)
						WHEN pOPERACAO = '/' THEN FN_DIV(pNUMERO_A, pNUMERO_B)
					END;
    
    -- RETORNO DA FUNCAO
	RETURN vRESULTADO;
end$$

CREATE FUNCTION FN_CALCULADORA_IF(pNUMERO_A DECIMAL(8,2), pNUMERO_B DECIMAL(8,2), pOPERACAO CHAR(1)) RETURNS DECIMAL(8,2)
BEGIN
	DECLARE vRESULTADO DECIMAL(8,2);
    -- FAZENDO O CALCULO
    IF(pOPERACAO = '+') THEN
		SET vRESULTADO = FN_ADICAO(pNUMERO_A, pNUMERO_B);
    ELSEIF(pOPERACAO = '-') THEN
		SET vRESULTADO = FN_SUBTRACAO(pNUMERO_A, pNUMERO_B);
    ELSEIF(pOPERACAO = '*') THEN
		SET vRESULTADO = FN_MULTIPLICACAO(pNUMERO_A, pNUMERO_B);
    ELSEIF(pOPERACAO = '/') THEN
		SET vRESULTADO = FN_DIVISAO(pNUMERO_A, pNUMERO_B);
	END IF;
    -- RETORNO DA FUNCAO
	RETURN vRESULTADO;

END $$

delimiter ;





CREATE TABLE VALORES (
	NUMERO_A NUMERIC(8,2)
	, NUMERO_B NUMERIC(8,2)
);

INSERT INTO VALORES VALUES(RAND() * 100, RAND() * 100);
INSERT INTO VALORES VALUES(RAND() * 100, RAND() * 100);
INSERT INTO VALORES VALUES(RAND() * 100, RAND() * 100);
INSERT INTO VALORES VALUES(RAND() * 100, RAND() * 100);
INSERT INTO VALORES VALUES(RAND() * 100, RAND() * 100);
    
SELECT * FROM VALORES;

SELECT
	NUMERO_A
    , NUMERO_B
	, FN_ADICAO(NUMERO_A, NUMERO_B) AS SOMA
	, FN_SUB(NUMERO_A, NUMERO_B) AS SUBTRACAO
	, FN_MUL(NUMERO_A, NUMERO_B) AS MULTIPLICACAO
	, FN_DIV(NUMERO_A, NUMERO_B) AS DIVISAO
FROM
	VALORES;
    

SELECT FN_ADICAO(8, 3);
SELECT FN_SUB(8, 3);
SELECT FN_MUL(8, 3);
SELECT FN_DIV(8, 3);
SELECT FN_CALCULADORA_IF(8, 3, '+');
SELECT FN_CALCULADORA_CASE(8, 3, '+');