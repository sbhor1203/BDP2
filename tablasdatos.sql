INSERT INTO paciente (dpi, nombre, direccion, telefono, altura, masa_corporal, peso, enfermedades_herencia)
VALUES 
('1234567891011', 'Juan Perez', '123 Calle Principal', '5585-1234', '170 cm', '70 kg', '70 kg', 'Diabetes'),
('2345678910112', 'Maria Lopez', '456 Avenida Reforma', '5565-5678', '160 cm', '65 kg', '60 kg', 'Hipertensión'),
('3456789101123', 'Pedro Rodriguez', '789 Sexta avenida', '5455-9876', '180 cm', '80 kg', '75 kg', 'Ninguna'),
('4950515253545', 'Laura Gutierrez', '101112 Calle Martí', '7855-1011', '165 cm', '55 kg', '50 kg', 'Asma'),
('6061626364656', 'Miguel Sanchez', '131415 Zona 10', '2585-1314', '175 cm', '75 kg', '70 kg', 'Ninguna'),
('9697989910010', 'Ana Hernandez', '161718 Calle Décima', '2589-1617', '155 cm', '50 kg', '45 kg', 'Diabetes'),
('10111213141516', 'Luis Ramirez', '192021 Calle Once', '2655-1920', '185 cm', '90 kg', '85 kg', 'Ninguna'),
('39404142434445', 'Jose Martinez', '464748 zona 11', '4555-4647', '168 cm', '70 kg', '65 kg', 'Ninguna'),
('46474849505152', 'Daniel Gonzalez', '515253 Periférico', '5955-5152', '172 cm', '75 kg', '70 kg', 'Asma');


INSERT INTO centro_medico (id, nombre, direccion, telefono)
VALUES 
(1, 'Hospital General', '123 Avenida Principal', '5855-1111'),
(2, 'Clinica San Jose', '456 Avenida Secundaria', '5456-2222'),
(3, 'Centro Medico ABC', '789 Avenida Reforma', '5478-3333'),
(4, 'Clinica San Rafael', '222 Calle Hospitalaria', '5785-4444'),
(5, 'Hospital Universitario', 'zona 1 Avenida Médica', '5895-5555'),
(6, 'Centro de Salud Familiar', '777 Calle de la Salud', '7895-6666'),
(7, 'Clinica Santa Maria', '888 Calle Santa Maria', '5892-7777'),
(8, 'Clinica San Ángel', 'Avenida Reforma 1-78', '7858-4585' ),
(9,'Centro San Juan', 'Primera Calle Santa Maria', '5987-5623'),
(10, 'Centro Medico XYZ', '101112 Calle XYZ', '5689-1011');


INSERT INTO inventario (id_centro_medico, nombre_producto, cantidad_producto, capacidad_producto, fecha_vencimiento)
VALUES 
(1, 'Paracetamol', 100, 200, '2023-12-31'),
(1, 'Ibuprofeno', 80, 150, '2023-11-30'),
(2, 'Aspirina', 120, 180, '2023-10-31'),
(2, 'Amoxicilina', 90, 120, '2023-09-30'),
(3, 'Omeprazol', 70, 100, '2023-08-31'),
(4, 'Moxifloxacino', 50, 100, '2023-12-31'),
(4, 'Atorvastatina', 70, 120, '2023-11-30'),
(5, 'Simvastatina', 60, 90, '2023-10-31'),
(5, 'Metformina', 80, 110, '2023-09-30'),
(6, 'Ciprofloxacino', 40, 80, '2023-08-31'),
(7, 'Lorazepam', 60, 100, '2023-07-31'),
(8, 'Sertralina', 75, 120, '2023-06-30'),
(9, 'Metoprolol', 55, 90, '2023-05-31'),
(10, 'Fluoxetina', 65, 110, '2023-04-30');



