PROGRAM Ancient_Egyptian_Multiplier (input, output);

{Algoritmo de multiplicación entre dos números naturales que sólo requiere la capacidad de multiplicar y dividir por 2, y la de sumar.}

{Para un producto A x B, este algoritmo se basa en la multiplicación de B por la descomposición de A en factores binarios.
 Por ejemplo, si A = 13 y B = 7, se siguen los siguientes pasos:

1) Se pasa A al sistema binario. En este caso sería 1101. Para llegar a este número se hacen
   divisiones enteras sucesivas entre 2, y nos quedamos sólo con sus restos. Si el resto es 0,
   se dividió a un número par, y si es 1, se dividió a un número impar. 

2) Se pasa A al sistema decimal y se deja este en su descomposición de factores binarios. 1 X 2^3  +  1 X 2^2  +  0 X 2^1  +  1 X 2^0  =  8 + 4 + 0 + 1.
   Dado que ultilizar ceros del código binario no nos da ninguna información, sólo nos concentramos en los impares. 

3) Se multiplica B por la descomposición de A en factores binarios. B X (8 + 4 + 1) = 7 X (8 + 4 + 1) = 56 + 28 + 7.
   Se puede apreciar que 7, 28 y 56 tienen como común divisor al 7; esto no es una coincidencia y se sigue en mayor detalle en los siguientes pasos.

4) 1101 son 4 dígitos, leyéndose de derecha a izquierda es 1011. Dicho número corresponde a A y sus 3 divisiones sucesivas: 13, 6, 3, 1.
   Como ya se mencionó, el cero corresponde a un número par (el 6 en este caso), el cual obviaremos.

5) 1011 corresponde a 4 números. Esta vez utilizándo B, en vez de dividir entre 2, multiplicarémos por 2: 7, 14, 28, 56.
   Probablemente noten un parecido con los números del paso 3): 7, 28, 56.
   La única diferencia es el 14, el cual corresponde con el 6 de las divisiones de A,
   el cual corresponde con el 0 del sistema binario, por lo que no nos da información y lo debemos obviar.

6) Si sumamos los productos de B (sólo los que están asociados a un numero impar de los números de A),
   nos da como resultado el producto original: 7 + 28 + 56 = 13 X 7.

Nota: dado que la cantidad de operaciones depende de A (ya que debe dividirse por 2 hasta llegar a 1),
      por una cuestión de eficiencia, es mejor que A sea menor que B.}

{******************************************************************************************************************************************************************}

TYPE EnteroPositivo = 1 .. MAXINT;

VAR num1, num2 : EnteroPositivo;

{******************************************************************************************************************************************************************}

FUNCTION doble (x : Integer) : Integer;

BEGIN
   doble := x + x
END;

{******************************************************************************************************************************************************************}

FUNCTION mitad (x : Integer) : Integer;

BEGIN
   mitad := x DIV 2
END;

{******************************************************************************************************************************************************************}

FUNCTION esImpar (n : Integer) : Boolean;

BEGIN
   esImpar := odd (n)
END;

{******************************************************************************************************************************************************************}

PROCEDURE intercambio (VAR a, b : Integer);

{Intercambia el valor del parámetro "a" por el del parámetro "b". Los parámetros los toma por referencia
para que la función "Multiplicacion" los pueda utilizar con sus nuevos valores (intercambiados).}

VAR temp : Integer;

BEGIN
    temp := a;        {Guarda temporalmente el valor del parámetro "a" para que en la próxima asignación no se pierda su valor original}
    a    := b;
    b    := temp      {(de lo contrario no se le podría asignar al parámetro "b" el valor del parámetro "a" original).}
END;

{******************************************************************************************************************************************************************}

FUNCTION Multiplicacion (a, b : Integer) : Integer;

VAR acumulador : Integer;   

BEGIN
   acumulador := 0; {Inicialización de la variable "acumulador".}

   IF a > b THEN
      intercambio (a, b); {Se asegura que el parámetro "a" sea menor o igual que el parámetro "b",lo cual es importante
                           para reducir la cantidad de operaciones dentro del cuerpo del repeat (mayor eficiencia).}
   REPEAT
      IF esImpar (a) THEN
         acumulador := acumulador + b; {Por lo justificado en el comentario gigante del inicio, sólo nos importa guardar los valores del parámetro "b"
                                        cuando su parámetro asociado "a" es impar. Utilizando un acumulador, se acumulan los valores del paŕametro "b".}   
      a := mitad (a); {División entera por 2 del valor del parámetro "a".}
      b := doble (b); {Multiplica el valor del parámetro "b" por 2.}
   UNTIL a < 1;       {El repeat se rompe una vez que al parámetro "a" se le asigna el valor 0 (su última asignación).
                       Dado que el if está al inicio del repeat, no se hará un "doble(b)" de más (en el acumulador).}

   Multiplicacion := acumulador {El producto entre el parámetro "a" y el parámetro "b" es igual al valor de la variable "acumulador".}
END;

{******************************************************************************************************************************************************************}

{Programa principal}

BEGIN
   Write ('Ingrese dos números: ');
   Readln (num1, num2);

   Writeln ('Resultado: ', Multiplicacion (num1, num2))
END.