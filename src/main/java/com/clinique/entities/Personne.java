package com.clinique.entities;


import com.clinique.entities.enums.Role;
import jakarta.persistence.*;


@Entity @Table(name = "personnes")
public class Personne {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected   long id ;

    @Column(name="nom" , nullable = false)
    protected   String nom ;

    @Column(name = "prenom" , nullable = false)
    protected String prenom ;

    @Column (name = "email" , nullable = false)
    protected String emal ;

    @Column (name = "password" , nullable = false)
    protected String password ;

    @Enumerated(EnumType.STRING)
    @Column(name = "role" , nullable = false)
    protected Role role ;

    public Personne(){};

    public Personne(String nom, String prenom, String emal, String password, Role role) {
        this.nom = nom;
        this.prenom = prenom;
        this.emal = emal;
        this.password = password;
        this.role=role;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmal() {
        return emal;
    }

    public void setEmal(String emal) {
        this.emal = emal;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
