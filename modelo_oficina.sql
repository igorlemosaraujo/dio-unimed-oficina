-- Criação do banco de dados para o cenário de E-commerce
-- drop database ecommerce;

create database ecommerce;
use ecommerce;

-- Criação de tabela Cliente
create table clients(
	idClient int auto_increment primary key,
    fname varchar(12),
    Minit char(3),
    Lname varchar(15),
    CPF char(11) not null,
    adress varchar(30),
    constraint unique_cpf_client unique(CPF)
);
alter table clients auto_increment=1;
-- Criação de tabela Produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(12) not null,
    classification_kids bool,
    category enum("Eletrônico","Vestuario","Brinquedos","Livros") not null,
    description varchar(50),
    avaliation float
);
-- Criação de tabela Pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int ,
    orderStatus enum("Cancelado","Confirmado","Em Processamento","Concluido") default "Em Processamento",
    orderDescription varchar(255),
    sendValue float default 9.99,
    paymentForm enum("Pix","Cartão","Dinheiro"),
    constraint fk_orders_client foreign key(idOrderClient) references clients(idClient)
    on update cascade
);

-- Criação tabela Pagamentos
create table payments(
	idPayment int,
    idClient int,
    typePayment enum("Pix","Cartão","Dinheiro"),
    card_number varchar(25) default null,
    limitAvailable float,
    primary key(idClient,idPayment),
    constraint fk_payments_client foreign key(idClient) references clients(idClient) 
);

-- Criação tabela Vendedor
create table productStorage(
	idProdStorage int auto_increment,
    storageLocation varchar(30),
	quantity int default 0,
    primary key(idProdStorage)
    );
    
-- Criação tabela Fornecedor
create table supplier(
	idSupplier int auto_increment,
	socialName varchar(255) not null,
	CNPJ CHAR(15) not null ,
    contact char(11) not null,
    primary key(idSupplier),
    constraint unique_supplier unique (CNPJ) 
    );

-- Criação tabela Vendedor
create table seller(
	idSeller int auto_increment primary key,
	socialName varchar(255) not null,
	CNPJ CHAR(15) not null ,
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_seller_CNPJ unique (CNPJ),
    constraint unique_seller_CPF unique (CPF) 
    );
    
-- Criação tabela 
create table productSeller(
	idPseller int,
    idProduct int,
    prodQuantity int not null,
    primary key(idPseller,idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

desc productSeller;

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int not null,
    poStatus enum("Disponível","Sem Estoque") default "Disponível",
    primary key(idPOproduct,idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    poStatus enum("Disponível","Sem Estoque") default "Disponível",
    primary key(idLproduct,idLstorage),
    constraint fk_productstorage_seller foreign key (idLproduct) references product(idProduct),
    constraint fk_productstorage_product foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
	quantity int not null,
    primary key(idPsSupplier,idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);
show tables;

insert into Clients(Fname,Minit,Lname,CPF,Adress)
	values("")