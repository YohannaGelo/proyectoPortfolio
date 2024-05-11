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
public class ProyectoWeb extends Proyecto {

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

    // MÉTODOS
    // Añade proyectos y número de comentarios al HashMap de proyectos
    public static HashMap<Proyecto, Integer> cargarProyectosWeb(HashMap<Proyecto, Integer> proyectos) throws SQLException {

        HashMap<Proyecto, Integer> proyectosWeb = proyectos;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");  // Nuevo controlador
            Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
            Statement s = conexion.createStatement();

            // Array para almacenar los proyectos con sus comentarios
            ArrayList<ProyectoWeb> proyectosArray = new ArrayList<ProyectoWeb>();

            // Ejecutar la consulta para obtener los datos de proyectos y comentarios
            // Ejecutar la consulta para obtener los datos de proyectos y comentarios
            ResultSet listado = s.executeQuery(
                    "SELECT p.url, p.nombreProyecto, p.img, c.id, c.username, c.comentario, c.fecha "
                    + "FROM proyectosWeb p "
                    + "LEFT JOIN comentarios c ON p.url = c.url"
            );

            while (listado.next()) {
                String url = listado.getString("url");

                // Buscar el proyecto correspondiente en la lista de proyectos
                ProyectoWeb proyecto = null;
                for (ProyectoWeb proy : proyectosArray) {
                    if (proy.getUrl().equals(url)) {
                        proyecto = proy;
                        break;
                    }
                }

                // Si no se encontró el proyecto, crea uno nuevo
                if (proyecto == null) {
                    String nombreProyecto = listado.getString("nombreProyecto");
                    InputStream imagenStream = listado.getBinaryStream("img");
                    proyecto = new ProyectoWeb(nombreProyecto, url, imagenStream);
                    proyectosArray.add(proyecto);

                }

                // Si hay un feedback, se agrega al proyecto correspondiente
                if (listado.getObject("id") != null) {
                    int id = listado.getInt("id");
                    String usernameCons = listado.getString("username");
                    String comentario = listado.getString("comentario");
                    LocalDateTime fecha = listado.getTimestamp("fecha").toLocalDateTime();

                    Feedback feedback = new Feedback(id, usernameCons, url, comentario, fecha);
                    proyecto.getFeedbackPorProyecto().add(feedback);
                }

                // Agrega el proyecto y el numero de comentarios al HashMap
                proyectosWeb.put(proyecto, proyecto.getFeedbackPorProyecto().size());

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

        return proyectosWeb;

    }

}
