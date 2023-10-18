--Reporte 1
SELECT r.enfermedad_tratada, COUNT(*) AS pacientes_fallecidos
FROM reporte_medico r
JOIN (
    SELECT id_reporte, status_paciente
    FROM historial
    WHERE seguimiento = (
        SELECT MAX(seguimiento)
        FROM historial h2
        WHERE h2.id_reporte = historial.id_reporte
    )
) h ON r.id_reporte = h.id_reporte
WHERE h.status_paciente = 'Muerto'
GROUP BY r.enfermedad_tratada
ORDER BY pacientes_fallecidos DESC
LIMIT 10;

--Reporte 2
select medico.num_colegiatura, medico.nombre, 
count(reporte_medico.id_medico) as pacientes_atendidos 
from medico 
join reporte_medico on medico.num_colegiatura = reporte_medico.id_medico 
group by medico.num_colegiatura, medico.nombre o
rder by pacientes_atendidos 
desc limit 10")
--Reporte 3
	select paciente.nombre, count(historial.id_reporte) as asistencias_centros_medicos, paciente.peso, paciente.altura, paciente.masa_corporal from paciente
	join reporte_medico
	on paciente.dpi = reporte_medico.id_paciente
	join historial
	on historial.id_reporte = reporte_medico.id_reporte
	group by paciente.nombre, paciente.peso, paciente.altura, paciente.masa_corporal
	order by asistencias_centros_medicos desc
	limit 5
--Reporte 4	
select inventario.nombre_producto, centro_medico.nombre , inventario.cantidad_producto, inventario.capacidad_producto, 
cast(inventario.cantidad_producto as float)/cast(inventario.capacidad_producto as float) * 100 as porcentaje_disponible 
from inventario
join centro_medico 
on inventario.id_centro_medico = centro_medico.id
where inventario.cantidad_producto <= 0.15 * inventario.capacidad_producto
order by porcentaje_disponible desc

--Reporte 5
select centro_medico.nombre, count(reporte_medico.id_centro_medico) as pacientes_atendidos from centro_medico
join reporte_medico
on centro_medico.id = reporte_medico.id_centro_medico
group by centro_medico.nombre
order by pacientes_atendidos desc
limit 3

--Triggers
CREATE OR REPLACE FUNCTION registro_cambio_medico()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.id_centro_medico <> NEW.id_centro_medico THEN
        INSERT INTO historial_cambios_medicos (num_colegiatura_anterior, num_colegiatura_nuevo, fecha_cambio, motivo_cambio)
        VALUES (OLD.num_colegiatura, NEW.num_colegiatura, current_date, 'Motivo del cambio'); -- Puedes especificar el motivo del cambio aquí
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER medico_cambio_hospital
AFTER UPDATE ON medico
FOR EACH ROW
EXECUTE FUNCTION registro_cambio_medico();

select * from medico
-- Bitacora
CREATE OR REPLACE FUNCTION bitacora_bd()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_TABLE_NAME = 'medico' THEN
        INSERT INTO bitacora_bd(fecha_hora,origen_insert)
        VALUES (now(), 'medico');
    ELSIF TG_TABLE_NAME = 'paciente' THEN
        INSERT INTO bitacora_bd (fecha_hora,origen_insert)
        VALUES (now(), 'paciente');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER bita
AFTER INSERT ON medico 
FOR EACH ROW
EXECUTE FUNCTION bitacora_bd();

CREATE TRIGGER bita2
AFTER INSERT ON paciente 
FOR EACH ROW
EXECUTE FUNCTION bitacora_bd();

/* Acceso inmediato del expediente del paciente */
select * from reporte_medico
select * from historial
