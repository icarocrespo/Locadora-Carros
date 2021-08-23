{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.IO
import System.Directory
import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow


-- CRIAÇÃO DAS TADs

data Cliente = Cliente {
nome :: String,
cnh :: String,
pontuacao :: Integer
} deriving (Show)


data Carro = Carro {
placa :: String,
quilometragem :: Double,
categoria :: Char
} deriving (Show)

--data Alocacao = Alocacao {
--nome_cliente :: String,
--placa_carro :: String,
--data_alocacao :: Integer, -- até arrumar a importação de Date
--data_devolucao :: Integer -- até arrumar a importação de Date
--} deriving (Show)


data Alugado = Alugado {
 nome_Cliente :: String,
 cnh_cliente :: Integer,
 cat_carro :: Char,
 placa_carro :: String,
 km_carro :: Float,
 data_ret :: String
} deriving (Show)

main :: IO ()
main = do
    menuPPrint

-- MENU PRINCIPAL
menuPPrint :: IO ()
menuPPrint = do
    putStrLn "----------------------------------------"
    putStrLn "Menu Principal"
    putStrLn "----------------------------------------"
    putStrLn "Selecione a opção desejada"
    putStrLn "----------------------------------------"
    putStrLn "1. Menu Clientes"
    putStrLn "2. Menu Veículos"
    putStrLn "3. Menu Locações"
    putStrLn "0. Sair"
    putStrLn "\nOpcao: "
    op <- getLine
    if(read op) == 0
        then putStrLn("Sistema Finalizado.")
        else do opSelecionada (read op)

-- MENU CLIENTE
menuCPrint :: IO()
menuCPrint = do
    putStrLn "----------------------------------------"
    putStrLn " Menu Clientes"
    putStrLn "----------------------------------------"
    putStrLn "4. Cadastrar novo cliente"
    putStrLn "5. Excluir cadastro de cliente"
    putStrLn "6. Consultar cliente"
    putStrLn "0. Retornar ao menu inicial"
    op <- getLine
    if(read op) == 0
      then menuPPrint
      else do opSelecionada(read op)

-- MENU VEÍCULOS
menuVPrint :: IO()
menuVPrint = do
    putStrLn "----------------------------------------"
    putStrLn " Menu Veículos"
    putStrLn "----------------------------------------"
    putStrLn "7. Cadastrar novo veículo"
    putStrLn "8. Excluir veículo cadastrado"
    putStrLn "9. Consultar veículo cadastrado"
    op <- getLine
    if(read op) == 0
      then menuPPrint
      else do opSelecionada(read op)

-- MENU LOCAÇÃO
menuLPrint :: IO()
menuLPrint = do
    putStrLn "----------------------------------------"
    putStrLn " Menu Locação"
    putStrLn "----------------------------------------"
    putStrLn "10. Realizar nova locação"
    putStrLn "11. Encerrar locação"
    putStrLn "12. Consultar locação"
    putStrLn "0. sair"
    op <- getLine
    if(read op) == 0
      then menuPPrint
      else do opSelecionada(read op)

-- SELECAO DE OPCAO
opSelecionada :: Int -> IO()
opSelecionada op
 | op == 1 = do {menuCPrint}
 | op == 2 = do {menuVPrint}
 | op == 3 = do {menuLPrint}
 | op == 4 = do {cadastroCliente}
 | op == 5 = do {excluirCliente}
 | op == 6 = do {consultaCliente}
 | op == 7 = do {cadastroCarro}
 | op == 8 = do {excluirCarro}
 | op == 9 = do {consultaCarro}
 | op == 10 = do {registrarRetirada}
 | op == 11 = do {registrarDevolucao}
 | otherwise = do {putStrLn"Opção Inválida, tente novamente"; menuPPrint}


-- CLIENTES

-- CADASTRO DE CLIENTE
cadastroCliente :: IO ()
cadastroCliente = do
  printEspaco
  putStrLn "Informe seu nome : "
  nome <- getLine
  putStrLn "Informe o CNH: "
  cnh <- getLine
  putStrLn " Programa Fidelidade (Pontuação):  "
  pontuacao <- getLine
  printEspaco

  --CONSULTAR CLIENTE
consultaCliente :: IO()
consultaCliente =  do
    printEspaco
    putStrLn "Informe o nome do Cliente : "
    consultaNome <- getLine
    printEspaco
    if(read consultaNome == nome)
    then infoCliente
     else do
        putStrLn "Cliente não cadastrado "
        printEspaco

-- EXCLUIR CLIENTE
excluirCliente :: IO()
excluirCliente = do
 printEspaco
 putStrLn "Informe a CNH do Cliente : "
 cnh <- getLine
 putStrLn "TO DO"
 printEspaco

-- CARROS

-- CADASTRO DE CARRO
cadastroCarro :: IO ()
cadastroCarro = do
  printEspaco
  putStrLn "Informe a Placa do Carro : "
  placa <- getLine
  putStrLn "Informe a Categoria: "
  categoria <- getLine
  putStrLn " Informe o Genero:  "
  genero <- getLine
  putStrLn " Informe a Quilometragem:  "
  quilometragem  <- getLine
  printEspaco

  --CONSULTAR CARRO
consultaCarro :: IO()
consultaCarro = do
  printEspaco
  putStrLn "Informe a placa do Carro : "
  consultaPlaca <- getLine
  printEspaco
  if(read consultaPlaca == placa)
    then infoCarro
      else do
        putStrLn "Carro não cadastrado "
        printEspaco

-- EXCLUIR CARRO
excluirCarro :: IO()
excluirCarro = do
 printEspaco
 putStrLn "Informe a placa do carro : "
 placa <- getLine
 putStrLn "TO DO"
 printEspaco

-- REGISTRAR RETIRADA
registrarRetirada :: IO ()
registrarRetirada = do
  printEspaco
  putStrLn "Informe o Nome do Cliente : "
  nome <- getLine
  putStrLn "Informe o CNH: "
  cnh <- getLine
  putStrLn "Categoria do Veículo: "
  categoria <- getLine
  putStrLn "Placa do Veículo: "
  placa_carro <- getLine
  putStrLn "Quilometragem do Veículo: "
  quilometragem <- getLine
  putStrLn "Data da Retirada: "
  data_locacao <- getLine
  printEspaco

  --verificando cliente
  --"SELECT nome, cnh
  --FROM cliente
  --WHERE chn = :cnh_cliente"
  --[":cnh_cliente" := cnh]

  --verificando a placa
  --"SELECT categoria, placa_carro, quilometragem
  --FROM carros
  --WHERE placa_carro = :placa"
  --[":placa" := placa]

  --verificando a placa
  --"SELECT nome, cnh
  --FROM carros, cliente
  --WHERE placa_carro = :placa, chn = :cnh_cliente"
  --[":placa" := placa, ":cnh_cliente" := cnh]

  --alterar status no bd: 1 indisponível; 0 disponível
  --UPDATE CARROS
  --SET status = 1
  --WHERE placa_carro = :placa"
  --[":placa" := placa]

-- REGISTRAR DEVOLUÇÃO
registrarDevolucao :: IO ()
registrarDevolucao = do
 putStr("\n Placa do veiculo: ")
 placa <- getLine
 --putStr("\n Placa do veiculo: "++ placa)
 putStr("\n Quilometragem do veiculo: ")
 km <- getLine
-- putStr("\n Quilometragem do veiculo: "++ km)
 putStr("\n Data de devolucao: ")
 dataDev <- getLine
 --putStr("\n Data de devolucao: " ++ dataDev)
 printEspaco
 if percorreLista registro
   then comparaLista placa registro
     registro [(cliente, cnh, cate, placa, km, data)]
     putStr("\n Cliente: " ++ cliente)
     putStr("\n CNH: " ++ cnh)
     putStr("\n Categoria: " ++ cate)
     putStr("\n Placa: " ++ placa)
     putStr("\n Km: " ++ km)
     putStr("\n Data: " ++ data")
 else putStr("\n vazia)

 --verificando a placa
 --"SELECT *
 --FROM carros
 --WHERE placa_carro = :placa"
 --[":placa" := placa]

 --set quilometragem
 --"UPDATE carros
 --SET quilometragem = :quilom
 --WHERE placa_carro = :placa
 --[":quilom" := quilom, ":placa" = placa]

 --alterar status no bd: 1 indisponível; 0 disponível
 --UPDATE CARROS
 --SET status = 0
 --WHERE placa_carro = :placa"
 --[":placa" := placa]

-- FUNÇÃO PARA QUEBRA DE LINHA
printEspaco :: IO()
printEspaco = putStrLn "\n"


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
type CadasCliente = (String, Int, Integer)
type Clientes = [CadasCliente]

cadasCliente :: Clientes
cadasCliente =
  [("Ketrin", 123456, 2),
    ("Bruna", 78910, 4),
    ("Icaro", 111213, 5),
    ("Marina", 151617, 6)]

type CadasCarro = ( String,  Double , String , Char)
type Carros = [CadasCarro]

cadasCarro :: Carros
cadasCarro =
  [("JKL-1234", 60.0 , "Camaro" , 'B' ),
  ("DEF-1234", 60.0 , "Scooter" , 'A' ),
  ("JRL-1234", 60.0 , "Ferrari" , 'B' ),
  ("GHI-1234", 60.0 , "CB300" , 'A' )]

type Registro = (String, Integer, Char, String, Float, String )
type Registros = [Registro]

registro :: Registros
registro =
  [ ("Ketrin", 123456, 'B', "JKL-1234", 60.0 , "20/05/2020"),
  ("Bruna", 78910,  'A', "DEF-1234", 60.0, "21/05/2020"),
  ("Icaro", 789653, 'C', "JRL-1234", 60.0, "27/05/2020"),
  ("Marina", 154236, 'C',  "GHI-1234", 60.0, "26/05/2020")]

calculoLocacao :: Integer -> Integer -> IO()
calculoLocacao = do
  -- pegar do Banco
  putStrLn("Valor da diária")
  valor_diaria <- getLine
  -- pegar do Banco
  putStrLn("Quantidade de dias")
  dias <- getLine
  valor_diaria * dias
  -- pegar do Banco
  putStrLn("Quilometragem")
  quilometragem <- getLine
  -- pegar do Banco
  putStrLn("Valor da quilometragem da categoria")
  valor_quilometragem <- getLine

  quilometragem * valor_quilometragem


-- CHAMAR FUNÇÃO PARA ALTERAR DADO DO CARRO NO BANCO DE DADOS


programaFidelidade :: Integer -> IO()
programaFidelidade = do
  -- pegar do Banco
  putStrLn("Quantidade de quilômetros")
  quilometros <- getLine
  pontos <- quilometros % 100
  -- persistir no Banco
  -- cliente.fidelidade += pontos

--criação de lista para exibir dados de consulta

listarAlugado :: [Alugado] -> String
listarAlugado [ ] = ""
listarAlugado (x : xs) = infoAlogado x ++ ['\n'] ++ infoAlogado xs

listarClientes :: [Cliente] -> String
listarClientes [ ] = ""
listarClientes (x: xs) = infoCliente x ++ ['\n'] ++ infoCliente xs

listarCarro :: [Carro] -> String
listarCarro[ ] = ""
listarCarro (x: xs) = infoCarro x ++ ['\n'] ++ infoCarro xs

infoCliente :: Cliente  -> String
infoCliente cliente=" Nome do Cliente: " ++ (nome cliente) ++ [ '\n'] ++ "CNH : " ++ (cnh cliente) ++ [ '\n'] ++ "Programa Fidelidade (Pontuação): " ++ (pontuacao cliente)

infoCarro :: Carro -> String
infoCarro carro = "Placa do Carro : " ++ (placa carro) ++ [ '\n'] ++ "Categoria: " ++ (categoria carro) ++ [ '\n'] ++ "Genero: " ++ (genero carro) ++ [ '\n'] ++ "Quilometragem : " ++ (quilometragem carro)

infoAlogado :: Alugado -> String
infoAlogado alugado = "Nome do Cliente: " ++ (n alugado) ++ ['\n'] ++ "CNH: " ++ (cnh alugado) ++ ['\n'] ++ "Categoria do veículo: " ++ (cr alugado) ++ ['\n'] ++ "Placa do veículo: " ++ (p alugado) ++ ['\n' ] ++  "Quilometragem do veiculo: " ++ (k alugado) ++ ['\n'] ++ "Data da Retirada:" ++ (dr alugado)


-- BANCO DE DADOS / SCRIPTS


data TestField = TestField Int String deriving (Show)

instance FromRow TestField where
  fromRow = TestField <$> field <*> field

-- CLIENTE

insert_Cliente :: IO ()
insert = do
  conn <- open "locadora.db"
  execute conn "INSERT INTO cliente (cnh, nome, pontuacao) VALUES (?, ?, ?)"
    (Only ("cliente cnh" :: String), ("cliente nome" :: String), ("cliente pontuacao" :: Integer))
  close conn

update_Cliente :: IO ()
update_Cliente = do
  conn <- open "locadora.db"
  execute conn "UPDATE cliente (cnh, nome, pontuacao) VALUES (?, ?, ?) WHERE cnh = X"
    (Only ("cliente cnh" :: String), ("cliente nome" :: String), ("cliente pontuacao" :: Integer))
  close conn

select_Cliente :: IO ()
select_Cliente = do
  conn <- open "locadora.db"
  r <- query_ conn "SELECT * from cliente" :: IO [TestField]
  close conn

delete_Cliente :: IO ()
delete_Cliente = do
  conn <- open "locadora.db"
  execute conn "DELETE FROM cliente (str) VALUES (?) WHERE"
    (Only ("locadora string 2" :: String))
  close conn


-- CARRO

insert_Carro :: IO ()
insert_Carro = do
  conn <- open "locadora.db"
  execute conn "INSERT INTO carro (placa, quilometragem, categoria) VALUES (?, ?, ?)"
    (Only ("carro placa" :: String), ("ccarro quilometragem" :: Integer), ("carro categoria" :: Integer))
  close conn

update_Carro :: IO ()
update_Carro = do
  conn <- open "locadora.db"
  execute conn "UPDATE carro (placa, quilometragem, categoria) VALUES (?, ?, ?) WHERE placa = placa"
    (Only ("carro placa" :: String), ("ccarro quilometragem" :: Integer), ("carro categoria" :: Integer))
  close conn

select_Carro :: IO ()
select_Carro = do
  conn <- open "locadora.db"
  r <- query_ conn "SELECT * from cliente" :: IO [TestField]
  close conn

delete_Carro :: IO ()
delete_Carro = do
  conn <- open "locadora.db"
  execute conn "DELETE FROM cliente (str) VALUES (?) WHERE"
    (Only ("locadora string 2" :: String))
  close conn