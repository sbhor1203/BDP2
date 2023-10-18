import psycopg2
import datetime

# Establece la conexión a la base de datos
db_params = {
    'dbname': 'proyecto_2_fin',
    'user': 'postgres',
    'password': 'Saturn184500',
    'host': 'localhost',
    'port': '5432',
}

conn = psycopg2.connect(**db_params)

# Crea un objeto cursor para ejecutar consultas SQL
cursor = conn.cursor()


def menu():
    print(
        "***************************************************************************************************************************************************")
    print(
        "      Bienvenido al Sistema Hospitalario, en este sistema podrás hacer varias acciones correspondientes a procesos internos del hospital           ")
    print(
        "***************************************************************************************************************************************************\n")

    op = 0
    while True:
        print("Por favor ingrese la opción que desee:")
        print("   (1) Informe de medicamentos")
        print("   (2) Buscar expediente de paciente")
        print("   (3) Bitácora de base de datos")
        print("   (4) Ver bitácora de traspasos")
        print("   (5) Reportería")
        print("   (6) Ingresar un nuevo paciente / médico")
        print("   (7) Salir")

        op = input("Ingrese la opción que desea: ")

        if op.isdigit():
            op = int(op)
            if 1 <= op <= 7:
                break
            else:
                print("Error, ingrese una opción válida del menú (1-7).")
        else:
            print("Error, debe ingresar un número del menú (1-7).")

    return op


def registrar_usuario():
    username = input("Ingrese su nuevo nombre de usuario: ")
    contraseña = input("Ingrese su nueva contraseña (máximo 20 caracteres): ")

    while len(contraseña) > 20:
        print("La contraseña debe ser menor o igual a 20 caracteres.")
        contraseña = input("Ingrese su nueva contraseña (máximo 20 caracteres): ")

    cursor.execute("INSERT INTO usuarios VALUES (%s, %s)", (username, contraseña))
    conn.commit()
    print("Usuario agregado con éxito")


def login():
    bolean1 = False
    bolean2 = False

    while not bolean1 or not bolean2:
        username = input("Ingrese su nombre de usuario: ")
        password = input("Ingrese su contraseña: ")

        cursor.execute("SELECT * FROM usuarios")

        lista_tuplas = cursor.fetchall()
        list_usuario = [row[0] for row in lista_tuplas]
        list_contraseñas = [row[1] for row in lista_tuplas]

        if username in list_usuario:
            posicion = list_usuario.index(username)
            print("\nUsuario encontrado")
            bolean1 = True
        else:
            print("\nNo se encontró el usuario, asegúrese de haberlo escrito correctamente.")
            print("Escriba 'SALIR' como nombre de usuario si desea salir.")
            username = input("Ingrese su nombre de usuario: ")

            if username == "SALIR":
                break

        if not bolean2:
            if list_contraseñas[posicion] == password:
                print("\nContraseña válida.")
                bolean2 = True
            else:
                print("\nContraseña incorrecta, asegúrese de haberla escrito correctamente.")
                print("Escriba 'SALIR' como contraseña si desea salir.")
                password = input("Ingrese su contraseña: ")

                if username == "SALIR":
                    break

    if username == "SALIR":
        return None

    return username


def Med_vencidos():
    centro_medico = input("Ingrese el ID del centro médico que busca: ")
    cursor.execute("SELECT * FROM inventario WHERE id_centro_medico = %s", (centro_medico,))
    lista_tuplas = cursor.fetchall()
    lista_fechas = [row[4] for row in lista_tuplas]
    lista_medicinas = [row[1] for row in lista_tuplas]
    fecha_actual = datetime.datetime.now().date()

    for i in range(len(lista_fechas)):
        diferencia = lista_fechas[i] - fecha_actual
        if diferencia.days <= 0:
            print("_______________________________________________________________")
            print(f"El producto {lista_medicinas[i]} con fecha de vencimiento {lista_fechas[i]} ya venció.")
        elif 0 < diferencia.days <= 14:
            print("_______________________________________________________________")
            print(
                f"El producto {lista_medicinas[i]} con fecha de vencimiento {lista_fechas[i]} vencerá en 2 semanas o menos.")


