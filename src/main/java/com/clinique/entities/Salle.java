package com.clinique.entities;

import jakarta.persistence.*;

@Entity @Table(name = "salles")

public class Salle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id ;

    @Column(name = "nom" , nullable = false)
    private  String nom ;

    @Column(name = "capacite", nullable = false)
    private int capacite;


}
