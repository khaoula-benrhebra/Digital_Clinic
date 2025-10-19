package com.clinique.entities;

import com.clinique.entities.enums.StatutConsultation;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table(name = "consultations")
public class Consultation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "dateETheur", nullable = false)
    private LocalDateTime dateETheur;

    @Enumerated(EnumType.STRING)
    @Column(name = "statut", nullable = false)
    private StatutConsultation statut;

    @Column(name = "compte_rendu", columnDefinition = "TEXT")
    private String compteRendu;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @ManyToOne
    @JoinColumn(name = "docteur_id")
    private Docteur docteur;

    @ManyToOne
    @JoinColumn(name = "salle_id")
    private Salle salle;

    public Consultation() {}

    public Consultation(Long id, LocalDateTime dateETheur, StatutConsultation statut, String compteRendu, Patient patient, Docteur docteur, Salle salle) {
        this.id = id;
        this.dateETheur = dateETheur;
        this.statut = statut;
        this.compteRendu = compteRendu;
        this.patient = patient;
        this.docteur = docteur;
        this.salle = salle;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDateTime getDateETheur() { return dateETheur; }
    public void setDateETheur(LocalDateTime dateETheur) { this.dateETheur = dateETheur; }

    public StatutConsultation getStatut() { return statut; }
    public void setStatut(StatutConsultation statut) { this.statut = statut; }

    public String getCompteRendu() { return compteRendu; }
    public void setCompteRendu(String compteRendu) { this.compteRendu = compteRendu; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public Docteur getDocteur() { return docteur; }
    public void setDocteur(Docteur docteur) { this.docteur = docteur; }

    public Salle getSalle() { return salle; }
    public void setSalle(Salle salle) { this.salle = salle; }
}