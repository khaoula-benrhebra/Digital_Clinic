package com.clinique.repository;

import com.clinique.entities.Consultation;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface IConsultation {

    Consultation save(Consultation consultation) throws RuntimeException;

    Consultation update(Consultation consultation) throws RuntimeException;

    void delete(Long id) throws RuntimeException;

    Optional<Consultation> findById(Long id) throws RuntimeException;

    List<Consultation> findAll() throws RuntimeException;

    // Trouver les consultations d'un docteur à une date/heure donnée
    List<Consultation> findByDocteurAndDateTime(Long docteurId, LocalDateTime dateTime) throws RuntimeException;

    // Trouver les consultations d'une salle à une date/heure donnée
    List<Consultation> findBySalleAndDateTime(Long salleId, LocalDateTime dateTime) throws RuntimeException;

    // Trouver toutes les consultations d'un patient
    List<Consultation> findByPatientId(Long patientId) throws RuntimeException;

    // Trouver les consultations futures d'un patient
    List<Consultation> findFutureConsultationsByPatientId(Long patientId) throws RuntimeException;

    // Trouver l'historique des consultations d'un patient (terminées)
    List<Consultation> findHistoriqueByPatientId(Long patientId) throws RuntimeException;
}