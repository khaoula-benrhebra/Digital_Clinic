package com.clinique.service.admin.Departement;

import com.clinique.entities.Departement;

import java.util.List;
import java.util.Optional;

public interface IDepartementService {

    Departement creerDepartement(String nom) throws RuntimeException;
    Departement modifierDepartement(Long id, String nouveauNom) throws RuntimeException;
    void supprimerDepartement(Long id) throws RuntimeException;

    Optional<Departement> trouverParId(Long id) throws RuntimeException;
    Optional<Departement> trouverParNom(String nom) throws RuntimeException;
    List<Departement> listerTousLesDepartements() throws RuntimeException;

    List<Departement> listerDepartementsAvecDocteurs() throws RuntimeException;

}
