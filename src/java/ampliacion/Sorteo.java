/*
Funciones para el programa Sorteo_v2.java
 */
package ampliacion;

import java.util.Scanner;

/**
 *
 * @author Yohanna Gelo
 */
public class Sorteo {

    //LOGO
    public static void logo(String cyan, String azul, String morado, String reset) {

        //cabecera
        System.out.println("         " + cyan + "+--------------------+");
        System.out.println("         " + cyan + "|  " + azul + "� ~  " + morado + "SORTEO" + azul + "  ~ � " + cyan + " |");
        System.out.println("         +--------------------+" + reset);

    }
        //////  < -------------------- X -------------------- >  //////

    
    //MEN� INCIAL
    public static int menu( String cyan, String azul, String morado, String reset) {

        Scanner s = new Scanner(System.in);


        System.out.println("\n\n Bienvenido a mi programa, desde aqu� podr�\n  "
                + "realizar sorteos introduciendo los datos\n    de forma aleatoria o de forma "
                + "manual.\n               �Adelante!\n\n");

        System.out.println(cyan + "+--------------------------------------------+");
        System.out.println(cyan + "|                                            |");
        System.out.println(cyan + "|        " + morado + "    MEN� PRINCIPAL:    " + cyan + "             |");
        System.out.println(cyan + "|       " + azul + "     ~~~~~~~~~~~~~~  " + cyan + "                |");
        System.out.println(cyan + "|                                            |");
        System.out.println(cyan + "|  �  1. " + reset + "Usar nombres aleatorios   " + cyan + "          |");
        System.out.println(cyan + "|  �  2. " + reset + "Introducir nombres manualmente  " + cyan + "    |");
        System.out.println(cyan + "|                                            |");
        System.out.println(cyan + "|         " + azul + "   ~~~~~~~~~~~~~~    " + cyan + "              |");
        System.out.println(cyan + "|                                            |");
        System.out.println(cyan + "|  �  0. " + reset + "Termina el programa sin ejecutar " + cyan + "   |");
        System.out.println(cyan + "|                                            |");
        System.out.println(cyan + "+--------------------------------------------+");

        System.out.print("\n         Seleccione una opci�n: ");
        int opt = s.nextInt();

        while (opt < 0 || opt > 2) {
            System.out.print("    - La opci�n debe estar entre 0 y 2: ");
            opt = s.nextInt();
        }

        System.out.println("\n\n");
        return opt;
    }
            //////  < -------------------- X -------------------- >  //////

    
    //SELECCI�N DE LA OPCI�N
    public static void option ( int opt, String cyan, String azul, String morado, String naranja, String rojo, String reset, Scanner s) throws InterruptedException {
        
        String people = "";
        
        switch (opt) {
            case 1:
                //OPCI�N ALEATORIA
                
                    /*
                     * Esta es la lista de nombre aleatorios que gener� al principio, pero para darle m�s funcionalidad...
                        //people = "Ashlen Scandrett,Randi Keningley,Patin Checcucci,Arabela Sibray,Lucila Crighten,Shandy Fussell,Cayla McGuiness,Maurice Leckey,Therese Wyldbore,Livia Calafato,Cully Conachy,Ramon Burchett,Pierson Lumox,Far Dudbridge,Hillary Lartice,Nestor Girodon,Teriann Arcase,Audrey Vigars,Kennedy Calyton,Adena Camoletto";
                     * ...he decidido hacer una lista con nombre de n�meros, de esa forma si se quiere hacer un sorteo r�pido
                     * entre n personas / objetos ... simplemente puede asignar un n�mero a cada concursante y ejecutar el
                     * el sorteo normalmente.
                     */
                
                System.out.println(azul+"           SELECCI�N AUTOM�TICA\n"+reset);
                System.out.println("En esta opci�n se generar� un lista autom�tica,\n para que sea m�s funcional la lista tendr�\n nombres de n�meros que usted podr� asignar a\n    las personas u objetos a sortear.");
                people = ampliacion.Sorteo.numParticipants(s, people);
                ampliacion.Sorteo.exe(people, cyan, azul, morado, naranja, reset, s);
                break;
                
            case 2:
                //OPCI�N MANUAL
                System.out.println(azul+"            SELECCI�N MANUAL\n"+reset);
                System.out.println("    Muy bien, usted desea introducir los\n  datos manualmente. Por favor, escriba o\n    pegue los nombre separados por coma.\n    (Ejemplo: John Doe,Lisa Lweis,...): ");
                people = s.nextLine();

                boolean comma = people.contains(",");

                while (!comma) {    //control que haya puntos
                    System.out.println("\n Debe separar los nombres con comas (,): ");
                    people = s.nextLine();
                    comma = people.contains(",");
                }

                //QUER�A HACER UN CONTROL DE QUE AL MENOS HUBIERA 2 CONCURSANTES, PERO NO PODR�A TERMINAR CON EL RESTO DE TAREAS

                ampliacion.Sorteo.exe(people, cyan, azul, morado, naranja, reset, s);
                break;
            default:
                throw new AssertionError();
        }
    }
    
