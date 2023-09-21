select * from dbo.cliente

--Traer todos los que son de San Francisco

Select * from dbo.cliente
where ciudad = 'San Francisco'


--Cuantos clientes son de USA

select COUNT(*) as Clientes_USA from dbo.cliente 
where pais = 'USA'

--Traer todos los clientes que empiecen con G

select * from dbo.cliente
where nombre_cliente like 'G%'

--Traer cuantos clientes tengo en cada Ciudad

select ciudad, COUNT(*) from dbo.cliente
group by ciudad

--Traer un conteo de cuantos clientes tengo en cada pais

select pais, COUNT(*) from dbo.cliente
group by pais

--Traer nombre de cliente y el limite que tiene de credito y ordenarlo del mas grande al mas chico

select nombre_cliente,limite_credito from dbo.cliente
order by limite_credito desc

--Ahora traer los 3 que tienen mas limite de credito
select top 3 nombre_cliente,limite_credito from dbo.cliente
order by limite_credito desc

--Traer nombre del cliente, y el nombre y apellido de su representante de ventas
Select * from dbo.cliente
Select * from dbo.empleado

Select a.nombre_cliente, b.nombre, b.apellido1 from dbo.cliente a inner join dbo.empleado b
on a.codigo_empleado_rep_ventas = b.codigo_empleado


--Traer el nombre del contacto con sus dos apellidos en una sola columna

Select CONCAT(nombre_contacto,' ', apellido_contacto) from dbo.cliente 


--STORED PROCEDURE
CREATE PROCEDURE sp_Clientes_USA
AS
select COUNT(*) as Clientes_USA from dbo.cliente 
where pais = 'USA'

GO

exec sp_Clientes_USA

--3 tipos de triggers (cuando insertar, cuando borras y cuando actualizas. Se pueden hacer en 3 diferentes tiempos, before for y after)

--Hace un trigger que te muestre el record insertado cada que insertes algo en cliente

CREATE TRIGGER trg_record_insertado_cliente
on dbo.cliente
for insert
as
begin
	set nocount on;
	select * from inserted 
end
go 

set identity_insert cliente off

insert into cliente values ('745',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

select * from cliente

select * from oficina

CREATE TRIGGER trg_record_insertado_oficina
on dbo.oficina
for insert
as
begin
	set nocount on; --para que no salgan duplicados
	select * from inserted 
end
go 

insert into oficina (codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2)
values ('35','Colima','Mexico','Colima','28017','312312312','V carranza 13', 'Constitucion 23')

select * from dbo.oficina

CREATE TRIGGER trg_record_borrado_oficina
on dbo.oficina
for delete
as
begin
	set nocount on; --para que no salgan duplicados
	select * from deleted 
end
go 

delete from oficina
where codigo_oficina = '35'