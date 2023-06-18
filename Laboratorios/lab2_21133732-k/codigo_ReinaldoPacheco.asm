.data
cuatro: .double 4.0 # se define el numero 4 float que se utilizará para la aproximación de pi
mensaje: .asciiz "La aproximación del número pi es: "

.text
main:
  beq $s3, 1000, calculoPi   # cantidad de puntos usada, una vez terminada, salta a calcular el valor de pi
  jal GenerarPuntoAleatorio # si aún no termina, se llama a las subrutinas para generar si el punto está dentro del círculo
  jal PuntoDentroDelCirculo
  j main #vuelve a main para seguir generando puntos

GenerarPuntoAleatorio:
  addi $sp, $sp, -8 # se reserva espacio en la pila stack para almacenar registros
  li $a1, 101
  li $v0, 42 # se generan un numero aleatorios en el rango de 0 a 100 incluyendo a dichos numeros para la coordenada x
  syscall
  
  move $s0, $a0
  li $a1, 101
  li $v0, 42 # se realiza lo mismo para la coordenada y
  syscall
  
  move $s1, $a0
  sw $s0, 0($sp) ## se guardan los valores en la pila
  sw $s1, 4($sp) 
  addi $sp, $sp, 8 ## se restaura el espacio utilizado
  jr $ra

CalcularDistancia:
  addi $sp, $sp, -8 ## se reserva espacio en la pila para almacenar los registros
  mtc1 $s0, $f2
  mtc1 $s1, $f4		## se convierten los valores almacenados a números punto flotante para trabajar con ellos
  cvt.d.w $f2, $f2
  cvt.d.w $f4, $f4
  mul.d $f6, $f2, $f2 ## se calculan los valores al cuadrado
  mul.d $f8, $f4, $f4
  add.d $f10, $f6, $f8 
  sqrt.d $f12, $f10  ## se calcula la raiz cuadrada de la suma entre los valores para obtener la distancia
  round.w.d $f16, $f12 # se redonde el valor de la raíz
  mfc1 $v1, $f16 
  addi $sp, $sp, 8 ## se restaura el valor de la pila utilizado
  jr $ra

PuntoDentroDelCirculo:
  jal CalcularDistancia
  ble $v1, 100, PuntosDentroDelCirculo ## compara la distancia calculada con 100, para saber si el punto está dentro del circulo
  j PuntosAfueraDelCirculo
 ## salta a la subrutina PuntosAfuera en el caso contrario
PuntosDentroDelCirculo:
  addi $s2, $s2, 1 ## contador de los puntos dentro del círculo
  addi $s3, $s3, 1 ## contador de los puntos totales generados
  j main
## salta a main para generar más puntos

PuntosAfueraDelCirculo:
  addi $s3, $s3, 1 ## contador de los puntos totales si es que el punto está afuera del circulo
  j main
 ## salta a main para generar más puntos

calculoPi:
  mtc1 $s2, $f2
  mtc1 $s3, $f4 ## se convierten los valores a números de punto flotante
  cvt.d.w $f2, $f2
  cvt.d.w $f4, $f4
  div.d $f6, $f2, $f4 ## se realiza la división entre los puntos que están dentro del circulo con los puntos generados totales
  ldc1 $f8, cuatro  ## se carga el valor 4.0
  mul.d $f10, $f6, $f8 ## se multiplica el valor almacenado 4.0 con la división realizada anteriormente
  
  la $a0, mensaje ## se carga el mensaje del valor obtenido de Pi
  li $v0, 4
  syscall
  mov.d $f12, $f10 
  li $v0, 3 ## se muestra el valor obtenido de pi por consola
  syscall
  li $v0, 10 ## finaliza el programa
  syscall