            //////  < -------------------- X -------------------- >  //////

    
    //ELEGIR N�MEROS DE PARTICIPANTES
    public static String numParticipants(Scanner s, String people) {

        System.out.print("\n Ingrese el n�mero de concursantes (2-20): ");
        int participants = s.nextInt();

        //limpiar buffer
        s.nextLine();
        
        while (participants < 2 || participants > 20) {
            System.out.print("    - La opci�n debe estar entre 2 y 20: ");
            participants = s.nextInt();
        }
        
        //Cadena con todos los posibles participantes
        String names = "Concursante Uno,Concursante Dos,Concursante Tres,Concursante Cuatro,Concursante Cinco,Concursante Seis,Concursante Siete,Concursante Ocho,Concursante Nueve,Concursante Diez,Concursante Once,Concursante Doce,Concursante Trece,Concursante Catorce,Concursante Quince,Concursante Diecis�is,Concursante Diecisiete,Concursante Dieciocho,Concursante Diecinueve,Concursante Veinte";
        String aux = "";
        
        //Convierto esa cadena en array
        String part[] = names.split(",");
        
        //la recorro tantas veces como participantes haya elegido el usuario
        for (int i = 0; i < participants; i++) {
            aux = part[i]+",";
            people = people+aux;    //voy concatenando los nombres
        }
        
        return people;

     
    }
    
            //////  < -------------------- X -------------------- >  //////

    
    //EJECUCI�N PRINCIPAL
    public static void exe (String people, String cyan, String azul, String morado, String naranja, String reset, Scanner s) throws InterruptedException {
        
        String person[] = people.split(",");
        
        boolean repeat = true;
        boolean full = false;
        int counter = 0;
        int round = 1;

        System.out.println("\n\n");
        
        while (repeat) {
            
            //cabecera de cada ronda
            System.out.println(naranja + "                " + round + "� RONDA" + reset);
            System.out.println(cyan + "         +--------------------+" + reset);

            System.out.print("\n Pulse intro para poner en marcha el sorteo\n   o escriba 'salir' para terminar: ");
            String answer = s.nextLine().toLowerCase();

            //controlo que el usuario solo pueda pulsar INTRO o escribir salir
            while (!answer.equals("salir") && (!answer.equals(""))) {
                System.out.print("\n  Debe pulsar INTRO o escribir 'salir':");
                answer = s.nextLine().toLowerCase();
            }

            System.out.println("\n");

            if (answer.equals("salir")) {   //en el momento que el usuario escribe salir, termina el programa
                repeat = false;

            } else {    //de lo contrario sigue el sorteo

                //recorro el array y lo muestro para ver a cada participante
                System.out.println("\n" + azul + "- . - . - . - . - . - . - . - . - . - . -" + reset);
                System.out.println("  En este momento los participantes son:\n");
                for (int i = 0; i < person.length; i++) {
                    System.out.println("    � " + cyan + (i + 1) + ":\t  " + reset + person[i].trim()); //paso el trim para eliminar posibles espacios
                }
                System.out.println(azul + "- . - . - . - . - . - . - . - . - . - . -" + reset);

                //busco el ganador
                System.out.print("\n Y el participante seleccionado es");
                for (int i = 0; i < 1; i++) {   //bucle un poco tonto, para simular que la m�quina est� cargando
                    for (int j = 1; j < 4; j++) {
                        System.out.print(". ");   //escribir� 5 puntos separados
                        Thread.sleep(400);   //con 700 milisegundos de espera entre ellos
                    }
                }

                System.out.println("\n");

                while (!full) { //con este bucle controlo que si el n� random es un participante que ya ha salido, se repita el sorteo

                    //genero un n� aleatorio entre 0 y 19 para el sorteo
                    int random = (int) (Math.random() * person.length);

                    for (int i = 0; i < person.length; i++) {

                        if (i == random && !person[i].equals("")) {
                            System.out.println("    � " + morado + (i + 1) + ":\t  " + morado + person[i] + reset);
                            person[i] = "";
                            full = true;

                        }
                    }   //fin for
                }   //fin sub while

                full = false;

            }   //fin else

            //ahora compruebo si todas las celdas est�n vacias
            for (int i = 0; i < person.length; i++) {

                if (person[i].equals("")) {
                    counter++;
                }

                //si hay tantas celdas vacias como tama�o del array, salimos.
                if (counter == person.length) {
                    System.out.println("\n\n   " + azul + "�No quedan m�s participantes!");
                    repeat = false;
                }
            }

            counter = 0;    //reiniciamos el contador
            round++;
            System.out.println("\n");

        }   //fin while
    }
    
            //////  < -------------------- X -------------------- >  //////

    
    //SALIR
    public static void bye (String rojo) {
        System.out.println("\n" + rojo + " Espero que haya disfrutado del programa.\n     " + rojo + "�GRACIAS Y HASTA LA PR�XIMA!");
        
        System.out.println("\n     ~ Creado por: Yohanna Gelo ~");
    }
    

}
