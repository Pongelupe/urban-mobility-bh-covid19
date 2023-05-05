

select * from bh.ped order by linha, sentido, sequencia;

with ordered_points as (
select * from bh.ped order by linha, sentido, sequencia 
)
select p.linha, p.sentido, ST_MakeLine(p.localizacao) as line from bh.ped p
join ordered_points op on op.id_ped = p.id_ped 
group by p.linha, p.sentido 
having count(p.localizacao) > 1 ;

select ST_MakeLine(p.localizacao) as line from bh.ped p
where linha = '9202-3'-- order by sequencia;

select count(*)	 from pontoonibus o;

select * from gtfs.trips t 
join gtfs.routes r on r.route_id = t.route_id
where t.trip_id = 'SC01A 011070180530';, st.trip_id, 

select * from gtfs.trips r;

select * from gtfs.shape_geoms st;

with timetable as
(select st.timepoint, r.route_short_name, r.route_long_name, st.trip_id, st.stop_sequence, arrival_time, sg.length, sg.the_geom
from gtfs.stop_times st 
join trips p on p.trip_id = st.trip_id
join gtfs.shape_geoms sg on sg.shape_id = p.shape_id
join routes r on r.route_id = p.route_id 
where st.arrival_time is not null )
select --*
t.route_short_name, t.route_long_name, 
(select arrival_time from stop_times t1 where t1.feed_index = 1 and t1.trip_id = t.trip_id and t1.stop_sequence = 1) as route_departure_time,
t.arrival_time as route_arrival_time,
t.length,
t.the_geom 
from timetable t
where t.timepoint  = 0
and t.route_short_name = '9202'
order by trip_id, arrival_time; -- TIMETABLE EXPECTED


select * from gtfs.routes where route_short_name = '9202';
select * from gtfs.trips t where route_id in (select route_id from gtfs.routes where route_short_name = '9202');

select count(*) from onibus_tempo_real otr
where data_hora between '2022-12-13 00:00:00' and '2022-12-14 00:01:00';



create table onibus_tempo_real (codigo_evento int, data_hora timestamp, coord geometry, numero_ordem_veiculo int, velocidade_instantanea int, codigo_linha int, direcao int, sentido int, distancia_percorrida int);
drop table linha_onibus;


select count(*) from onibus_tempo_real;
select * from onibus_tempo_real;


select count(distinct numero_ordem_veiculo) from onibus_tempo_real otr
where id_linha in (
select id_linha from linha_onibus otr where codigo_linha like '3302D%'); -- quantos onibus rodando

select * from linha_onibus otr where codigo_linha like '9202%';

select * from gtfs.shape_geoms sg;

select * from bh.bh.onibus_tempo_real otr
where otr.id_linha in (select id_linha from linha_onibus where codigo_0linha like '9202%')
--and sentido = 0
and data_hora between '2022-12-15 12:00:00' and '2022-12-21 18:00:00'
and otr.distancia_percorrida = 0;

--viagem 9202 16/12
select data_hora, distancia_percorrida, ST_SetSRID(coord, 4326) as coord, numero_ordem_veiculo, velocidade_instantanea from bh.bh.onibus_tempo_real otr
where id_linha = 629
and data_hora between '2022-12-16 11:00:00' and '2022-12-16 20:00:00'
and numero_ordem_veiculo = 20246
order by data_hora limit 1387;

with viagem as (
select ST_SetSRID(ST_MakePoint(ST_Y(coord),ST_X(coord)), 4326) as p from bh.bh.onibus_tempo_real otr
where id_linha = 629
and data_hora between '2022-12-16 11:00:00' and '2022-12-16 20:00:00'
and numero_ordem_veiculo = 20246
order by data_hora limit 1387)

select 1 from gtfs.stop_times st, viagem 
join gtfs.stops s on s.stop_id = st.stop_id 

where st.trip_id = '9202  031080602110' order by st.stop_sequence;

--ST_Distance((select p from viagem), ST_SetSRID(s.the_geom, 4326))

--distancia de cada ponto de onibus da rota
with viagem as (
select ST_MakeLine(coords) as line from (
select ST_SetSRID(ST_MakePoint(ST_Y(coord),ST_X(coord)), 4326) as coords from bh.bh.onibus_tempo_real otr
where id_linha = 629
and data_hora between '2022-12-16 11:00:00' and '2022-12-16 20:00:00'
and numero_ordem_veiculo = 20246
order by data_hora limit 1387) as a)
select ST_Distance((select line from viagem), ST_SetSRID(s.the_geom, 4326)) from gtfs.stop_times st 
join gtfs.stops s on s.stop_id = st.stop_id 
where st.trip_id = '9202  031080602110' order by 1;


select count(1) from bh.bh.onibus_tempo_real otr;

select t.* from gtfs.routes r
join gtfs.trips t on t.route_id = r.route_id 
where r.route_id = '9202  03';

select * from gtfs.shapes s 
where s.shape_id = '9202-03I';

select st.stop_sequence, s.stop_id,  s.the_geom from gtfs.stop_times st 
join gtfs.stops s on s.stop_id = st.stop_id 
where st.trip_id = '9202  031080602110' order by 1;

select data_hora, distancia_percorrida, coord, numero_ordem_veiculo, velocidade_instantanea, id_linha from bh.bh.onibus_tempo_real otr
where id_linha = 629
 and data_hora between '2022-12-16 6:00:00' and '2022-12-16 23:59:00'
 and numero_ordem_veiculo = 20246 order by numero_ordem_veiculo, data_hora

 
 select * from bh.bh.onibus_tempo_real
 
 select coord, ST_X(o.coord), ST_Y(o.coord), ST_SetSRID(ST_MakePoint(ST_Y(o.coord),ST_X(o.coord)), 4326), coord2 from bh.bh.onibus_tempo_real o;

update bh.bh.onibus_tempo_real o
set coord2 = ST_SetSRID(ST_MakePoint(ST_Y(o.coord),ST_X(o.coord)), 4326)
from onibus_tempo_real

 


--viagem 9202 16/12
select data_hora, distancia_percorrida, coord, numero_ordem_veiculo, velocidade_instantanea, id_linha from bh.bh.onibus_tempo_real otr
where --id_linha = 629 and
data_hora between '2022-12-16 6:00:00' and '2022-12-16 23:59:00'
--and numero_ordem_veiculo = 20246
order by numero_ordem_veiculo, data_hora;

create table linha_onibus (id_linha int primary key, codigo_linha varchar(15), descricao_linha varchar(70));

create table onibus_tempo_real (codigo_evento int, data_hora timestamp, coord geometry, numero_ordem_veiculo int, velocidade_instantanea int, id_linha int, direcao int, sentido int, distancia_percorrida int);

alter table onibus_tempo_real add constraint fk_id_linha
foreign key (id_linha) references linha_onibus(id_linha); 



