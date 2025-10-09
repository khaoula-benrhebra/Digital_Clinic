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
    private List<Docteur> docreurs = new ArrayList<>();

    @OneToMany(mappedBy = "departement", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Salle> salles = new ArrayList<>();

    public Departement(String nom) {
        this.nom = nom;

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public List<Docteur> getDocreurs() {
        return docreurs;
    }

    public void setDocreurs(List<Docteur> docreurs) {
        this.docreurs = docreurs;
    }

    public List<Salle> getSalles() {
        return salles;
    }

    public void setSalles(List<Salle> salles) {
        this.salles = salles;
    }
}