INSERT INTO medico (num_colegiatura, nombre, direccion, telefono, id_centro_medico, especialidad, contraseña)
VALUES 
('MC123', 'Dr. Carlos Hernandez', '123 Calle Principal', '5585-4444', 1, 'Cardiología', 'password1'),
('MC234', 'Dra. Laura Martinez', '456 Villa nueva', '4855-5555', 2, 'Pediatría', 'password2'),
('MC345', 'Dr. Juan Rodriguez', '789 Calle decima', '7855-6666', 3, 'Dermatología', 'password3'),
('MC456', 'Dra. Sofia Ramirez', '222 Avenida Reforma', '6895-7777', 4, 'Ginecología', 'password4'),
('MC567', 'Dr. Javier Garcia', '555 Avenida Médica', '5897-8888', 5, 'Neurología', 'password5'),
('MC678', 'Dra. Laura Rodriguez', '777 Avenida las Américas', '4758-9999', 6, 'Pediatria', 'password6'),
('MC789', 'Dr. Miguel Soto', '888 Calle Santa Maria', '4879-1010', 7, 'Psiquiatría', 'password7'),
('MC910', 'Dra. Ana Torres', '101112 Calle Mart+i', '7485-1247', 10, 'Oftalmología', 'password8');


INSERT INTO reporte_medico (id_reporte, id_paciente, id_medico, enfermedad_tratada, medicamento_administrado, examenes_realizados, id_centro_medico)
VALUES 
('RM001', '1234567891011', 'MC123', 'Hipertensión', 'Losartan', 'Presión Arterial', 1),
('RM002', '2345678910112', 'MC234', 'Gripe', 'Paracetamol', 'Prueba de Gripe', 2),
('RM003', '3456789101123', 'MC345', 'Dermatitis', 'Crema Hidratante', 'Examen de Piel', 3),
('RM004', '6061626364656', 'MC456', 'Embarazo', 'Ácido Fólico', 'Ultrasonido', 4),
('RM005', '9697989910010', 'MC567', 'Migraña', 'Sumatriptán', 'Resonancia Magnética', 5),
('RM006', '1234567891011', 'MC678', 'Resfriado', 'Acetaminofén', 'Examen Físico', 6),
('RM007', '2345678910112', 'MC789', 'Depresión', 'Sertralina', 'Evaluación Psicológica', 7),
('RM008', '3456789101123', 'MC910', 'Ojo Seco', 'Gotas Lubricantes', 'Examen Oftalmológico', 10),
('RM009', '4950515253545', 'MC123', 'Alergia', 'Antihistamínico', 'Prueba de Alergia', 1);

INSERT INTO historial (id_reporte, fecha, hora, seguimiento, Status_Paciente)
VALUES 
('RM001', '2023-10-01', '10:00 AM', 'El paciente debe seguir una dieta baja en sal.', 'Estable'),
('RM001', '2023-10-15', '11:30 AM', 'El paciente reporta mejoría en su presión arterial.', 'Estable'),
('RM002', '2023-10-02', '09:45 AM', 'El paciente debe descansar y tomar líquidos.', 'Estable'),
('RM002', '2023-10-03', '11:00 AM', 'El paciente se encuentra recuperando.', 'Estable'),
('RM003', '2023-10-05', '03:15 PM', 'El paciente debe evitar irritantes en la piel.', 'Mejorando'),
('RM004', '2023-10-10', '02:30 PM', 'La paciente debe llevar una dieta balanceada.', 'Estable'),
('RM004', '2023-10-25', '03:45 PM', 'La paciente reporta movimientos fetales.', 'Estable'),
('RM005', '2023-10-12', '11:15 AM', 'El paciente debe evitar desencadenantes de migraña.', 'Estable'),
('RM005', '2023-10-15', '12:30 PM', 'El paciente se siente mejor con el tratamiento.', 'Estable'),
('RM006', '2023-10-20', '09:00 AM', 'El paciente debe descansar y tomar líquidos.', 'Mejorando'),
('RM007', '2023-10-05', '10:30 AM', 'El paciente se muestra más animado.', 'Mejorando'),
('RM008', '2023-10-29', '04:00 PM', 'El paciente reporta alivio con las gotas.', 'Estable'),
('RM009', '2023-10-30', '11:30 AM', 'El paciente debe evitar alérgenos.', 'Mejorando');

