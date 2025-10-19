package com.clinique.service.consultation;

import com.clinique.entities.Consultation;
import com.clinique.entities.Docteur;
import com.clinique.entities.Salle;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface IConsultationService {

    Consultation creerConsultation(Long patientId, Long docteurId, LocalDateTime dateEtHeure) throws RuntimeException;

    Consultation modifierConsultation(Long consultationId, LocalDateTime nouvelleDate) throws RuntimeException;

    void annulerConsultation(Long consultationId) throws RuntimeException;

    Consultation validerConsultation(Long consultationId) throws RuntimeException;

    Consultation terminerConsultation(Long consultationId, String compteRendu) throws RuntimeException;

    Optional<Consultation> trouverParId(Long id) throws RuntimeException;

    List<Docteur> getDocteursDisponibles(Long departementId, LocalDateTime dateEtHeure) throws RuntimeException;

    List<Salle> getSallesDisponibles(Long departementId, LocalDateTime dateEtHeure) throws RuntimeException;

    List<Consultation> getConsultationsFutures(Long patientId) throws RuntimeException;

    List<Consultation> getHistoriqueConsultations(Long patientId) throws RuntimeException;

    List<Consultation> getToutesConsultations(Long patientId) throws RuntimeException;
}