def Med_por_terminarse():
    centro_medico = input("Ingrese el ID del centro médico que busca: ")
    cursor.execute("SELECT * FROM inventario WHERE id_centro_medico = %s", (centro_medico,))
    lista_tuplas = cursor.fetchall()
    lista_medicinas = [row[1] for row in lista_tuplas]
    lista_cantidades = [row[2] for row in lista_tuplas]
    lista_capacidad = [row[3] for row in lista_tuplas]

    for i in range(len(lista_cantidades)):
        porcentaje = (lista_cantidades[i] / lista_capacidad[i]) * 100
        if porcentaje <= 15:
            print("_____________________________________________________")
            print(f"El producto {lista_medicinas[i]} está por debajo del 15 porciento de su capacidad.")


def mostrar_bitacora_traspasos():
    cursor.execute("""
        SELECT h.fecha_cambio, h.num_colegiatura_anterior, m_antiguo.id_centro_medico AS hospital_anterior, 
        m_nuevo.id_centro_medico AS nuevo_hospital, h.motivo_cambio
        FROM historial_cambios_medicos h
        JOIN medico m_antiguo ON h.num_colegiatura_anterior = m_antiguo.num_colegiatura
        JOIN medico m_nuevo ON h.num_colegiatura_nuevo = m_nuevo.num_colegiatura
    """)
    cambios_medicos = cursor.fetchall()
    if not cambios_medicos:
        print("No hay registros en la bitácora de traspasos de médicos.")
    else:
        print("Bitácora de traspasos de médicos:")
        for cambio in cambios_medicos:
            fecha_cambio = cambio[0]
            num_colegiatura = cambio[1]
            hospital_anterior = cambio[2]
            nuevo_hospital = cambio[3]
            print(f"Fecha del cambio: {fecha_cambio}")
            print(f"Número de colegiatura: {num_colegiatura}")
            print(f"Nuevo hospital (ID): {nuevo_hospital}")



print("    SISTEMA HOSPITALARIO INICIO DE SESIÓN   \n")
print("(1) Registrar nuevo usuario \n(2) Iniciar sesión")
respuesta = int(input("Ingrese la opción que desee: "))

while True:
    if respuesta == 1:
        registrar_usuario()
        print("\n(1) Registrar nuevo usuario \n(2) Iniciar sesión")
        respuesta = int(input("\nIngrese la opción que desee: "))
    elif respuesta == 2:
        user = login()
        if user:
            break