-- Insertar nuevos pacientes
INSERT INTO paciente (dpi, nombre, direccion, telefono, altura, masa_corporal, peso, enfermedades_herencia)
VALUES 
('9876543210123', 'Elena Sánchez', '111 Calle Nueva', '5555-1111', '160 cm', '60 kg', '55 kg', 'Ninguna'),
('8765432101234', 'Andrés Morales', '222 Avenida Principal', '5555-2222', '175 cm', '75 kg', '70 kg', 'Asma'),
('7654321012345', 'Carolina Perez', '333 Calle Secundaria', '5555-3333', '170 cm', '65 kg', '60 kg', 'Diabetes'),
('6543210123456', 'Ricardo Gomez', '444 Avenida Reforma', '5555-4444', '185 cm', '90 kg', '85 kg', 'Hipertensión'),
('5432101234567', 'Isabel Torres', '555 Calle Hospitalaria', '5555-5555', '165 cm', '55 kg', '50 kg', 'Ninguna'),
('4321012345678', 'Manuel Rodriguez', '666 Avenida Médica', '5555-6666', '155 cm', '50 kg', '45 kg', 'Asma'),
('3210123456789', 'Sara Fernández', '777 Calle de la Salud', '5555-7777', '175 cm', '70 kg', '65 kg', 'Ninguna'),
('2101234567890', 'Felipe Rios', '888 Calle Santa Maria', '5555-8888', '168 cm', '70 kg', '65 kg', 'Ninguna');

-- Insertar nuevos centros médicos
INSERT INTO centro_medico (id, nombre, direccion, telefono)
VALUES 
(11, 'Hospital Santa Rosa', '123 Calle Santa Rosa', '5555-9999'),
(12, 'Clinica San Pablo', '456 Avenida San Pablo', '5555-1234'),
(13, 'Centro Medico ABCD', '789 Avenida ABCD', '5555-4321'),
(14, 'Clinica San Miguel', '222 Avenida Miguel', '5555-9876'),
(15, 'Hospital Metropolitano', '555 Avenida Metropolitano', '5555-3456'),
(16, 'Centro de Salud Santa Fe', '777 Calle Santa Fe', '5555-6789'),
(17, 'Clinica Santa Teresa', '888 Calle Santa Teresa', '5555-5678');

-- Insertar nuevos productos en el inventario
INSERT INTO inventario (id_centro_medico, nombre_producto, cantidad_producto, capacidad_producto, fecha_vencimiento)
VALUES 
(11, 'Ibuprofeno', 90, 120, '2024-01-31'),
(12, 'Aspirina', 100, 150, '2024-02-28'),
(13, 'Amoxicilina', 110, 140, '2024-03-31'),
(14, 'Omeprazol', 95, 110, '2024-04-30'),
(15, 'Atorvastatina', 80, 100, '2024-05-31'),
(16, 'Metformina', 75, 95, '2024-06-30'),
(17, 'Lorazepam', 55, 70, '2024-07-31');

-- Insertar nuevos médicos
INSERT INTO medico (num_colegiatura, nombre, direccion, telefono, id_centro_medico, especialidad, contraseña)
VALUES 
('MC111', 'Dr. Laura Garcia', '111 Avenida Principal', '5555-1112', 11, 'Dermatología', 'password9'),
('MC222', 'Dra. Carlos Ramirez', '222 Avenida Reforma', '5555-2221', 12, 'Ginecología', 'password10'),
('MC333', 'Dr. Juan Soto', '333 Avenida ABCD', '5555-3332', 13, 'Pediatría', 'password11'),
('MC444', 'Dra. Sofia Mendoza', '444 Avenida San Pablo', '5555-4442', 14, 'Cardiología', 'password12'),
('MC555', 'Dr. Javier Lopez', '555 Avenida Metropolitano', '5555-5551', 15, 'Neurología', 'password13');

