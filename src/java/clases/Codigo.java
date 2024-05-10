/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Yohanna Gelo
 */
public class Codigo extends Proyecto {

    
    
    // Atributos
//    private String nombreCodigo;
//    private String url;
//    private InputStream img;
    private ArrayList<Feedback> feedbackPorCodigo;
//    
//    
    // Construtor
    public Codigo(String nombre, String url, InputStream img) {
            super(nombre, url, img);
            feedbackPorCodigo = new ArrayList<Feedback>();
        }

//    public Codigo(String nombreCodigo, String url, InputStream img) {
//        this.nombreCodigo = nombreCodigo;
//        this.url = url;
//        this.img = img;
//        feedbackPorCodigo = new ArrayList<Feedback>();
//    }
//
    
    // ToString
    @Override
    public String toString() {
        return super.toString() + "Codigo{" + "feedbackPorCodigo=" + feedbackPorCodigo + '}';
    }
    
    
    // GETTERs y/o SETTERs
    public ArrayList<Feedback> getFeedbackPorCodigo() {
        return feedbackPorCodigo;
    }

    public void setFeedbackPorCodigo(ArrayList<Feedback> feedbackPorCodigo) {
        this.feedbackPorCodigo = feedbackPorCodigo;
    }

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
    
    
    
//    // MÉTODOS
//    // Variables para conectar con la bbdd
//    private static final String DB_URL = "jdbc:mysql://localhost:3306/portfolio";
//    private static final String DB_USERNAME = "root";
//    private static final String DB_PASSWORD = "";
//    
//    // Obtener nombre a través de la url
//    public static String crearProyecto (String url) throws SQLException  {
//
//         String nombreProyecto = null;
//
//        // Consulta SQL para obtener el nombre del proyecto basado en la URL
//        String sql = "SELECT * FROM proyectosWeb WHERE url = ?";
//
//        try (Connection conexion = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
//             PreparedStatement statement = conexion.prepareStatement(sql)) {
//            statement.setString(1, url);
//            ResultSet rs = statement.executeQuery();
//
//            if (rs.next()) {
//                nombreProyecto = rs.getString("nombreProyecto");
//            }
//        }
//
//        return nombreProyecto;
//
//    }


    
    
}
