//* --------------------------Sección de código de usuario ------------------------*/ 

import java_cup.runtime.Symbol;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;

%% 

/* -----------------Sección de opciones y declaraciones -----------------*/ 

/* Nombre de la clase generada para el analizador léxico*/ 
%class analex 

/* Posibilitar acceso al número de carácter, la columna y la fila actual de análisis*/ 
%char
%line
%column

/* Habilitar la compatibilidad con el interfaz CUP para el generador sintáctico */
%cup

%{ /*  Declaraciones */
	/* Constructor que carga la fábrica de símbolos */
	public analex(java.io.Reader in, ComplexSymbolFactory sf){
		this(in);
		symbolFactory = sf;
    }
    ComplexSymbolFactory symbolFactory;

	/* Crear un nuevo objeto Symbol con informacion sobre el token actual sin valor */
	private Symbol symbol(String name, int sym) {
		return symbolFactory.newSymbol(name, sym, new Location(yyline+1,yycolumn+1,yychar), new Location(yyline+1,yycolumn+yylength(),yychar+yylength()));
	}

	/* Ídem con valor */
	private Symbol symbol(String name, int sym, Object val) {
		Location left = new Location(yyline+1,yycolumn+1,yychar);
		Location right= new Location(yyline+1,yycolumn+yylength(),yychar+yylength());
		return symbolFactory.newSymbol(name, sym, left, right, val);
	}
%}

/* Reconocimiento correcto del fin de archivo */
%eofval{
     return symbolFactory.newSymbol("EOF", sym.EOF, new Location(yyline+1,yycolumn+1,yychar), new Location(yyline+1,yycolumn+1,yychar+1));
%eofval}

%%
/* ------------------------Sección de reglas lexicas----------------------*/

[1-9][0-9]*|0 		{return symbol("num", sym.NUM, Integer.parseInt(yytext()));}

"+" 		{return symbol("mas",sym.MAS);}
"-" 		{return symbol("menos",sym.MENOS);}
";" 		{return symbol("pyc",sym.PYC);}
"(" 		{return symbol("parizq",sym.PARIZQ);}
")" 		{return symbol("parder",sym.PARDER);}

\n|\r|\t	{}

. {System.out.println("Token No Valido <" +yytext()+ ">linea: " + (yyline+1) + " columna: " + (yycolumn+1));}

