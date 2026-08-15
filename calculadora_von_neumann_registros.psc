Proceso Calculadora_Von_Neumann_Registros

	// =====================================================================
	// Modelo basado en: https://lab.xitrus.es/VonNeumann/
	// Aqui los "componentes" no son solo comentarios: son variables reales
	// que representan cada registro del simulador:
	//
	//   Memoria             -> Vector con Direccion y Contenido
	//   RegDirecciones      -> que direccion de memoria se esta consultando
	//   RegDatos            -> el dato que entra o sale de esa direccion
	//   ContadorPrograma    -> cuantos ciclos de instruccion han pasado
	//   RegInstrucciones    -> la instruccion que se esta ejecutando
	//   Decodificador       -> el nombre de la operacion ya interpretada
	//   Acumulador          -> donde la ALU deja el resultado del calculo
	//   RegEntrada          -> los datos que el usuario ingresa, antes de
	//                          pasar a Memoria
	// =====================================================================

	Definir Memoria Como Real
	Dimension Memoria[10]

	Definir RegDirecciones, RegDatos, RegEntrada Como Real
	Definir ContadorPrograma, RegInstrucciones Como Entero
	Definir Decodificador Como Cadena
	Definir Acumulador, numeroA, numeroB Como Real
	Definir continuar Como Caracter

	ContadorPrograma <- 0
	continuar <- "S"

	Mientras continuar = "S" o continuar = "s"

		Escribir "=========================================="
		Escribir "   CALCULADORA - REGISTROS VON NEUMANN"
		Escribir "=========================================="
		Escribir "1. Sumar    2. Restar    3. Multiplicar    4. Dividir"
		Escribir "Seleccione la instruccion:"

		// ===== FETCH: la instruccion entra al Registro de Instrucciones =====
		Leer RegInstrucciones
		ContadorPrograma <- ContadorPrograma + 1
		Escribir ""
		Escribir "Cont. Programa = " , ContadorPrograma
		Escribir "Reg. Instrucciones = " , RegInstrucciones

		// ===== ENTRADA: los datos pasan por el Registro de Entrada antes =====
		// ===== de escribirse en Memoria, usando el Registro de Direcciones ===
		Escribir "Ingrese el primer numero:"
		Leer RegEntrada
		RegDirecciones <- 1
		Memoria[RegDirecciones] <- RegEntrada
		Escribir "Reg. Entrada = " , RegEntrada , "  -> escrito en Memoria[" , RegDirecciones , "]"

		Escribir "Ingrese el segundo numero:"
		Leer RegEntrada
		RegDirecciones <- 2
		Memoria[RegDirecciones] <- RegEntrada
		Escribir "Reg. Entrada = " , RegEntrada , "  -> escrito en Memoria[" , RegDirecciones , "]"

		// ===== DECODE: el Decodificador interpreta el Registro de Instrucciones =====
		Segun RegInstrucciones Hacer
			1:
				Decodificador <- "SUMA"
			2:
				Decodificador <- "RESTA"
			3:
				Decodificador <- "MULTIPLICACION"
			4:
				Decodificador <- "DIVISION"
			De Otro Modo:
				Decodificador <- "INSTRUCCION NO VALIDA"
		FinSegun
		Escribir "Decodificador = " , Decodificador

		// ===== EXECUTE: la Unidad de Control lee los operandos de Memoria =====
		// ===== hacia el Registro de Datos, y se los entrega a la ALU =========
		RegDirecciones <- 1
		RegDatos <- Memoria[RegDirecciones]
		numeroA <- RegDatos
		Escribir "Reg. Direcciones = " , RegDirecciones , "  ->  Reg. Datos = " , RegDatos

		RegDirecciones <- 2
		RegDatos <- Memoria[RegDirecciones]
		numeroB <- RegDatos
		Escribir "Reg. Direcciones = " , RegDirecciones , "  ->  Reg. Datos = " , RegDatos

		// ===== ALU: calcula y deja el resultado en el Acumulador =====
		Segun Decodificador Hacer
			"SUMA":
				Acumulador <- numeroA + numeroB
			"RESTA":
				Acumulador <- numeroA - numeroB
			"MULTIPLICACION":
				Acumulador <- numeroA * numeroB
			"DIVISION":
				Si numeroB <> 0 Entonces
					Acumulador <- numeroA / numeroB
				SiNo
					Escribir "ERROR: la ALU no puede dividir entre cero"
					Acumulador <- 0
				FinSi
			De Otro Modo:
				Acumulador <- 0
		FinSegun
		Escribir "Acumulador (resultado de la ALU) = " , Acumulador

		// ===== WRITE-BACK: el Acumulador pasa por el Registro de Datos y =====
		// ===== se escribe en Memoria, en la direccion del resultado ==========
		RegDatos <- Acumulador
		RegDirecciones <- 3
		Memoria[RegDirecciones] <- RegDatos
		Escribir "Reg. Datos = " , RegDatos , "  -> escrito en Memoria[" , RegDirecciones , "]"

		Escribir ""
		Escribir "RESULTADO FINAL (Memoria[3]) = " , Memoria[3]
		Escribir ""

		Escribir "Desea realizar otra operacion? (S/N)"
		Leer continuar

	FinMientras

	Escribir "Fin del programa. Ciclos ejecutados: " , ContadorPrograma

FinProceso
