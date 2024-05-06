/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Objects;

/**
 *
 * @author Yohanna Gelo
 */
public class Feedback implements Comparable<Feedback> {

    // Atributos
    private int id;
    private String username;
    private String url;
    private String comentario;
    private LocalDateTime feedbackDate;

    // Constructor
    public Feedback(String username, String url, String comentario) {
        this.username = username;
        this.url = url;
        this.comentario = comentario;
        // Establece la fecha y hora de la creación como fecha del feedback
        this.feedbackDate = LocalDateTime.now();
    }
    
        public Feedback(String username, String url, String comentario, LocalDateTime feedbackDate) {
        this.username = username;
        this.url = url;
        this.comentario = comentario;
        // Establece la fecha y hora de la creación como fecha del feedback
        this.feedbackDate = feedbackDate;
    }

    // GETTERs y/o SETTERs
    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getComentario() {
        return comentario;
    }

    public LocalDateTime getFeedbackDate() {
        return feedbackDate;
    }

    public String getUrl() {
        return url;
    }

    public void setFeedbackDate(LocalDateTime feedbackDate) {
        this.feedbackDate = feedbackDate;
    }
    

    // MÉTODOS
    @Override
    // Para comparar fechas
    public int hashCode() {
        int hash = 7;
        hash = 29 * hash + Objects.hashCode(this.feedbackDate);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Feedback other = (Feedback) obj;
        if (!Objects.equals(this.feedbackDate, other.feedbackDate)) {
            return false;
        }
        return true;
    }

    // Para ordenar`por fechas
    @Override
    public int compareTo(Feedback otherFeedback) {
        // Usa el método compareTo de LocalDateTime para comparar las fechas
        return this.feedbackDate.compareTo(otherFeedback.feedbackDate);
    }

}
