use jardineria;

/*Calcula la fecha del primer y último pago realizado por cada uno de los clientes. 
El listado deberá mostrar el nombre y los apellidos de cada cliente.*/

select c.nombre_contacto, c.apellido_contacto, min(p.fecha_pago) as  primer_pago, max(p.fecha_pago) as ultimo_pago
from cliente c
join pago p on c.codigo_cliente = p.codigo_cliente
group by c.nombre_contacto, c.apellido_contacto;

/*Lista las ventas totales de los productos que hayan facturado más de 3000 euros.
 Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).*/

select p.nombre, sum(dp.cantidad) as unidades_vendidas, sum(dp.cantidad * p.precio_venta) as total_facturado,
sum(dp.cantidad* p.precio_venta * 1.21) as total_facturado_con_iva
from producto p
join detalle_pedido dp on p.codigo_producto = dp.codigo_producto
group by p.nombre
having sum(dp.cantidad * p.precio_venta) > 3000;

/*Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).*/

select nombre_contacto, apellido_contacto
from cliente
where limite_credito > (select sum(total) from pago where pago.codigo_cliente = cliente.codigo_cliente);

/*Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.*/

select e.nombre, e.apellido1, e.email
from empleado e
where e.codigo_jefe =(select codigo_empleado from empleado where nombre = 'Alberto' and apellido1 ='soria');

/*Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago. 
(Recomendamos resolver este ejercicio con Subconsultas del tipo IN y NOT IN).*/

select nombre_contacto, apellido_contacto
from cliente
where codigo_cliente not in (select codigo_cliente from pago);

/*Devuelve un listado de los productos (código y nombre)  que han aparecido en un pedido alguna vez.
(Recomendamos resolver este ejercicio con Subconsultas del tipo EXISTS y NOT EXISTS).*/

select codigo_producto, nombre
from producto
where exists (select 1 from detalle_pedido dp where dp.codigo_producto = producto.codigo_producto);

/*Devuelve el nombre del producto que tenga el precio de venta más caro.
 (Recomendamos resolver este ejercicio con Subconsultas del tipo ALL y ANY).*/

select nombre
from producto
where precio_venta = (select max(precio_venta) from producto);

/*Devuelve el nombre del producto que tenga el precio de venta más caro (puedes realizarlo ordenando la tabla).*/

select nombre
from producto order by precio_venta desc
limit 1;

/*Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.*/

select codigo_pedido, sum(cantidad) as total_productos
from detalle_pedido
group by codigo_pedido;

/*Devuelve el nombre del cliente con mayor límite de crédito.*/

select nombre_contacto, apellido_contacto
from cliente
order by limite_credito desc
limit 1;

/*Devuelve el producto que más unidades tiene en stock.*/

select nombre
from producto
order by cantidad_en_stock desc
limit 1;

/*Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago. 
(Recomendamos resolver este ejercicio con Subconsultas del tipo ALL y ANY).*/

select nombre_contacto, apellido_contacto
from cliente
where codigo_cliente not in (select codigo_cliente from pago);

/*Devuelve un listado de los productos que nunca han aparecido en un pedido.
 (Recomendamos resolver este ejercicio con Subconsultas del tipo EXISTS y NOT EXISTS).*/
 
 select codigo_producto, nombre
 from producto
 where not exists (select 1 from detalle_pedido dp where dp.codigo_producto = producto.codigo_producto);

/*Calcula el número de productos diferentes que hay en cada uno de los pedidos. */

select codigo_pedido, count(distinct codigo_producto) as productos_diferentes
from detalle_pedido
group by codigo_pedido;

/*Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.*/

select e.nombre, e.apellido1, count(c.codigo_cliente) as numero_clientes
from empleado e
join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
group by e.nombre, e.apellido1;

/*Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M.*/

select ciudad, count(codigo_cliente) AS numero_clientes
from cliente
where ciudad like 'M%'
group by ciudad; 

/*Calcula el número de clientes que no tiene asignado representante de ventas.*/

select nombre_contacto, apellido_contacto
from cliente where codigo_empleado_rep_ventas is null;

/*Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
El listado deberá estar ordenado por el número total de unidades vendidas descendente.*/

select p.nombre, sum(dp.cantidad) as total_unidades
from producto p
join detalle_pedido dp on p.codigo_producto = dp.codigo_producto
group by p.nombre
order by total_unidades desc
limit 20;
