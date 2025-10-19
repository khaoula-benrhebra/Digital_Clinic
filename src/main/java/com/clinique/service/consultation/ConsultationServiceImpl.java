package com.clinique.service.consultation;

import com.clinique.entities.Consultation;
import com.clinique.entities.Docteur;
import com.clinique.entities.Patient;
import com.clinique.entities.Salle;
import com.clinique.entities.enums.StatutConsultation;
import com.clinique.repository.IConsultation;
import com.clinique.repository.IDocteur;
import com.clinique.repository.IPatient;
import com.clinique.repository.ISalleRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ConsultationServiceImpl implements IConsultationService {

    private IConsultation consultationRepository;
    private IDocteur docteurRepository;
    private IPatient patientRepository;
    private ISalleRepository salleRepository;

    public ConsultationServiceImpl(IConsultation consultationRepository,
                                   IDocteur docteurRepository,
                                   IPatient patientRepository,
                                   ISalleRepository salleRepository) {
        this.consultationRepository = consultationRepository;
        this.docteurRepository = docteurRepository;
        this.patientRepository = patientRepository;
        this.salleRepository = salleRepository;
    }

    @Override
    public Consultation creerConsultation(Long patientId, Long docteurId, LocalDateTime dateEtHeure) throws RuntimeException {
        // Validation des données
        if (patientId == null) {
            throw new RuntimeException("L'ID du patient est obligatoire");
        }

        if (docteurId == null) {
            throw new RuntimeException("L'ID du docteur est obligatoire");
        }

        if (dateEtHeure == null) {
            throw new RuntimeException("La date et l'heure sont obligatoires");
        }

        // Vérifier que la date est dans le futur
        if (dateEtHeure.isBefore(LocalDateTime.now())) {
            throw new RuntimeException("La date de consultation doit être dans le futur");
        }

        // Vérifier que le patient existe
        Optional<Patient> patientOpt = patientRepository.findById(patientId);
        if (patientOpt.isEmpty()) {
            throw new RuntimeException("Patient non trouvé avec l'ID: " + patientId);
        }

        // Vérifier que le docteur existe
        Optional<Docteur> docteurOpt = docteurRepository.findById(docteurId);
        if (docteurOpt.isEmpty()) {
            throw new RuntimeException("Docteur non trouvé avec l'ID: " + docteurId);
        }

        Docteur docteur = docteurOpt.get();

        // Vérifier que le docteur est disponible
        List<Consultation> consultationsDocteur = consultationRepository.findByDocteurAndDateTime(docteurId, dateEtHeure);
        if (!consultationsDocteur.isEmpty()) {
            throw new RuntimeException("Le docteur n'est pas disponible à cette date et heure");
        }

        // Trouver une salle disponible dans le département du docteur
        Long departementId = docteur.getDepartement().getId();
        List<Salle> sallesDisponibles = getSallesDisponibles(departementId, dateEtHeure);

        if (sallesDisponibles.isEmpty()) {
            throw new RuntimeException("Aucune salle disponible dans ce département à cette date et heure");
        }

        // Prendre la première salle disponible
        Salle salleChoisie = sallesDisponibles.get(0);

        // Créer la consultation
        Consultation nouvelleConsultation = new Consultation();
        nouvelleConsultation.setPatient(patientOpt.get());
        nouvelleConsultation.setDocteur(docteur);
        nouvelleConsultation.setSalle(salleChoisie);
        nouvelleConsultation.setDateETheur(dateEtHeure);
        nouvelleConsultation.setStatut(StatutConsultation.RESERVEE);
        nouvelleConsultation.setCompteRendu(null); // Null au début

        return consultationRepository.save(nouvelleConsultation);
    }

    @Override
    public Consultation modifierConsultation(Long consultationId, LocalDateTime nouvelleDate) throws RuntimeException {
        if (consultationId == null) {
            throw new RuntimeException("L'ID de la consultation est obligatoire");
        }

        if (nouvelleDate == null) {
            throw new RuntimeException("La nouvelle date est obligatoire");
        }

        // Vérifier que la nouvelle date est dans le futur
        if (nouvelleDate.isBefore(LocalDateTime.now())) {
            throw new RuntimeException("La nouvelle date doit être dans le futur");
        }

        // Récupérer la consultation
        Optional<Consultation> consultationOpt = consultationRepository.findById(consultationId);
        if (consultationOpt.isEmpty()) {
            throw new RuntimeException("Consultation non trouvée avec l'ID: " + consultationId);
        }

        Consultation consultation = consultationOpt.get();

        // Vérifier que la consultation peut être modifiée (statut RESERVEE ou VALIDEE)
        if (consultation.getStatut() != StatutConsultation.RESERVEE &&
                consultation.getStatut() != StatutConsultation.VALIDEE) {
            throw new RuntimeException("Cette consultation ne peut pas être modifiée (statut: " + consultation.getStatut() + ")");
        }

        Long docteurId = consultation.getDocteur().getId();
        Long departementId = consultation.getDocteur().getDepartement().getId();

        // Vérifier la disponibilité du docteur à la nouvelle date
        List<Consultation> consultationsDocteur = consultationRepository.findByDocteurAndDateTime(docteurId, nouvelleDate);
        // Exclure la consultation actuelle de la vérification
        consultationsDocteur.removeIf(c -> c.getId().equals(consultationId));

        if (!consultationsDocteur.isEmpty()) {
            throw new RuntimeException("Le docteur n'est pas disponible à cette nouvelle date et heure");
        }

        // Trouver une salle disponible
        List<Salle> sallesDisponibles = getSallesDisponibles(departementId, nouvelleDate);

        if (sallesDisponibles.isEmpty()) {
            throw new RuntimeException("Aucune salle disponible à cette nouvelle date et heure");
        }

        // Mettre à jour la consultation
        consultation.setDateETheur(nouvelleDate);
        consultation.setSalle(sallesDisponibles.get(0));

        return consultationRepository.update(consultation);
    }

    @Override
    public void annulerConsultation(Long consultationId) throws RuntimeException {
        if (consultationId == null) {
            throw new RuntimeException("L'ID de la consultation est obligatoire");
        }

        Optional<Consultation> consultationOpt = consultationRepository.findById(consultationId);
        if (consultationOpt.isEmpty()) {
            throw new RuntimeException("Consultation non trouvée avec l'ID: " + consultationId);
        }

        Consultation consultation = consultationOpt.get();

        // Vérifier que la consultation peut être annulée
        if (consultation.getStatut() == StatutConsultation.ANNULEE) {
            throw new RuntimeException("Cette consultation est déjà annulée");
        }

        if (consultation.getStatut() == StatutConsultation.TERMINEE) {
            throw new RuntimeException("Une consultation terminée ne peut pas être annulée");
        }

        // Changer le statut à ANNULEE
        consultation.setStatut(StatutConsultation.ANNULEE);
        consultationRepository.update(consultation);
    }

    @Override
    public Consultation validerConsultation(Long consultationId) throws RuntimeException {
        if (consultationId == null) {
            throw new RuntimeException("L'ID de la consultation est obligatoire");
        }

        Optional<Consultation> consultationOpt = consultationRepository.findById(consultationId);
        if (consultationOpt.isEmpty()) {
            throw new RuntimeException("Consultation non trouvée avec l'ID: " + consultationId);
        }

        Consultation consultation = consultationOpt.get();

        // Vérifier que la consultation est en statut RESERVEE
        if (consultation.getStatut() != StatutConsultation.RESERVEE) {
            throw new RuntimeException("Seules les consultations réservées peuvent être validées");
        }

        // Changer le statut à VALIDEE
        consultation.setStatut(StatutConsultation.VALIDEE);

        return consultationRepository.update(consultation);
    }

    @Override
    public Consultation terminerConsultation(Long consultationId, String compteRendu) throws RuntimeException {
        if (consultationId == null) {
            throw new RuntimeException("L'ID de la consultation est obligatoire");
        }

        if (compteRendu == null || compteRendu.trim().isEmpty()) {
            throw new RuntimeException("Le compte rendu est obligatoire pour terminer une consultation");
        }

        Optional<Consultation> consultationOpt = consultationRepository.findById(consultationId);
        if (consultationOpt.isEmpty()) {
            throw new RuntimeException("Consultation non trouvée avec l'ID: " + consultationId);
        }

        Consultation consultation = consultationOpt.get();

        // Vérifier que la consultation peut être terminée
        if (consultation.getStatut() == StatutConsultation.TERMINEE) {
            throw new RuntimeException("Cette consultation est déjà terminée");
        }

        if (consultation.getStatut() == StatutConsultation.ANNULEE) {
            throw new RuntimeException("Une consultation annulée ne peut pas être terminée");
        }

        // Mettre à jour la consultation
        consultation.setStatut(StatutConsultation.TERMINEE);
        consultation.setCompteRendu(compteRendu);

        return consultationRepository.update(consultation);
    }

    @Override
    public Optional<Consultation> trouverParId(Long id) throws RuntimeException {
        return consultationRepository.findById(id);
    }

    @Override
    public List<Docteur> getDocteursDisponibles(Long departementId, LocalDateTime dateEtHeure) throws RuntimeException {
        if (departementId == null) {
            throw new RuntimeException("L'ID du département est obligatoire");
        }

        if (dateEtHeure == null) {
            throw new RuntimeException("La date et l'heure sont obligatoires");
        }

        // Récupérer tous les docteurs du département
        List<Docteur> tousDocteurs = docteurRepository.findAll();
        List<Docteur> docteursDuDepartement = new ArrayList<>();

        for (Docteur docteur : tousDocteurs) {
            if (docteur.getDepartement() != null &&
                    docteur.getDepartement().getId().equals(departementId)) {
                docteursDuDepartement.add(docteur);
            }
        }

        // Filtrer les docteurs disponibles
        List<Docteur> docteursDisponibles = new ArrayList<>();

        for (Docteur docteur : docteursDuDepartement) {
            List<Consultation> consultations = consultationRepository.findByDocteurAndDateTime(
                    docteur.getId(), dateEtHeure
            );

            // Si pas de consultation à cette heure, le docteur est disponible
            if (consultations.isEmpty()) {
                docteursDisponibles.add(docteur);
            }
        }

        return docteursDisponibles;
    }

    @Override
    public List<Salle> getSallesDisponibles(Long departementId, LocalDateTime dateEtHeure) throws RuntimeException {
        if (departementId == null) {
            throw new RuntimeException("L'ID du département est obligatoire");
        }

        if (dateEtHeure == null) {
            throw new RuntimeException("La date et l'heure sont obligatoires");
        }

        // Récupérer toutes les salles du département
        List<Salle> toutesSalles = salleRepository.findByDepartementId(departementId);

        // Filtrer les salles disponibles
        List<Salle> sallesDisponibles = new ArrayList<>();

        for (Salle salle : toutesSalles) {
            List<Consultation> consultations = consultationRepository.findBySalleAndDateTime(
                    salle.getId(), dateEtHeure
            );

            // Si pas de consultation à cette heure, la salle est disponible
            if (consultations.isEmpty()) {
                sallesDisponibles.add(salle);
            }
        }

        return sallesDisponibles;
    }

    @Override
    public List<Consultation> getConsultationsFutures(Long patientId) throws RuntimeException {
        if (patientId == null) {
            throw new RuntimeException("L'ID du patient est obligatoire");
        }

        return consultationRepository.findFutureConsultationsByPatientId(patientId);
    }

    @Override
    public List<Consultation> getHistoriqueConsultations(Long patientId) throws RuntimeException {
        if (patientId == null) {
            throw new RuntimeException("L'ID du patient est obligatoire");
        }

        return consultationRepository.findHistoriqueByPatientId(patientId);
    }

    @Override
    public List<Consultation> getToutesConsultations(Long patientId) throws RuntimeException {
        if (patientId == null) {
            throw new RuntimeException("L'ID du patient est obligatoire");
        }

        return consultationRepository.findByPatientId(patientId);
    }
}