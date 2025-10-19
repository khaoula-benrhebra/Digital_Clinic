package com.clinique.service.admin.Salle;

import com.clinique.entities.Salle;
import java.util.List;
import java.util.Optional;

public interface ISalleService {

    Salle creerSalle(String nom, int capacite, Long departementId) throws RuntimeException;

    Salle modifierSalle(Long id, String nom, int capacite, Long departementId) throws RuntimeException;

    void supprimerSalle(Long id) throws RuntimeException;

    Optional<Salle> trouverParId(Long id) throws RuntimeException;

    Optional<Salle> trouverParNom(String nom) throws RuntimeException;

    List<Salle> listerToutesLesSalles() throws RuntimeException;

    List<Salle> listerSallesParDepartement(Long departementId) throws RuntimeException;
}