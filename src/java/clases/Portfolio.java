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
import java.util.ArrayList;

/**
 *
 * @author Yohanna Gelo
 */
public class Portfolio {

    // Atributos
    private ArrayList<DisGrafico> listaDisGraficos;
    private ArrayList<ProyectoWeb> listaProyectos;
    private ArrayList<Codigo> listaCodigos;
    private ArrayList<Documento> listaDocumento;
    private int numProyectos = 0;

    // Constructor
    public Portfolio() {
        this.listaDisGraficos = new ArrayList<DisGrafico>();
        this.listaProyectos = new ArrayList<ProyectoWeb>();
        this.listaCodigos = new ArrayList<Codigo>();
        this.listaDocumento = new ArrayList<Documento>();

    }

    // GETTERs y/o SETTERs
    public ArrayList<DisGrafico> getListaDisGraficos() {
        return listaDisGraficos;
    }

    public void setListaDisGraficos(ArrayList<DisGrafico> listaDisGraficos) {
        this.listaDisGraficos = listaDisGraficos;
    }

    public ArrayList<ProyectoWeb> getListaProyectos() {
        return listaProyectos;
    }

    public void setListaProyectos(ArrayList<ProyectoWeb> listaProyectos) {
        this.listaProyectos = listaProyectos;
    }

    public ArrayList<Codigo> getListaCodigos() {
        return listaCodigos;
    }

    public void setListaCodigos(ArrayList<Codigo> listaCodigos) {
        this.listaCodigos = listaCodigos;
    }

    public ArrayList<Documento> getListaDocumento() {
        return listaDocumento;
    }

    public void setListaDocumento(ArrayList<Documento> listaDocumento) {
        this.listaDocumento = listaDocumento;
    }

    public int getNumProyectos() {
        return numProyectos;
    }

    public void setNumProyectos(int numProyectos) {
        this.numProyectos = numProyectos;
    }

    // MÉTODOS
    // Crear array con todos los proyectos
    public void crearProyectos() throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
        Statement s = conexion.createStatement();
        
        // Consulta SQL para obtener el proyecto basado en la URL
        ResultSet listado = s.executeQuery("SELECT * FROM proyectosWeb");
        //String sql = "SELECT * FROM proyectosWeb WHERE url = ?";

        while (listado.next()) {

            // Crea un nuevo objeto ProyectoWeb con los datos de la consulta
            String url = listado.getString("url");
            String nombreProyecto = listado.getString("nombreProyecto");
            InputStream img = listado.getBinaryStream("img");

            // Crea un objeto ProyectoWeb
            ProyectoWeb nuevoProyecto = new ProyectoWeb(nombreProyecto, url, img);

            // Agrega el objeto ProyectoWeb a la lista solo si no está añadido ya
            if (!this.listaProyectos.contains(nuevoProyecto)) {
                this.listaProyectos.add(nuevoProyecto);
            }

        }

    }
    
    
    // Crear array con todos los diseños graficos
    public void crearDisGrafico() throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
        Statement s = conexion.createStatement();
        
        // Consulta SQL para obtener el proyecto basado en la URL
        ResultSet listado = s.executeQuery("SELECT * FROM disGraficos");
        //String sql = "SELECT * FROM proyectosWeb WHERE url = ?";

        while (listado.next()) {

            // Crea un nuevo objeto ProyectoWeb con los datos de la consulta
            String url = listado.getString("url");
            String nombreDisGrafico = listado.getString("nombreDisGrafico");
            InputStream img = listado.getBinaryStream("img");

            // Crea un objeto ProyectoWeb
            DisGrafico nuevoDisGrafico = new DisGrafico(nombreDisGrafico, url, img);

            // Agrega el objeto ProyectoWeb a la lista solo si no está añadido ya
            if (!this.listaDisGraficos.contains(nuevoDisGrafico)) {
                this.listaDisGraficos.add(nuevoDisGrafico);
            }

        }

    }
    
    // Crear array con todos los codigos
    public void crearCodigos() throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
        Statement s = conexion.createStatement();
        
        // Consulta SQL para obtener el proyecto basado en la URL
        ResultSet listado = s.executeQuery("SELECT * FROM codigos");
        //String sql = "SELECT * FROM proyectosWeb WHERE url = ?";

        while (listado.next()) {

            // Crea un nuevo objeto ProyectoWeb con los datos de la consulta
            String url = listado.getString("url");
            String nombreCodigo = listado.getString("nombreCodigo");
            InputStream img = listado.getBinaryStream("img");

            // Crea un objeto ProyectoWeb
            Codigo nuevoCodigo = new Codigo(nombreCodigo, url, img);

            // Agrega el objeto ProyectoWeb a la lista solo si no está añadido ya
            if (!this.listaCodigos.contains(nuevoCodigo)) {
                this.listaCodigos.add(nuevoCodigo);
            }

        }

    }
    
    // Crear array con todos los documentos
    public void crearDocumentos() throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/portfolio", "root", "");
        Statement s = conexion.createStatement();
        
        // Consulta SQL para obtener el proyecto basado en la URL
        ResultSet listado = s.executeQuery("SELECT * FROM documentos");
        //String sql = "SELECT * FROM proyectosWeb WHERE url = ?";

        while (listado.next()) {

            // Crea un nuevo objeto ProyectoWeb con los datos de la consulta
            String url = listado.getString("url");
            String nombreDocumento = listado.getString("nombreDocumento");
            InputStream img = listado.getBinaryStream("img");

            // Crea un objeto ProyectoWeb
            Documento nuevoDocuemnto = new Documento(nombreDocumento, url, img);

            // Agrega el objeto ProyectoWeb a la lista solo si no está añadido ya
            if (!this.listaDocumento.contains(nuevoDocuemnto)) {
                this.listaDocumento.add(nuevoDocuemnto);
            }

        }

    }

}
