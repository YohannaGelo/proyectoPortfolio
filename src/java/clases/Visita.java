/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 *
 * @author Yohanna Gelo
 */
public class Visita {

    // Atributos
    private String username;
    private int visitCount;
    private LocalDateTime lastVisitDate;
    private ArrayList<LocalDateTime> visitHistory;

    // Constructor
    public Visita(String username) {
        this.username = username;
        this.visitCount = 0;
        this.lastVisitDate = null;
        this.visitHistory = new ArrayList<>();
    }

    // ToString
    @Override
    public String toString() {
        return " · Usuario: " + username + "\t · Nº de visitas: " + visitCount + "\n · Última visita: " + lastVisitDate + "\n · Historial de visitas: " + visitHistory;
    }

    // GETTERs y/o SETTERs
    public String getUsername() {
        return username;
    }

    public int getVisitCount() {
        return visitCount;
    }

    public LocalDateTime getLastVisitDate() {
        return lastVisitDate;
    }

    public ArrayList<LocalDateTime> getVisitHistory() {
        return visitHistory;
    }

    // MÉTODOS
    //// Registrar nueva visita
    public void registrarVisita() {
        visitCount++;
        lastVisitDate = LocalDateTime.now();
        visitHistory.add(lastVisitDate);
    }

    //// Métodos para guardar y cargar los datos en un fichero de texto
    public void guardarDatos() throws IOException {

        BufferedWriter bw = null;

        try {
            bw = new BufferedWriter(new FileWriter("C:/Users/yohan/Documents/NetBeansProjects/PORTFOLIO/ficheros/" + this.username + "_RegistroVisitas.txt"));

            bw.newLine();
            bw.write("      USUARIO:\t" + this.username + "\n");
            bw.write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
            bw.write(" · Nº de visitas:\t" + this.visitCount + "\n");

            // Escribe la fecha de la última visita siempre que no sea null
            if (this.lastVisitDate != null) {
                bw.write(" · Última visita:\t" + this.lastVisitDate.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) + "\n");
            }

            // Escribe el historial de visitas
            bw.write(" · Historial:\n");
            for (LocalDateTime fecha : this.visitHistory) {
                bw.write("   - " + fecha.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) + "\n");
            }

            bw.write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

        } catch (IOException ioe) {
            System.out.println("Se ha producido un error al escribir el fichero");
            System.err.println(ioe.getMessage());

        } finally {
            // Cierra el bufferedWriter aunque haya excepciones, solo si no es null
            if (bw != null) {
                try {
                    bw.close();
                } catch (IOException e) {
                    System.err.println("Error al cerrar BufferedWriter: " + e.getMessage());
                }
            }

        }
    }

    public void cargarDatos() {

        BufferedReader br = null;

        try {

            br = new BufferedReader(new FileReader("C:/Users/yohan/Documents/NetBeansProjects/PORTFOLIO/ficheros/" + this.username + "_RegistroVisitas.txt"));

            String linea = "";
            ArrayList<LocalDateTime> history = new ArrayList<>();

            // Lee cada línea del fichero si no es null
            while ((linea = br.readLine()) != null) {
                // Toma información según el comienzo de la línea
                if (linea.startsWith(" · Nº de visitas:\t")) {
                    // Consigue el número de visitas
                    this.visitCount = Integer.parseInt(linea.substring(18).trim());
                    //System.out.println("numVisit: " + visitCount);
                } else if (linea.startsWith(" · Última visita:\t")) {
                    // Extraer la última fecha de visita
                    String fechaStr = linea.substring(18).trim();
                    this.lastVisitDate = LocalDateTime.parse(fechaStr, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                    //System.out.println("lastVisit: " + lastVisitDate);
                } else if (linea.startsWith("   - ")) {
                    // Elimina el carácter `-` y analiza la fecha
                    String fechaStr = linea.substring(4).trim();
                    // Guarda las fechas del historial de visitas
                    LocalDateTime fecha = LocalDateTime.parse(fechaStr, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                    history.add(fecha);
                }
            }

            // Actualiza el historial de visita
            this.visitHistory = history;
            //System.out.println("historial: " + visitHistory);
        } catch (IOException ioe) {
            System.err.println("Se ha producido un error al leer el fichero: " + ioe.getMessage());

        } finally {
            // Cierra el bufferedWriter aunque haya excepciones, solo si no es null
            if (br != null) {
                try {
                    br.close();
                } catch (IOException ioe) {
                    System.err.println("Se produjo un error al cerrar el BufferedWriter: " + ioe.getMessage());
                }
            }
        }
    }
}
