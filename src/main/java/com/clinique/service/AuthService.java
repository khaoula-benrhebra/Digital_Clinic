package com.clinique.service;

import com.clinique.entities.Personne;
import com.clinique.entities.Patient;
import com.clinique.entities.enums.Role;
import com.clinique.repository.PersonneRepository;

public class AuthService {

    private PersonneRepository personneRepository;

    public AuthService() {
        this.personneRepository = new PersonneRepository();
    }

    public Personne authentifier(String email, String password) {
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            return null;
        }

        try {
            Personne personne = personneRepository.findByEmailAndPassword(email, password);
            return personne;
        } catch (Exception e) {
            System.err.println("Erreur d'authentification : " + e.getMessage());
            return null;
        }
    }

    // Enregistrer un nouveau patient
    public boolean inscrirePatient(String nom, String prenom, String email, String password, double taille, double poids) {
        // Validation des données
        if (nom == null || nom.trim().isEmpty() ||
                prenom == null || prenom.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                taille <= 0 || poids <= 0) {
            return false;
        }

        try {
            // Vérifier si l'email existe déjà
            if (personneRepository.emailExists(email)) {
                System.err.println("Email déjà utilisé : " + email);
                return false;
            }

            // Créer un nouveau patient
            Patient patient = new Patient(nom, prenom, email, password, Role.PATIENT, poids, taille);

            // Enregistrer dans la base de données
            personneRepository.savePatient(patient);

            return true;
        } catch (Exception e) {
            System.err.println("Erreur lors de l'inscription : " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}