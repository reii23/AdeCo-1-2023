.data
mensaje: .asciiz "Seleccione la operación a realizar: 1 = Suma 2 = Resta 3 = Multiplicación 4 = División \n"

.text

# se extrae el primer número y guardarlo en $t0
primerA:
	li $t9, 0                 # se inicializa $t9 en 0 (posición del primer número)
	lw $t0, 0x100100a0($t9)   # se carga el primer número desde el segmento de datos

# se extra el segundo dígito del primer número
segundoA:
	add $t9, $t9, 4
	add $t2, $t2, 10
	add $t3, $t3, 0
	add $t4, $t4, 0
	lw $t1, 0x100100a0($t9)

# see multiplica por 10^1 = 10
multDiezA:
	beq $t1, $t3, sumarA1
	add $t3, $t3, 1
	add $t4, $t4, $t2
	j multDiezA
sumarA1:
	add $t0, $t4, $t0
# se almacena el resultado para ir sumandolo

# se extra el siguiente dígito del primer número
terceroA:
	li $t9, 8
	li $t2, 100
	li $t3, 0
	li $t4, 0
	lw $t1, 0x100100a0($t9)
# se multiplicarlo por 10^2 = 100
	multCienA:
		beq $t1, $t3, sumarA2
		add $t3, $t3, 1
		add $t4, $t4, $t2
		j multCienA
	sumarA2:
		add $t0, $t4, $t0

# se extrae el siguiente digito del primer número y se multiplica por 10^3 = 1000
cuartoA:
	li $t9, 12
	li $t2, 1000
	li $t3, 0
	li $t4, 0
	lw $t1, 0x100100a0($t9)

	multMilA:
		beq $t1, $t3, sumarA3
		add $t3, $t3, 1
		add $t4, $t4, $t2
		j multMilA
	sumarA3:
		add $t0, $t4, $t0

# se extrae el siguiente digito del primer numero y se multiplicar por 10^4
quintoA:
	li $t9, 16
	li $t2, 10000
	li $t3, 0
	li $t4, 0
	lw $t1, 0x100100a0($t9)
	multDiezMilA:
		beq $t1, $t3, sumarA4
		add $t3, $t3, 1
		add $t4, $t4, $t2
		j multDiezMilA
	sumarA4:
		add $t0, $t4, $t0

# se extrae el siguiente digito del primer numero y se multiplica por 10^5 = 100.000
sextoA:
	li $t9, 20
	li $t2, 100000
	li $t3, 0
	li $t4, 0
	lw $t1, 0x100100a0($t9)
	multCienMilA:
		beq $t1, $t3, sumarA5
		add $t3, $t3, 1
		add $t4, $t4, $t2
		j multCienMilA
	sumarA5:
		add $t0, $t4, $t0

# se extrae el sexto dígito del primer número y se multiplica por 10^6 = 1.000.000
septimoA:
	li $t9, 24
	li $t2, 1000000
	li $t3, 0
	li $t4, 0
	lw $t1, 0x100100a0($t9)
	multMillonA:
		beq $t1, $t3, sumarA6
		add $t3, $t3, 1
		add $t4, $t4, $t2
		j multMillonA
	sumarA6:
		add $t0, $t4, $t0

### se extrae el segundo número y guardarlo en $t1 ###

# se extrae el primer dígito del segundo número y multiplicarlo por 10^1 = 10
primerB:
	li $t1, 0
	li $t9, 0
	lw $t1, 0x100100c0($t9)

# se extrae el siguiente del segundo número y se multiplica por 10^2 = 100
segundoB:
	li $t9, 4
	li $t3, 10
	li $t4, 0
	li $t5, 0
	lw $t2, 0x100100c0($t9)

	multDiezB:
		beq $t2, $t4, sumarB1
		add $t4, $t4, 1
		add $t5, $t5, $t3
		j multDiezB
	sumarB1:
		add $t1, $t5, $t1

# se extrae el siguiente dígito del segundo número y se multiplica por 10^2= 100
terceroB:
	li $t9, 8
	li $t3, 100
	li $t4, 0
	li $t5, 0
	lw $t2, 0x100100c0($t9)
	multCienB:
		beq $t2, $t4, sumarB2
		add $t4, $t4, 1
		add $t5, $t5, $t3
		j multCienB
	sumarB2:
		add $t1, $t5, $t1

# se extrae el siguiente dígito del segundo número y se multiplica por 10^3 = 1000
cuartoB:
	li $t9, 12
	li $t3, 1000
	li $t4, 0
	li $t5, 0
	lw $t2, 0x100100c0($t9)
	multMilB:
		beq $t2, $t4, sumarB3
		add $t4, $t4, 1
		add $t5, $t5, $t3
		j multMilB
	sumarB3:
		add $t1, $t5, $t1

