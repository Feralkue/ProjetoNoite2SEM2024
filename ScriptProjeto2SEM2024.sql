create table Catalogos(
Id_Catalogo int primary  key,
Disponibilidade varchar2(3) not null,
Id_Produto int not null
);

alter table Catalogos
add constraint chk_Disp check (Disponibilidade = 'Sim' or Disponibilidade = 'Não');

alter table Catalogos
add foreign key (Id_Produto)
references Produtos(Id_Produto)

create table Produtos(
Id_Produto int primary key,
Nome varchar2(30) not null,
Descricao varchar2(150),
Preco number(7,2) not null
);

create table Usuarios(
Id_Usuario int primary key,
Nome varchar2(40) not null,
CPF varchar2(14) not null
);

create table Carrinho(
Id_Carrinho int primary key,
Nome varchar2(30) not null,
Preco number(7,2) not null,
Quantidade int not null,
Id_Produto int not null,
Id_Usuario int not null
);

alter table Carrinho
add foreign key (Id_Produto)
references Produtos(Id_Produto)

alter table Carrinho
add foreign key (Id_Usuario)
references Usuarios(Id_Usuario)

create table Faturamento(
Id_Faturamento int primary key,
Status varchar2(300) not null,
Nome varchar2(30) not null,
Id_Produto int not null,
Id_Usuario int not null
);

alter table Faturamento
add constraint chk_Status Check (Status = 'Efetuado' or Status = 'Aguardando Pagamento' or Status = 'Pagamento Efetuado' or Status = 'Preparando entrega'or Status = 'Transportadora' or Status = 'Pedido Entregue');

alter table Faturamento
add foreign key (Id_Produto)
references Produtos(Id_Produto)

alter table Faturamento
add foreign key (Id_Usuario)
references Usuarios(Id_Usuario)

create table log(
Id_log int primary key,
Nome_tab varchar2(50) not null,
Operacao varchar2(10) not null,
Id int not null,
valor_atual varchar2(500),
valor_novo varchar2(500)
)

create or replace trigger inserts_cat
before insert on Catalogos
for each row
begin
    insert into log(Nome_tab,Operacao,Id) values('catalogo','insert',:new.Id_Catalogo);
end;
 
 create or replace trigger updates_cat
 before update on Catalogos
 for each row
 begin
    insert into log (Nome_tab, Operacao, Id, valor_atual, valor_novo) values ('Catalogo','Upadate', :old.Id_Catalogo, :old.disponibilidade, :new.disponibilidade);
end;

create or replace trigger deletes_cat
before delete on Catalogos
for each row
begin
    insert into log(Nome_tab, Operacao, Id) values('Catalogo', 'Delete', :old.Id_Catalogo);
end;

create or replace trigger inserts_produto
after insert on Produtos
for each row
begin 
    insert into log(Nome_tab, Operacao, Id) values('Produtos', 'Insert', :new.Id_Produto);
end;

 create or replace trigger updates_produto
 before update on Produtos
 for each row
 begin
    insert into log (Nome_tab, Operacao, Id) values ('Produtos','Upadate', :old.Id_Produto);
end;

create or replace trigger delete_produto
after delete on Produtos
for each row
begin
    insert into log(Nome_tab, Operacao, Id) values ('Produtos', 'Delete', :old.Id_Produto);
end;

create or replace trigger inserts_usuario
after insert on Usuarios
for each row
begin 
    insert into log(Nome_tab, Operacao, Id) values('Usuarios', 'Insert', :new.Id_Usuario);
end;

 create or replace trigger updates_usuario
 before update on Usuarios
 for each row
 begin
    insert into log (Nome_tab, Operacao, Id) values ('Usuarios','Upadate', :old.Id_Usuario);
end;

create or replace trigger delete_usuario
after delete on Usuarios
for each row
begin
    insert into log(Nome_tab, Operacao, Id) values ('Usuarios', 'Delete', :old.Id_Usuario);
end;

create or replace trigger inserts_carrinho
after insert on Carrinho
for each row
begin 
    insert into log(Nome_tab, Operacao, Id) values('Carrinho', 'Insert', :new.Id_Carrinho);
end;

 create or replace trigger updates_carrinho
 before update on Carrinho
 for each row
 begin
    insert into log (Nome_tab, Operacao, Id) values ('Carrinho','Upadate', :old.Id_Carrinho);
end;

create or replace trigger delete_Carrinho
after delete on Carrinho
for each row
begin
    insert into log(Nome_tab, Operacao, Id) values ('Carrinho', 'Delete', :old.Id_Carrinho);
end;

create or replace trigger inserts_faturamento
after insert on Faturamento
for each row
begin 
    insert into log(Nome_tab, Operacao, Id) values('Faturamento', 'Insert', :new.Id_Faturamento);
end;

 create or replace trigger updates_faturamento
 before update on Faturamento
 for each row
 begin
    insert into log (Nome_tab, Operacao, Id) values ('Faturamento','Upadate', :old.Id_Faturamento);
end;

create or replace trigger delete_faturamento
after delete on Faturamento
for each row
begin
    insert into log(Nome_tab, Operacao, Id) values ('Faturamento', 'Delete', :old.Id_Faturamento);
end;