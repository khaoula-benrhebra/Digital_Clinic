package com.clinique.entities;


import com.clinique.entities.enums.Role;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity @Table(name = "patients")
@PrimaryKeyJoinColumn(name = "personne_id")
public class Patient extends Personne{

    @Column(name = "poids")
    private  double poids ;

    @Column(name = "taille")
    private  double taille ;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Consultation> consultations = new ArrayList<>();

    public  Patient(){};
    public Patient(String nom, String prenom, String emal, String password, Role role, double poids, double taille) {
        super(nom, prenom, emal, password, role);
        this.poids = poids;
        this.taille = taille;
    }



    public double getPoids() {
        return poids;}
    public void setPoids(double poids) {
        this.poids = poids;
    }

    public double getTaille() {
        return taille;
    }
    public void setTaille(double taille) {
        this.taille = taille;
    }

    public List<Consultation> getConsultations() {
        return consultations;}
    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}
