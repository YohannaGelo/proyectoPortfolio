/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author Yohanna Gelo
 */
public class Favorito {

    // Atributos
    private static int numVotosTotales = 0;

    private String urlProyecto;
    private String nombreVotante;
    private int numVotos = 0;
    private boolean like;

    // Constructor
    public Favorito(String urlProyecto, String nombreVotante) {
        this.urlProyecto = urlProyecto;
        this.nombreVotante = nombreVotante;

    }

    // ToString
    @Override
    public String toString() {
        return urlProyecto + "," + nombreVotante + "," + numVotos + "\n";
    }

    // Getters y/o Setters
    public static int getNumVotosTotales() {
        return numVotosTotales;
    }

    public static void setNumVotosTotales(int numVotosTotales) {
        Favorito.numVotosTotales = numVotosTotales;
    }

    public String getUrlProyecto() {
        return urlProyecto;
    }

    public void setUrlProeycto(String urlProyecto) {
        this.urlProyecto = urlProyecto;
    }

    public String getNombreVotante() {
        return nombreVotante;
    }

    public void setNombreVotante(String nombreVotante) {
        this.nombreVotante = nombreVotante;
    }

    public int getNumVotos() {
        return numVotos;
    }

    public void setNumVotos(int numVotos) {
        this.numVotos = numVotos;
    }

    public boolean isLike() {
        return like;
    }

    public void setLike(boolean like) {
        this.like = like;
    }

    // Métodos
    public boolean agregarFavorito() {
        
        boolean votoRegistrado = false;
        
        // Si este usuario no le ha dado like, se registra
        if (!this.comprobarLike()) {

            BufferedWriter bw = null;

            try {
                bw = new BufferedWriter(new FileWriter("C:/Users/yohan/Documents/NetBeansProjects/PORTFOLIO/ficheros/ProyectosFavoritos.txt", true));

                // Se actualizan los contadores
                this.setNumVotos(1);
                bw.write(this.toString());

                votoRegistrado = true;
                System.out.println("Voto añadido correctamente");

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
        } else {
            votoRegistrado = false;
            System.out.println("Este usuario ya ha votado a este proyecto");
        }
        
        return votoRegistrado;
    }

    // Comprobar si un usuario ya ha dado like a ese proyecto
    public boolean comprobarLike() {

        BufferedReader br = null;
        boolean yaVotado = false;

        try {

            br = new BufferedReader(new FileReader("C:/Users/yohan/Documents/NetBeansProjects/PORTFOLIO/ficheros/ProyectosFavoritos.txt"));

            String linea = "";

            // Lee cada línea del fichero si no es null
            while ((linea = br.readLine()) != null) {
                String[] informacion = linea.split(",");
                if (informacion.length >= 2 && informacion[0].equals(this.urlProyecto) && informacion[1].equals(this.nombreVotante)) {
                    yaVotado = true;
                    break;
                }
            }

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

        return yaVotado;
    }

    // Método para eliminar un voto
    public void eliminarVoto() {
        BufferedReader br = null;
        BufferedWriter bw = null;

        try {
            br = new BufferedReader(new FileReader("C:/Users/yohan/Documents/NetBeansProjects/PORTFOLIO/ficheros/ProyectosFavoritos.txt"));
            bw = new BufferedWriter(new FileWriter("C:/Users/yohan/Documents/NetBeansProjects/PORTFOLIO/ficheros/TempProyectosFavoritos.txt"));

            String linea;
            // Lee cada línea del fichero si no es null
            while ((linea = br.readLine()) != null) {
                String[] partes = linea.split(",");
                if (!partes[0].equals(this.urlProyecto) || !partes[1].equals(this.nombreVotante)) {
                    bw.write(linea);
                    bw.newLine();
                }
            }

            System.out.println("Voto eliminado correctamente");
        } catch (IOException e) {
            System.err.println("Error al eliminar el voto: " + e.getMessage());
        } finally {
            try {
                if (br != null) {
                    br.close();
                }
                if (bw != null) {
                    bw.close();
                }
                // Renombrar el archivo temporal al archivo original
                // Esto es para asegurarse de que los cambios se guarden correctamente
                File archivoOriginal = new File("C:/Users/yohan/Documents/NetBeansProjects/PORTFOLIO/ficheros/ProyectosFavoritos.txt");
                File archivoTemporal = new File("C:/Users/yohan/Documents/NetBeansProjects/PORTFOLIO/ficheros/TempProyectosFavoritos.txt");
                archivoOriginal.delete();
                archivoTemporal.renameTo(archivoOriginal);

            } catch (IOException e) {
                System.err.println("Error al cerrar el archivo: " + e.getMessage());
            }
        }
    }

    // Comprobar si un usuario ya ha dado like a ese proyecto
    public static int contarLikes() {

        BufferedReader br = null;
        ArrayList<String> favoritos = new ArrayList<String>();

        try {

            br = new BufferedReader(new FileReader("C:/Users/yohan/Documents/NetBeansProjects/PORTFOLIO/ficheros/ProyectosFavoritos.txt"));

            String linea = "";

            // Lee cada línea del fichero si no es null
            while ((linea = br.readLine()) != null) {
                if (!linea.equals("")) {
                    favoritos.add(linea);
                    System.out.println(linea);
                }
            }

            setNumVotosTotales(favoritos.size());

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

        return getNumVotosTotales();
    }

}
