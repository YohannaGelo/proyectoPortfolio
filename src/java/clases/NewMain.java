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
        
        
        HashMap<Proyecto, Integer> proyectos = new HashMap<Proyecto, Integer>();
        
        proyectos = Proyecto.proyectosY_comentarios(proyectos);
        
        for (Map.Entry<Proyecto, Integer> entry : proyectos.entrySet()) {
            Object key = entry.getKey();
            Object val = entry.getValue();
            
            System.out.println("Proyecto: \n" + key);
            System.out.println("Num comentarios: " + val);
            
        }
        
        
       Proyecto proyectoRandom = Proyecto.proyectoAleatorio(proyectos);
        System.out.println("GANADOR: \n" + proyectoRandom.getUrl());
        
    }
    
}
