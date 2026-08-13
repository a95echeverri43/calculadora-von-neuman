Proceso Calculadora_Von_Neumann
	
	// MEMORIA PRINCIPAL (simulada con variables)
	Definir numeroA, numeroB, resultado, opcion Como Real
	Definir continuar Como Caracter
	
	continuar <- "S"
	
	Mientras continuar = "S" o continuar = "s"
		
		// UNIDAD DE CONTROL: presenta el menú (decodificación de instrucción a ejecutar)
		Escribir "=========================================="
		Escribir "   CALCULADORA - ARQUITECTURA VON NEUMANN"
		Escribir "=========================================="
		Escribir "1. Sumar"
		Escribir "2. Restar"
		Escribir "3. Multiplicar"
		Escribir "4. Dividir"
		Escribir "Seleccione una operacion (instruccion a ejecutar):"
		Leer opcion
		
		// ENTRADA DE DATOS: van del dispositivo de E/S a la Memoria vía el BUS
		Escribir "Ingrese el primer numero:"
		Leer numeroA
		Escribir "Ingrese el segundo numero:"
		Leer numeroB
		
		Escribir ""
		Escribir "--- CICLO DE EJECUCION DE LA INSTRUCCION ---"
		Escribir "1) FETCH (Busqueda): la UC obtiene la instruccion seleccionada (" , opcion , ")"
		Escribir "2) DECODE (Decodificacion): la UC interpreta que operacion representa"
		Escribir "3) EXECUTE (Ejecucion): los datos viajan por el BUS desde la Memoria hasta la ALU"
		
		// UNIDAD DE CONTROL: decide qué instrucción ejecuta la ALU
		Segun opcion Hacer
			1:
				// ALU: ejecuta la operacion aritmetica
				resultado <- numeroA + numeroB
				Escribir "   -> ALU ejecuta: SUMA"
			2:
				resultado <- numeroA - numeroB
				Escribir "   -> ALU ejecuta: RESTA"
			3:
				resultado <- numeroA * numeroB
				Escribir "   -> ALU ejecuta: MULTIPLICACION"
			4:
				Si numeroB <> 0 Entonces
					resultado <- numeroA / numeroB
					Escribir "   -> ALU ejecuta: DIVISION"
				SiNo
					Escribir "   -> ERROR: division por cero (excepcion de la ALU)"
					resultado <- 0
				FinSi
			De Otro Modo:
				Escribir "   -> Instruccion no valida (fuera del set de instrucciones)"
				resultado <- 0
		FinSegun
		
		// WRITE-BACK: el resultado regresa por el BUS y se guarda en Memoria
		Escribir "4) WRITE-BACK: el resultado vuelve por el BUS y se almacena en Memoria"
		Escribir ""
		Escribir "RESULTADO ALMACENADO EN MEMORIA = " , resultado
		Escribir ""
		
		Escribir "Desea realizar otra operacion? (S/N)"
		Leer continuar
		
	FinMientras
	
	Escribir "Fin del programa. Memoria liberada."
	
FinProceso
