package com.clinique.service.admin.Docteur;

import com.clinique.entities.Docteur;
import java.util.List;
import java.util.Optional;

public interface IDocteurService {

    Docteur creerDocteur(String nom, String prenom, String email, String password,
                         String specialite, Long departementId) throws RuntimeException;

    Docteur modifierDocteur(Long id, String nom, String prenom, String email,
                            String specialite, Long departementId) throws RuntimeException;

    void supprimerDocteur(Long id) throws RuntimeException;

    Optional<Docteur> trouverParId(Long id) throws RuntimeException;

    Optional<Docteur> trouverParEmail(String email) throws RuntimeException;

    List<Docteur> listerTousLesDocteurs() throws RuntimeException;

    List<Docteur> listerDocteursParDepartement(Long departementId) throws RuntimeException;

    void attacherDocteurAuDepartement(Long docteurId, Long departementId) throws RuntimeException;
}