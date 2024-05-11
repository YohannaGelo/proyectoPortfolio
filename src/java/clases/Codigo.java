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
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;

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

    // MÉTODOS
    // Añade proyectos y número de comentarios al HashMap de proyectos
    public static HashMap<Proyecto, Integer> cargarCodigos(HashMap<Proyecto, Integer> proyectos) throws SQLException {

        HashMap<Proyecto, Integer> proyectosCodigo = proyectos;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");  // Nuevo controlador
            Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
            Statement s = conexion.createStatement();

            // Array para almacenar los proyectos con sus comentarios
            ArrayList<Codigo> codigos = new ArrayList<Codigo>();

            // Ejecutar la consulta para obtener los datos de proyectos y comentarios
            ResultSet listado = s.executeQuery(
                    "SELECT cod.url, cod.nombreCodigo, cod.img, c.id, c.username, c.comentario, c.fecha "
                    + "FROM codigos cod "
                    + "LEFT JOIN comentarios c ON cod.url = c.url"
            );

            while (listado.next()) {
                String url = listado.getString("url");

                // Buscar el proyecto correspondiente en la lista de proyectos
                Codigo codigo = null;
                for (Codigo cod : codigos) {
                    if (cod.getUrl().equals(url)) {
                        codigo = cod;
                        break;
                    }
                }

                // Si no se encontró el proyecto, crea uno nuevo
                if (codigo == null) {
                    String nombreCodigo = listado.getString("nombreCodigo");
                    InputStream imagenStream = listado.getBinaryStream("img");
                    codigo = new Codigo(nombreCodigo, url, imagenStream);
                    codigos.add(codigo);
                }

                // Si hay un feedback, agrégalo al proyecto correspondiente
                if (listado.getObject("id") != null) {
                    int id = listado.getInt("id");
                    String usernameCons = listado.getString("username");
                    String comentario = listado.getString("comentario");
                    LocalDateTime fecha = listado.getTimestamp("fecha").toLocalDateTime();

                    Feedback feedback = new Feedback(id, usernameCons, url, comentario, fecha);
                    codigo.getFeedbackPorCodigo().add(feedback);
                }

                // Agrega el proyecto y el numero de comentarios al HashMap
                proyectosCodigo.put(codigo, codigo.getFeedbackPorCodigo().size());

            }

            // Cerrar la conexión y liberar recursos
            listado.close();
            s.close();
            conexion.close();

        } catch (ClassNotFoundException e) {
            // Manejar la excepción si no se encuentra la clase del controlador
            e.printStackTrace();
        } catch (SQLException e) {
            // Manejar la excepción si hay un error de SQL
            e.printStackTrace();
        }

        return proyectosCodigo;

    }

}