-- Insertar nuevos reportes médicos
INSERT INTO reporte_medico (id_reporte, id_paciente, id_medico, enfermedad_tratada, medicamento_administrado, examenes_realizados, id_centro_medico)
VALUES 
('RM010', '9876543210123', 'MC111', 'Alergia', 'Antihistamínico', 'Prueba de Alergia', 11),
('RM011', '8765432101234', 'MC222', 'Resfriado', 'Acetaminofén', 'Examen Físico', 12),
('RM012', '7654321012345', 'MC333', 'Migraña', 'Sumatriptán', 'Resonancia Magnética', 13),
('RM013', '6543210123456', 'MC444', 'Embarazo', 'Ácido Fólico', 'Ultrasonido', 14),
('RM014', '5432101234567', 'MC555', 'Hipertensión', 'Losartan', 'Presión Arterial', 15);

-- Insertar nuevos registros en el historial
INSERT INTO historial (id_reporte, fecha, hora, seguimiento, Status_Paciente)
VALUES 
('RM010', '2023-11-01', '09:00 AM', 'El paciente debe evitar alérgenos.', 'Muerto'),
('RM011', '2023-11-02', '10:30 AM', 'El paciente se encuentra muerto.', 'Muerto'),
('RM012', '2023-11-05', '03:15 PM', 'El paciente debe evitar desencadenantes de migraña.', 'Muerto'),
('RM013', '2023-11-10', '02:30 PM', 'La paciente reporta movimientos fetales.', 'Muerto'),
('RM014', '2023-11-12', '11:15 AM', 'El paciente reporta mejoría en su presión arterial.', 'Muerto');

INSERT INTO reporte_medico (id_reporte, id_paciente, id_medico, enfermedad_tratada, medicamento_administrado, examenes_realizados, id_centro_medico)
VALUES 
('RM015', '6543210123456', 'MC444', 'Cáncer de Páncreas', 'Quimioterapia', 'Tomografía computarizada', 14),
('RM016', '5432101234567', 'MC555', 'Enfermedad de Alzheimer', 'Terapia cognitiva', 'Evaluación neuropsicológica', 15),
('RM017', '9876543210123', 'MC111', 'Esclerosis Múltiple', 'Medicamentos inmunomoduladores', 'Resonancia Magnética cerebral', 11),
('RM018', '8765432101234', 'MC222', 'Insuficiencia Renal', 'Diálisis', 'Exámenes de función renal', 12),
('RM019', '7654321012345', 'MC333', 'Cáncer de Pulmón', 'Radioterapia', 'Tomografía de tórax', 13);

INSERT INTO historial (id_reporte, fecha, hora, seguimiento, Status_Paciente)
VALUES 
('RM015', '2023-12-01', '08:00 AM', 'El paciente inicia tratamiento de quimioterapia.', 'Muerto'),
('RM016', '2023-12-02', '09:45 AM', 'El paciente experimenta pérdida de memoria.', 'Muerto'),
('RM017', '2023-12-05', '03:15 PM', 'El paciente presenta síntomas neurológicos.', 'Muerto'),
('RM018', '2023-12-12', '11:15 AM', 'El paciente requiere diálisis.', 'Muerto'),
('RM019', '2023-12-10', '12:30 PM', 'Se inicia radioterapia para tratar el cáncer de pulmón.', 'Muerto');

INSERT INTO inventario (id_centro_medico, nombre_producto, cantidad_producto, capacidad_producto, fecha_vencimiento)
VALUES
(3, 'Antibiótico Zithromax', 5, 100, '2023-12-31'),
(1, 'Analgesia Tramadol', 10, 200, '2024-01-31'),
(2, 'Anticoagulante Plavix', 8, 150, '2023-11-30'),
(2, 'Antiinflamatorio Voltaren', 12, 180, '2024-02-28');

