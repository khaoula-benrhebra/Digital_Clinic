package com.clinique.entities;

import com.clinique.entities.enums.Role;
import com.clinique.entities.enums.StatutConsultation;
import jakarta.persistence.*;
import org.hibernate.sql.results.graph.Fetch;

import java.util.ArrayList;
import java.util.List;

@Entity @Table (name = "docteurs")
@PrimaryKeyJoinColumn(name = "personne_id")

public class Docteur extends Personne {
    @Column(name = "specialite", nullable = false)
    private String specialite ;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "departement_id")
    private  Departement departement ;

    @OneToMany(mappedBy = "docteur", cascade = CascadeType.ALL, fetch =FetchType.LAZY)
   private List<Consultation> planning =new ArrayList<>();

    public Docteur() {}

    public Docteur(String nom, String prenom, String email, String password, Role role, String specialite) {
        super(nom, prenom, email, password, role);
        this.specialite = specialite;
    }

    public String getSpecialite() {
        return specialite;
    }
    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }


    public void setDepartement(Departement departement) {
        this.departement = departement;
    }
    public Departement getDepartement() {
        return departement;}

    public List<Consultation> getPlanning() {
        return planning;}
    public void setPlanning(List<Consultation> planning) {
        this.planning = planning;
    }
}
