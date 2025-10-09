package com.clinique.entities;

import com.clinique.entities.enums.Role;
import jakarta.persistence.Entity;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;

@Entity @Table(name = "admins")
@PrimaryKeyJoinColumn(name = "personne_id")
public class Admin extends Personne {

    public Admin(){}

    public Admin(String nom, String prenom, String emal, String password, Role role) {
        super(nom, prenom, emal, password, role);
    }
}
