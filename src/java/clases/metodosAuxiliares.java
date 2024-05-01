/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

/**
 *
 * @author Yohanna Gelo
 */
public class metodosAuxiliares {
    
    
    // ENCRIPTAR
    public static String encriptando(String str) {

        String strEncriptado = "";

        char[] string = str.toCharArray();

        for (int i = 0; i < string.length; i++) {
            char casting = (char) (string[i] + 7);   // Esta variable me ayudará a sumar el numero de encriptado al char
            string[i] = casting;    // Aquí se guarda ese valor en cada celda del array
            strEncriptado = strEncriptado + string[i];   // Forma la cadena encriptada
        }

        return strEncriptado;

    }

    // DESENCRIPTAR
    public static String desencriptando(String str) {

        String strOriginal = "";

        char[] string = str.toCharArray();

        for (int i = 0; i < string.length; i++) {
            char casting = (char) (string[i] - 7);   // Esta variable me ayudará a restar el numero de encriptado al char
            string[i] = casting;    // Aquí se guarda ese valor en cada celda del array
            strOriginal = strOriginal + string[i];   // Forma la cadena con los caracteres originales
        }

        return strOriginal;

    }
    
}
