package com.clinique.entities;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity @Table(name = "departements")

public class Departement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nom", nullable = false, unique = true)
    private String nom;

    @OneToMany(mappedBy = "departement", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Docteur> docteurs = new ArrayList<>();

    @OneToMany(mappedBy = "departement", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Salle> salles = new ArrayList<>();

    public Departement(String nom) {
        this.nom = nom;

    }

    public Departement() {

    }

    public Departement(Long id, String nom, List<Docteur> docreurs, List<Salle> salles) {
        this.id = id;
        this.nom = nom;
        this.docteurs = docreurs;
        this.salles = salles;
    }

    public Long getId() {return id;}
    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }

    public List<Docteur> getDocteurs() {
        return docteurs;
    }
    public void setDocteurs(List<Docteur> docreurs) {
        this.docteurs = docreurs;
    }

    public List<Salle> getSalles() {
        return salles;
    }
    public void setSalles(List<Salle> salles) {
        this.salles = salles;
    }
}
