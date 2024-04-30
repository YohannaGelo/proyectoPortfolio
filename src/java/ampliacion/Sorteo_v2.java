/*
Los participantes se pasarán a partir de una lista separando cada uno a partir de comas:

Genera 20 nombres (Con apellidos) aleatorios a partir de alguna web.

Solo debe haber un ganador. Al ganar, desaparece de la lista.

Las condiciones de salida son: 
 - La lista se ha vaciado. 
 - El usuario escribe salir.
 */
package ampliacion;

import java.util.Scanner;

/**
 *
 * @author Yohanna Gelo
 */
public class Sorteo_v2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws InterruptedException {

        Scanner s = new Scanner(System.in);

        //COLORES
        String cyan = "\u001B[36m";
        String azul = "\u001B[34m";
        String naranja = "\033[33m";
        String rojo = "\u001B[31m";
        String morado = "\u001B[35m";
        String reset = "\u001B[0m";
        
        //LANZO LOGO
        ampliacion.Sorteo.logo(cyan, azul, morado, reset);

        //LANZO MENÚ
        int opt = ampliacion.Sorteo.menu(cyan, azul, morado, reset);
   
        if (opt == 0) {
            //SALIR DEL PROGRAMA
            ampliacion.Sorteo.bye(rojo);
        } else {
            //EJECUTO SEGÚN LA OPCIÓN Y SALGO CUANDO LO DIGA EL USUARIO O NO QUEDEN CONCURSANTES
            ampliacion.Sorteo.option(opt, cyan, azul, morado, naranja, rojo, reset, s);
            ampliacion.Sorteo.bye(rojo);
        }

        System.out.println("\n");     //simplemente para separar el mensaje de BUILD SUCCESSFUL (total time: 2 seconds)

    }

}
