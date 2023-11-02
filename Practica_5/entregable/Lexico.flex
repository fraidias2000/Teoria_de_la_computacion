//* --------------------------Secci�n de c�digo de usuario ------------------------*/ 

import java_cup.runtime.Symbol;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;

%% 

/* -----------------Secci�n de opciones y declaraciones -----------------*/ 

/* Nombre de la clase generada para el analizador l�xico*/ 
%class Analex

/* Posibilitar acceso al n�mero de car�cter, la columna y la fila actual de an�lisis*/ 
%char
%line
%column
/* Habilitar la compatibilidad con el interfaz CUP para el generador sint�ctico */
%cup

%{ /*  Declaraciones */
	/* Constructor que carga la f�brica de s�mbolos */
	public analex(java.io.Reader in, ComplexSymbolFactory sf){
		this(in);
		symbolFactory = sf;
    }
    ComplexSymbolFactory symbolFactory;

	/* Crear un nuevo objeto Symbol con informacion sobre el token actual sin valor */
	private Symbol symbol(String name, int sym) {
		return symbolFactory.newSymbol(name, sym, new Location(yyline+1,yycolumn+1,yychar), new Location(yyline+1,yycolumn+yylength(),yychar+yylength()));
	}

	/* �dem con valor */
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
/* ------------------------Secci�n de reglas lexicas----------------------*/

"Cargos" 								{return symbol("cargos",sym.CARGOS);}
"Departamentos" 							{return symbol("departamentos",sym.DEPARTAMENTOS);}
"Trabajadores" 								{return symbol("trabajadores",sym.TRABAJADORES);}
";" 									{return symbol("pyc",sym.PYC);}
[A-Z�����][A-Za-z����������]*						{return symbol("palabra",sym.PALABRA);}
[&(a-zA-Z0-9)&]* 							{return symbol("contrasenya",sym.CONTRASENYA);}
"[" 									{return symbol("par_ent",sym.PAR_ENT);}
"]" 									{return symbol("par_sal",sym.PAR_SAL);}
","									{return symbol("coma",sym.COMA);}
[0-9]*									{return symbol("cifra",sym.CIFRA, Integer.parseInt(yytext()));}
[+34][6]?[7]?[0-9]*{8} 							{return symbol("telefono",sym.TELEFONO);}
[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4}) 	{return symbol("correo",sym.CORREO);}
\r|\n|\s|\t						         	{return symbol("salto",sym.SALTO);}



. {System.out.println("Token No Valido <" +yytext()+ ">linea: " + (yyline+1) + " columna: " + (yycolumn+1));}