while True:
    respuesta = menu()

    if respuesta == 1:
        print("(1) Verificar productos por vencer\n(2) Verificar productos por acabarse")
        opcion = int(input("Elija la opción que desee: "))
        if opcion == 1:
            Med_vencidos()
        elif opcion == 2:
            Med_por_terminarse()
    elif respuesta == 2:
        while True:
            nombre_paciente = input(
                "Ingrese el nombre del paciente que desea buscar (o escriba 'SALIR' para volver al menú): ")
            if nombre_paciente.upper() == 'SALIR':
                break

            cursor.execute(
                "SELECT * FROM reporte_medico WHERE id_paciente IN (SELECT dpi FROM paciente WHERE nombre = %s)",
                (nombre_paciente,))
            expedientes = cursor.fetchall()

            if len(expedientes) > 0:
                print("Expedientes encontrados para", nombre_paciente, ":\n")
                for expediente in expedientes:
                    print(expediente)
            else:
                print("No se encontraron expedientes para", nombre_paciente)
    elif respuesta == 5:
        while True:
            print("Seleccione una opción de Reportería:")
            print("(1) El top 10 de las enfermedades más mortales")
            print("(2) Top 10 de los médicos que más pacientes han atendido")
            print("(3) El top 5 de los pacientes con más asistencias a alguna unidad de salud")
            print("(4) Reporte mensual por unidad médica de las medicinas o suministros que están a punto de terminarse")
            print("(5) Reporte de los 3 hospitales, centros de salud y clínicas que más pacientes atienden")
            print("(6) Volver al menú principal")

            opcion_reporteria = int(input("Ingrese la opción de Reportería que desee: \n"))
            print("")

            if opcion_reporteria == 1:
                cursor.execute("""
                    select r.enfermedad_tratada, count(*) as pacientes_fallecidos
                    from reporte_medico r
                    join (
                        select id_reporte, status_paciente
                        from historial
                        where seguimiento = (select max(seguimiento) from historial h2 where h2.id_reporte = historial.id_reporte)
                    ) h
                    on r.id_reporte = h.id_reporte
                    where h.status_paciente = 'Muerto'
                    group by r.enfermedad_tratada
                    order by pacientes_fallecidos desc limit 10
                """)
                
                result = cursor.fetchall()
                print("TOP 10 ENFERMEDADES: \n")
                for row in result:
                    print(row)
                print("")
                    
            if opcion_reporteria == 2:
                cursor.execute("""
                    select medico.num_colegiatura, medico.nombre, count(reporte_medico.id_medico) as pacientes_atendidos
                    from medico
                    join reporte_medico on medico.num_colegiatura = reporte_medico.id_medico
                    group by medico.num_colegiatura, medico.nombre
                    order by pacientes_atendidos desc limit 10
                """)
                result = cursor.fetchall()
                print("TOP 10 MÉDICOS: \n")
                for row in result: 
                    print(row)
                print("")
            if opcion_reporteria == 3:
                cursor.execute("""
                    select paciente.nombre, count(historial.id_reporte) as asistencias_centros_medicos, paciente.peso, paciente.altura, paciente.masa_corporal
                    from paciente
                    join reporte_medico on paciente.dpi = reporte_medico.id_paciente
                    join historial on historial.id_reporte = reporte_medico.id_reporte
                    group by paciente.nombre, paciente.peso, paciente.altura, paciente.masa_corporal
                    order by asistencias_centros_medicos desc limit 5
                """)
                result = cursor.fetchall()
                print("TOP 5 PACIENTES: \n")
                for row in result:                  
                    print(row)
                print("")
            if opcion_reporteria == 4:
                cursor.execute("""
                    select inventario.nombre_producto, centro_medico.nombre, inventario.cantidad_producto, inventario.capacidad_producto, cast(inventario.cantidad_producto as float)/cast(inventario.capacidad_producto as float) * 100 as porcentaje_disponible
                    from inventario
                    join centro_medico on inventario.id_centro_medico = centro_medico.id
                    where inventario.cantidad_producto <= 0.15 * inventario.capacidad_producto
                    order by porcentaje_disponible desc
                """)
                result = cursor.fetchall()
                print("REPORTE MENSUAL MED: \n")
                for row in result:
                    print(row)
                print("")
            if opcion_reporteria == 5:
                cursor.execute("""
                    select centro_medico.nombre, count(reporte_medico.id_centro_medico) as pacientes_atendidos
                    from centro_medico
                    join reporte_medico on centro_medico.id = reporte_medico.id_centro_medico
                    group by centro_medico.nombre
                    order by pacientes_atendidos desc limit 3
                """)
                result = cursor.fetchall()
                print("REPORTE HOSPITALES: \n")
                for row in result:
                    print(row)
                print("")
            elif opcion_reporteria == 6:
                break
    elif respuesta == 6:
        def menudeopciones():
            print("Sistema de registro interno\n")
            opciones = '\n1: Registrar un nuevo médico\n2: Registrar un nuevo paciente\n3: Salir'
            op = 0
            print(opciones)
            op = input('Seleccione una opción: ')
            print(
                "---------------------------------------------------------------------------------------------------------------------------------------")
            bandera = False
            while not bandera:
                if op.isdigit():
                    op = int(op)
                    if 1 <= op <= 3:
                        bandera = True
                    else:
                        print("Error, ingrese una opción válida del menú (1-3).")
                        op = input('Seleccione una opción: ')
                else:
                    print("Error, debe ingresar un número del menú (1-3).")
                    op = input('Seleccione una opción: \n')
            return op



        opcion_usu = menudeopciones()

        while opcion_usu != 3:
            if opcion_usu == 1:
                print("Bienvenido, a Registro de Médico\n")


                def ingresar_medico():
                    conexion = conn
                    cursor = conexion.cursor()
                    num_colegiatura = input("Ingrese el número de colegiatura del médico: ")

                    cursor.execute("SELECT * FROM medico WHERE num_colegiatura = %s", (num_colegiatura,))
                    existing_medico = cursor.fetchone()

                    if existing_medico:
                        print("El médico ya existe en la base de datos. Puede realizar un cambio de hospital.")
                        nuevo_id_centro_medico = int(input("Ingrese el nuevo ID del centro médico: "))

                        # Corregir el motivo del cambio
                        motivo_cambio = "Cambio de personal"

                        # Registra el cambio en la bitácora de traspasos
                        cursor.execute("""
                            INSERT INTO historial_cambios_medicos (num_colegiatura_anterior, num_colegiatura_nuevo, motivo_cambio)
                            VALUES (%s, %s, %s)
                        """, (num_colegiatura, nuevo_id_centro_medico, motivo_cambio))
                        conexion.commit()

                        cursor.execute("""
                            UPDATE medico
                            SET id_centro_medico = %s
                            WHERE num_colegiatura = %s
                        """, (nuevo_id_centro_medico, num_colegiatura))
                        conexion.commit()
                        print("El médico ha sido transferido a un nuevo hospital.")
                    else:
                        nombre = input("Ingrese el nombre del médico: ")
                        direccion = input("Ingrese la dirección del médico: ")
                        telefono = input("Ingrese el teléfono del médico: ")
                        id_centro_medico = int(input("Ingrese el ID del centro médico: "))
                        especialidad = input("Ingrese la especialidad del médico: ");
                        contraseña = input("Ingrese la contraseña del médico: ")

                        try:
                            cursor.execute("""
                                INSERT INTO medico (num_colegiatura, nombre, direccion, telefono, id_centro_medico, especialidad, contraseña)
                                VALUES (%s, %s, %s, %s, %s, %s, %s)
                            """, (
                            num_colegiatura, nombre, direccion, telefono, id_centro_medico, especialidad, contraseña))
                            conexion.commit()
                            print("Médico ingresado correctamente.")
                        except Exception as e:
                            print("Error al ingresar médico:", e)
                        finally:
                            cursor.close()


                if __name__ == "__main__":
                    ingresar_medico()

                opcion_usu = menudeopciones()
            if opcion_usu == 2:
                print("Bienvenido a Registro de Paciente")


                def ingresar_paciente():
                    conexion = conn
                    cursor = conexion.cursor()
                    dpi = input("Ingrese el DPI del paciente: ")
                    nombre = input("Ingrese el nombre del paciente: ")
                    direccion = input("Ingrese la dirección del paciente: ")
                    telefono = input("Ingrese el teléfono del paciente: ")
                    altura = input("Ingrese la altura del paciente: ")
                    masa_corporal = input("Ingrese la masa corporal del paciente: ")
                    peso = input("Ingrese el peso del paciente: ")
                    enfermedades_herencia = input("Ingrese las enfermedades hereditarias del paciente: ")

                    try:
                        cursor.execute("""
                            INSERT INTO paciente (dpi, nombre, direccion, telefono, altura, masa_corporal, peso, enfermedades_herencia)
                            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                        """, (dpi, nombre, direccion, telefono, altura, masa_corporal, peso, enfermedades_herencia))
                        conexion.commit()
                        cursor.execute("""
                            UPDATE bitacora_bd
                            SET nombre_usuario = %s
                            WHERE id = currval('bitacora_bd_id_seq')
                        """, (user,))
                        conexion.commit()
                        print("Paciente ingresado correctamente.")
                    except Exception as e:
                        print("Error al ingresar paciente:", e)
                    finally:
                        cursor.close()


                if __name__ == "__main__":
                    ingresar_paciente()
                print("")
                opcion_usu = menudeopciones()

    elif respuesta == 3:
        cursor.execute("""SELECT * FROM bitacora_bd""")
        rows = cursor.fetchall()
        for row in rows:
            print(row)
    elif respuesta == 4:
        mostrar_bitacora_traspasos()

    elif respuesta == 7:
        print("Muchas gracias por utilizar este programa")
        break
