package com.clinique.entities;


import com.clinique.entities.Departement;
import jakarta.persistence.*;

import jakarta.persistence.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "salles")
public class Salle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nom", nullable = false)
    private String nom;

    @Column(name = "capacite", nullable = false)
    private int capacite;

    @Temporal(TemporalType.TIMESTAMP)
    private List<LocalDateTime> crenauxOccup = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "departement_id")
    private Departement departement;

    @OneToMany(mappedBy = "salle", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Consultation> consultations = new ArrayList<>();

    public Salle() {}

    public Salle(String nom, int capacite) {
        this.nom = nom;
        this.capacite = capacite;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public int getCapacite() { return capacite; }
    public void setCapacite(int capacite) { this.capacite = capacite; }

    public List<LocalDateTime> getCrenauxOccup() { return crenauxOccup; }
    public void setCrenauxOccup(List<LocalDateTime> crenauxOccup) { this.crenauxOccup = crenauxOccup; }

    public Departement getDepartement() { return departement; }
    public void setDepartement(Departement departement) { this.departement = departement; }

    public List<Consultation> getConsultations() { return consultations; }
    public void setConsultations(List<Consultation> consultations) { this.consultations = consultations; }
}