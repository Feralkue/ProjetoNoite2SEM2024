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
