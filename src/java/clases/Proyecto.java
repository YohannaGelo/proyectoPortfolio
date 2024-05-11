/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author Yohanna Gelo
 */
public abstract class Proyecto {
    
    // Atributos
    protected String nombre;
    protected String url;
    protected InputStream img;
    //protected ArrayList<Feedback> feedbacks;
    
    // Constructor
    public Proyecto(String nombre, String url, InputStream img) {
        this.nombre = nombre;
        this.url = url;
        this.img = img;
    }
    
    // ToString
    @Override
    public String toString() {
        return "Proyecto{" + "nombre=" + nombre + ", url=" + url + ", img=" + img + '}';
    }
    
    
    
    // Getters y/o Setters
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public InputStream getImg() {
        return img;
    }

    public void setImg(InputStream img) {
        this.img = img;
    }

    
    // MÉTODOS
    // Crea un HashMap de proyectos y número de comentarios
    public static HashMap<Proyecto, Integer> proyectosY_comentarios (HashMap<Proyecto, Integer> proyectos) throws SQLException {

        HashMap<Proyecto, Integer> proyectosComentarios = proyectos;
        
        // Agrega los Proyectos de diferentes tipos junto a sus comentarios
        proyectosComentarios = ProyectoWeb.cargarProyectosWeb(proyectos);
        proyectosComentarios = Codigo.cargarCodigos(proyectos);
        
        return proyectosComentarios;
        
    }
    
    
    // Selecciona un proyecto de forma aleatoria
    public static Proyecto proyectoAleatorio (HashMap<Proyecto, Integer> proyectosComentarios) {
        
        // Obtener la lista de proyectos del HashMap
        ArrayList<Proyecto> proyectos = new ArrayList<Proyecto>(proyectosComentarios.keySet());
        
        // Generar un índice aleatorio dentro del rango de la lista de proyectos
        int indiceAleatorio = (int) (Math.random() * proyectos.size());

        // Obtener el proyecto correspondiente al índice aleatorio
        Proyecto proyectoSeleccionado = proyectos.get(indiceAleatorio);

        return proyectoSeleccionado;

    }
    
    
    
}
