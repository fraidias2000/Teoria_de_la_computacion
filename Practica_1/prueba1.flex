%%
%class Numeros
%public
%standalone
%unicode
%{
public int cont;
%}
%eof{
System.out.println ("Numeros reconocidos : \n" +cont);

%eof}
%init{
cont = 0;
%init}
%%
[0-9]+ {cont = cont + 1; }
\r|\n {}
. {}