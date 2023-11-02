%%
%class Practica2
%public
%standalone
%unicode
%line
%column
%eof{
System.out.println ("Fin de programa");
%eof}
%init{
%init}
%%
[A-ZÁÉÍÓÚ][A-Za-zÁÉÍÓÚáéíóú]*  {System.out.println("Se ha encontrado un token nombre: " + yytext());}	
[+34][6]?[7]?[0-9]*{8} {System.out.println ("Se ha encontrado un token tipo numero telefono: " + yytext());}
[0-9]* {System.out.println ("Se ha encontrado un token cifra: " + yytext());}
[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4}) {System.out.println ("Se ha encontrado un token correo: " + yytext());}
[&(a-zA-Z0-9)&]* {System.out.println ("Se ha encontrado un token contraseña: " + yytext());}



(  , ) {System.out.println("Se ha encontrado un token separador coma: "  + yytext());}
( "[" ) {System.out.println("Se ha encontrado un token inicio de bloque llave:  " + yytext());}
( "]" ) {System.out.println("Se ha encontrado un token final de bloque llave: " + yytext());}
( ; ) {System.out.println("Se ha encontrado un token separador punto y coma: " + yytext());}

\r|\n|\s|\t" " {System.out.println("Se ha encontrado un salto");}
. {System.out.println("Error, no se ha encontrado ningun token en la linea: " + yyline + " y  en la columna: " + yycolumn  + " con el texto: " + yytext());}