# se extrae el siguiente digito del segundo número y se multiplica por 10^4 = 10.000
quintoB:
	li $t9, 16
	li $t3, 10000
	li $t4, 0
	li $t5, 0
	lw $t2, 0x100100c0($t9)
	multDiezMilB:
		beq $t2, $t4, sumarB4
		add $t4, $t4, 1
		add $t5, $t5, $t3
		j multDiezMilB
	sumarB4:
		add $t1, $t5, $t1

# se extrae el siguiente numero del segundo numero y se multiplica por 10^5= 100.000
sextoB:
	li $t9, 20
	li $t3, 100000
	li $t4, 0
	li $t5, 0
	lw $t2, 0x100100c0($t9)
	multCienMilB:
		beq $t2, $t4, sumarB5
		add $t4, $t4, 1
		add $t5, $t5, $t3
		j multCienMilB
	sumarB5:
		add $t1, $t5, $t1

# se extrae el siguiente digito del numero y se multiplica por 1.000.000
septimoB:
	li $t9, 24
	li $t3, 1000000
	li $t4, 0
	li $t5, 0
	lw $t2, 0x100100c0($t9)
	multMillonB:
		beq $t2, $t4, sumarB6
		add $t4, $t4, 1
		add $t5, $t5, $t3
		j multMillonB
	sumarB6:
		add $t1, $t5, $t1
	j seleccionarOperacion ## salto a la función donde se selecciona la operacion

seleccionarOperacion:
	# se imprime el mensaje de selección de operación por consola
	li $v0, 4
	# se muestra el mensaje alojado en mensaje:
	la $a0, mensaje
	syscall
	li $v0, 5
	syscall
	
	## se crea un menú en donde según la opción seleccionada, saltará a la operación
	move $t6, $v0
	beq $t6, 1, Suma # operación suma
	beq $t6, 2, Resta # operación resta
	beq $t6, 3, Multiplicacion # operación multiplicación
	beq $t6, 4, Division # operación división

## suma los numeros almacenados en $t0 y $t1, que son los digitos ya extraidos
Suma:
	add $t0, $t0, $t1
	j print ## salta al print

## resta los numeros almacenados en $t0 y $t1, que son los digitos ya extraidos
Resta:
	sub $t0, $t0, $t1
	j print ## salta al print
	
## multiplica los numeros almacenados en $t0 y $t1, que son los digitos ya extraidos
Multiplicacion:
	li $s7, 0 ## inicialización de datos
	li $t2, 0
	li $t3, 0
	add $t2, $zero, $t1  # se copia el valor de $t1 a $t2 (contador de iteraciones)
	add $t3, $zero, $t0  # se guarda una copia de $t0 (valor original de $t0)

	loop:
	beqz $t2, print_multi  # salgo del bucle si $t2 == 0
	add $s7, $s7, $t3  # se suma $t0 con el valor original de $t0
	sub $t2, $t2, 1  # se disminuye el contador
	j loop  # vuelvo al bucle
	
## divide los numeros almacenados en $t0 y $t1, que son los digitos ya extraidos
Division:
	move $t9, $t0  # guarda el dividendo en $t9
	li $t8, 0  # cociente se inicializa en 0
	Division_loop:
		sub $t9, $t9, $t1  # se resta el divisor con el dividendo
		blt $t9, $zero, print_div  # si div es negativo, salir del bucle
		addi $t8, $t8, 1  # se suma el cuociente
		j Division_loop  # vuelvo al bucle

	print_div:
		move $t0, $t8  # Guardar el cociente en $t0
		j print # saltar al print
		
# muestro el resultado
print:
	li $t9, 0
	li $t2, 10
	move $a0, $t0
	li $v0, 1
	syscall
	j crearResultado ## salta a la funcion que guarda el resultado en los registros

## print de multiplicacion
print_multi:
	move $a0, $s7
	li $v0, 1
	syscall
	j mover_multi

## se crea una funcion para mover la multiplicacion
mover_multi:
	li $t9, 0
	li $t2, 10
	move $t0, $s7
	j crearResultado ## salta a la funcion que guarda el resultado en los registros

##### $t0 guarda el resultado
crearResultado:
	move $s6, $t0
	li $t8, 0

crearResultado_loop:
	slt $t7, $t0, $t2  # se establece $t3 a 1 si $t1 es menor que $t2, de lo contrario 0
	bgt $t7, $zero, guardar_final
	slt $t7, $s6, $t2  # se establece $t3 a 1 si $t1 es menor que $t2, de lo contrario 0
	bgt $t7, $zero, guardar
	sub $s6, $s6, 10 
	add $t8, $t8, 1  ## $t8 = contador que indica la cantidad de veces que se puede dividir
	j crearResultado_loop

guardar:
	sw $s6, 0x100100e0($t9)
	add $t9, $t9, 4
	move $t0, $t8
	j crearResultado

guardar_final:
	sw $t0, 0x100100e0($t9)
	j fin # salto al fin

fin:
	li $v0, 10  # termina el programa
	syscall  # llamada al sistema para terminar el programa
