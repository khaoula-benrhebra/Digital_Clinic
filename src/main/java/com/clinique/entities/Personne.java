package com.clinique.entities;


import com.clinique.entities.enums.Role;
import jakarta.persistence.*;


@Entity @Table(name = "personnes")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Personne {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected   Long id ;

    @Column(name="nom" , nullable = false)
    protected   String nom ;

    @Column(name = "prenom" , nullable = false)
    protected String prenom ;

    @Column (name = "email" ,unique = true, nullable = false)
    protected String email ;

    @Column (name = "password" , nullable = false)
    protected String password ;

    @Enumerated(EnumType.STRING)
    @Column(name = "role" , nullable = false)
    protected Role role ;

    public Personne(){};

    public Personne(String nom, String prenom, String email, String password, Role role) {
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.password = password;
        this.role=role;
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

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmal() {
        return email;
    }

    public void setEmal(String emal) {
        this.email = emal;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
