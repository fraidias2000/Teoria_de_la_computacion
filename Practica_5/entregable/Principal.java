package javaapplication20;

import java_cup.runtime.*;
import java.io.*;

public class Principal{
	
	public static void main(String[]args) {
		try{
		  ComplexSymbolFactory csf = new ComplexSymbolFactory();
		  ScannerBuffer lexer = new ScannerBuffer(new Analex(new BufferedReader(new FileReader(args[0])),csf));
		  parser p = new parser(lexer,csf);
		  p.parse();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	 	finally{
			System.out.println("Analisis finalizado, el numero de trabajadores en la empresa es: " + parser.trabajadores);
		}
	}
}
