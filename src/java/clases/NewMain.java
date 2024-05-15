/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Yohanna Gelo
 */
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws SQLException {

        Favorito f1 = new Favorito("https://yohannagelo.github.io/EjRegistroEstudiantes/", "pepe");
        Favorito f2 = new Favorito("https://yohannagelo.github.io/EjRegistroEstudiantes/", "pepe"); //no
        Favorito f3 = new Favorito("https://replit.com/@yohannagelo/ChessCodeRoyale", "alba");
        Favorito f4 = new Favorito("https://yohannagelo.github.io/EjRegistroEstudiantes/", "alba");
        Favorito f5 = new Favorito("https://yohannagelo.github.io/EjGestorTareas/", "alba");
        Favorito f6 = new Favorito("https://yohannagelo.github.io/EjGestorTareas/", "alba"); //no
        Favorito f7 = new Favorito("https://yohannagelo.github.io/EjGestorTareas/", "juan");

        System.out.println("AGREGANDO VOTOS:\n");
        f1.agregarFavorito();
        f2.agregarFavorito();
        f3.agregarFavorito();
        f4.agregarFavorito();
        f5.agregarFavorito();
        f6.agregarFavorito();
        f7.agregarFavorito();

        System.out.println("\nTODOS LOS VOTOS: \n");
        int votos = Favorito.contarLikes();
        System.out.println("\nTODOS LOS VOTOS: " + votos + "\n\n");
        
        // Eliminar un voto
        System.out.println("ELIMINANDO UN VOTO:\n");
        f1.eliminarVoto();
        
        // Contar votos después de eliminar uno
        System.out.println("\nTODOS LOS VOTOS DESPUÉS DE ELIMINAR UN VOTO: \n\n");
        int votosDespues = Favorito.contarLikes();
        System.out.println("\nTODOS LOS VOTOS: " + votosDespues + "\n\n");

//        HashMap<Proyecto, Integer> proyectos = new HashMap<Proyecto, Integer>();
//        
//        proyectos = Proyecto.proyectosY_comentarios(proyectos);
//        
//        for (Map.Entry<Proyecto, Integer> entry : proyectos.entrySet()) {
//            Object key = entry.getKey();
//            Object val = entry.getValue();
//            
//            System.out.println("Proyecto: \n" + key);
//            System.out.println("Num comentarios: " + val);
//            
//        }
//        
//        
//       Proyecto proyectoRandom = Proyecto.proyectoAleatorio(proyectos);
//        System.out.println("GANADOR: \n" + proyectoRandom.getUrl());
    }

}
