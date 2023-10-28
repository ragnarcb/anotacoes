set sql_safe_updates =0;
DROP DATABASE IF EXISTS DBCOTACAO;
CREATE DATABASE DBCOTACAO;
USE DBCOTACAO;

CREATE TABLE COTACAO (
	IDCOTACAO INT NOT NULL AUTO_INCREMENT
    , DTCOTACAO DATE
    , VALOR NUMERIC(8,2)
    , PRIMARY KEY (IDCOTACAO)
);

CREATE TABLE PRODUTO (
	IDPRODUTO INT NOT NULL AUTO_INCREMENT
    , NOME VARCHAR(45)
    , VALOR NUMERIC(8,2)
    , PRIMARY KEY(IDPRODUTO)
);

CREATE TABLE VENDA (
	IDVENDA INT NOT NULL AUTO_INCREMENT
    , IDPRODUTO INT NOT NULL
    , DTVENDA DATE
    , VALOR_REAL NUMERIC(8,2)
    , VALOR_DOLAR NUMERIC(8,2)
    , PRIMARY KEY (IDVENDA)
    , FOREIGN KEY (IDPRODUTO) REFERENCES PRODUTO (IDPRODUTO)
    );

delimiter $$

create trigger tr_venda_b_i before insert on venda for each row
begin
	-- declarando as variaveis
    declare vVALOR numeric(8,2);
    declare vDOLAR numeric(8,2);
    declare vQTD_COTACAO int;
    
    -- buscando a quantidade de cotacao para a data informada
    select count(dtcotacao)
    into vQTD_COTACAO
    from cotacao 
    where dtcotacao = new.dtvenda;
    
-- verificando se existe apenas 1 cotacao para a data informada
if(vQTD_COTACAO = 1) then
    
    -- buscando o valor do produto na tabela de produtos
    select valor
    into vVALOR
    from produto
    where idproduto = new.idproduto;
	
    -- buscando a cotacao do dolar para a data da venda
    select valor
    into vDOLAR
    from cotacao
    where dtcotacao = new.dtvenda;
    
    set new.valor_real = vVALOR;
    set new.valor_dolar = vVALOR / vDOLAR;
else
	signal sqlstate '45000'
	set message_text = 'erro';
end if;
end $$

delimiter ;

INSERT INTO PRODUTO (NOME, VALOR)VALUES('CELULAR', 200);
INSERT INTO PRODUTO (NOME, VALOR)VALUES('TABLET', 350);

INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL -5 DAY)), 4.09 - 0.55);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL -4 DAY)), 4.09 - 0.45);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL -3 DAY)), 4.09 - 0.35);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL -2 DAY)), 4.09 - 0.25);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL -1 DAY)), 4.09 - 0.15);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL  0 DAY)), 4.09 - 0.05);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL  1 DAY)), 4.09 + 0.15);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL  2 DAY)), 4.09 + 0.25);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL  3 DAY)), 4.09 + 0.35);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL  4 DAY)), 4.09 + 0.45);
INSERT COTACAO(DTCOTACAO, VALOR)VALUES(DATE(DATE_ADD(NOW(), INTERVAL  5 DAY)), 4.09 + 0.55);


insert into venda (idproduto, dtvenda, valor_real)
values(1, '2023-10-28', 10);


select * from cotacao where dtcotacao = '2023-10-28';
select * from produto;
select * from venda;





/*
QUESTÃO:
1. SÓ PODE INCLUIR VENDA, SE TIVER COTAÇÃO PARA A DATA DA VENDA

2. QUANDO UM PRODUTO FOR INCLUÍDO OU ALTERADO O VALOR DO PRODUTO 
EM DÓLAR CALCULADO COM BASE NA COTAÇÃO, PARA LOCALIZAR A COTAÇÃO COMPARE A DATA DE VENDA COM A DATA DA COTACAO;
*/



