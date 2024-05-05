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

/**
 *
 * @author Yohanna Gelo
 */
public class metodosAuxiliares {
    
    // Variables para conectar con la bbdd
    private static final String DB_URL = "jdbc:mysql://localhost:3306/portfolio";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";
    
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
    
        // DESENCRIPTAR
    public static String nombrePorUrl(String url) throws SQLException  {

         String nombreProyecto = null;

        // Consulta SQL para obtener el nombre del proyecto basado en la URL
        String sql = "SELECT nombreProyecto FROM proyectosWeb WHERE url = ?";

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
    
    // Para obtener la imagen a través de la url
    public static InputStream imgPorUrl (String url) throws SQLException {
        InputStream imagenStream = null;

        // Consulta SQL para obtener la imagen del proyecto basado en la URL
        String sql = "SELECT img FROM proyectosWeb WHERE url = ?";

        try (Connection conexion = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
             PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setString(1, url);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                imagenStream = rs.getBinaryStream("img");
            }
        }

        return imagenStream;
    }
    
}
