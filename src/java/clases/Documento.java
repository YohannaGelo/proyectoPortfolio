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
public class Documento {
    
    // Atributos
    private String nombreDoumento;
    private String url;
    private InputStream img;
    private ArrayList<Feedback> feedbackPorDocumento;
    
    // Construtor
    public Documento(String nombreDoumento, String url, InputStream img) {
        this.nombreDoumento = nombreDoumento;
        this.url = url;
        this.img = img;
        feedbackPorDocumento = new ArrayList<Feedback>();
    }
    
    
    // GETTERs y/o SETTERs
    public String getNombreDoumento() {
        return nombreDoumento;
    }

    public String getUrl() {
        return url;
    }

    public InputStream getImg() {
        return img;
    }

    public ArrayList<Feedback> getFeedbackPorDocumento() {
        return feedbackPorDocumento;
    }
    
    
    // MÉTODOS
    // Variables para conectar con la bbdd
    private static final String DB_URL = "jdbc:mysql://localhost:3306/portfolio";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";
    
    // Obtener nombre a través de la url
    public static String crearProyecto (String url) throws SQLException  {

         String nombreProyecto = null;

        // Consulta SQL para obtener el nombre del proyecto basado en la URL
        String sql = "SELECT * FROM proyectosWeb WHERE url = ?";

        try (Connection conexion = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
             PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setString(1, url);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                nombreProyecto = rs.getString("nombreProyecto");
            }
        }

        return nombreProyecto;

    }
     
    
}
