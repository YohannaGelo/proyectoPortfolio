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
import java.time.LocalDateTime;
import java.util.ArrayList;

/**
 *
 * @author Yohanna Gelo
 */
public class ProyectoWeb extends Portfolio {

    // Atributos
    private String nombreProyecto;
    private String url;
    private InputStream img;
    private ArrayList<Feedback> feedbackPorProyecto;

    // Construtor
    public ProyectoWeb(String nombreProyecto, String url, InputStream img) {
        this.nombreProyecto = nombreProyecto;
        this.url = url;
        this.img = img;
        feedbackPorProyecto = new ArrayList<Feedback>();
    }
    
    // ToString

    @Override
    public String toString() {
        return "ProyectoWeb{" + "nombreProyecto=" + nombreProyecto + ", url=" + url + ", comentarios=" + feedbackPorProyecto.toString() +
            '}';
    }
    
    

    // GETTERs y/o SETTERs
    public String getNombreProyecto() {
        return nombreProyecto;
    }

    public String getUrl() {
        return url;
    }

    public InputStream getImg() {
        return img;
    }

    public ArrayList<Feedback> getFeedbackPorProyecto() {
        return feedbackPorProyecto;
    }

//    
//    // Obtener nombre a través de la url
//    public static String crearProyecto (String url) throws SQLException  {
//
//         String nombreProyecto = null;
//
//        // Consulta SQL para obtener el nombre del proyecto basado en la URL
//        String sql = "SELECT * FROM proyectosWeb";
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
