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
public class ProyectoWeb extends Proyecto{

    // Atributos
    private ArrayList<Feedback> feedbackPorProyecto;

    // Construtor
    public ProyectoWeb(String nombre, String url, InputStream img) {    
        super(nombre, url, img);
        feedbackPorProyecto = new ArrayList<Feedback>();
    }

    // ToString
    @Override
    public String toString() {
        return super.toString() + "ProyectoWeb{" + "feedbackPorProyecto=" + feedbackPorProyecto + '}';
    }


    // GETTERs y/o SETTERs
    public ArrayList<Feedback> getFeedbackPorProyecto() {
        return feedbackPorProyecto;
    }

    public void setFeedbackPorProyecto(ArrayList<Feedback> feedbackPorProyecto) {
        this.feedbackPorProyecto = feedbackPorProyecto;
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
