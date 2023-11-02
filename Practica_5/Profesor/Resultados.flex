import java_cup.runtime.Symbol;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;

%% 

/* Nombre de la clase generada para el analizador l�xico*/ 
%class analex

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

=Equipos=					{return symbol("inicioEquipos", sym.INICIO_EQUIPOS);}
=Fin_equipos=				{return symbol("finEquipos", sym.FIN_EQUIPOS);}
=Resultados=				{return symbol("inicioResultados", sym.INICIO_RESULTADOS);}
=Fin_resultados=			{return symbol("finResultados", sym.FIN_RESULTADOS);}
"-"							{return symbol("separadorGuion", sym.SEPARADOR_GUION);}
";"							{return symbol("separadorPYC", sym.SEPARADOR_PYC);}
[A-Z�-��][A-Z�-��a-z�-��_]*	{return symbol("nombreEquipo", sym.NOMBRE_EQUIPO, yytext());}
[0-9]+						{return symbol("goles", sym.GOLES, Integer.parseInt(yytext()));}
\r|\n|\t|" "				{}
.							{System.out.println("Error: el texto " + yytext() + " no es v�lido");}


