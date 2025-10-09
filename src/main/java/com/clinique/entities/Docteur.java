package com.clinique.entities;

import com.clinique.entities.enums.Role;
import com.clinique.entities.enums.StatutConsultation;
import jakarta.persistence.*;
import org.hibernate.sql.results.graph.Fetch;

import java.util.ArrayList;
import java.util.List;

@Entity @Table (name = "decteurs")
@PrimaryKeyJoinColumn(name = "personne_id")

public class Docteur extends Personne {
    @Column(name = "specialité", nullable = false)
    private String specialite ;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "depatement_id")
    private  Depatement depatement ;

    @OneToMany(mappedBy = "decteur", cascade = CascadeType.ALL, fetch =FetchType.LAZY)
   private List<Consultation> planning =new ArrayList<>();

    public Docteur() {}

    public Docteur(String nom, String prenom, String emal, String password, Role role, String specialite) {
        super(nom, prenom, emal, password, role);
        this.specialite = specialite;
    }

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }
}
