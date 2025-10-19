package com.clinique.repository.impl;

import com.clinique.entities.Consultation;
import com.clinique.entities.enums.StatutConsultation;
import com.clinique.repository.IConsultation;
import com.clinique.util.DatabaseUtil;
import jakarta.persistence.EntityManager;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class ConsultationRepositoryImpl implements IConsultation {

    @Override
    public Consultation save(Consultation consultation) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(consultation);
            em.getTransaction().commit();
            return consultation;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la création de la consultation: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public Consultation update(Consultation consultation) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Consultation updated = em.merge(consultation);
            em.getTransaction().commit();
            return updated;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la modification de la consultation: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Long id) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Consultation consultation = em.find(Consultation.class, id);
            if (consultation != null) {
                em.remove(consultation);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de la consultation: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Consultation> findById(Long id) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            Consultation consultation = em.find(Consultation.class, id);
            return Optional.ofNullable(consultation);
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche de la consultation: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Consultation> findAll() throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT c FROM Consultation c " +
                            "LEFT JOIN FETCH c.patient " +
                            "LEFT JOIN FETCH c.docteur " +
                            "LEFT JOIN FETCH c.salle",
                    Consultation.class
            ).getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des consultations: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Consultation> findByDocteurAndDateTime(Long docteurId, LocalDateTime dateTime) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            // Vérification de chevauchement une consultation dure 30 minutes
            //  cherche les consultations qui  chevauchent avec le créneau demandé
            // Chevauchement = consultation existante dans l'intervalle dateTime-30min, dateTime+30min
            LocalDateTime debutCreneau = dateTime.minusMinutes(30);
            LocalDateTime finCreneau = dateTime.plusMinutes(30);

            return em.createQuery(
                            "SELECT c FROM Consultation c " +
                                    "WHERE c.docteur.id = :docteurId " +
                                    "AND c.dateETheur > :debut " +  //  après (début - 30min)
                                    "AND c.dateETheur < :fin " +    //  avant (début + 30min)
                                    "AND (c.statut = :statutReservee OR c.statut = :statutValidee)",
                            Consultation.class
                    )
                    .setParameter("docteurId", docteurId)
                    .setParameter("debut", debutCreneau)
                    .setParameter("fin", finCreneau)
                    .setParameter("statutReservee", StatutConsultation.RESERVEE)
                    .setParameter("statutValidee", StatutConsultation.VALIDEE)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la vérification de disponibilité du docteur: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Consultation> findBySalleAndDateTime(Long salleId, LocalDateTime dateTime) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            // On vérifie si une consultation existe dans l'intervalle -29 min, +29 min
            // Car une consultation dure 30 min
            LocalDateTime debutCreneau = dateTime.minusMinutes(29);
            LocalDateTime finCreneau = dateTime.plusMinutes(29);

            return em.createQuery(
                            "SELECT c FROM Consultation c " +
                                    "WHERE c.salle.id = :salleId " +
                                    "AND c.dateETheur >= :debut " +
                                    "AND c.dateETheur <= :fin " +
                                    "AND (c.statut = :statutReservee OR c.statut = :statutValidee)",
                            Consultation.class
                    )
                    .setParameter("salleId", salleId)
                    .setParameter("debut", debutCreneau)
                    .setParameter("fin", finCreneau)
                    .setParameter("statutReservee", StatutConsultation.RESERVEE)
                    .setParameter("statutValidee", StatutConsultation.VALIDEE)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la vérification de disponibilité de la salle: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Consultation> findByPatientId(Long patientId) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT c FROM Consultation c " +
                                    "LEFT JOIN FETCH c.docteur " +
                                    "LEFT JOIN FETCH c.salle " +
                                    "WHERE c.patient.id = :patientId " +
                                    "ORDER BY c.dateETheur DESC",
                            Consultation.class
                    )
                    .setParameter("patientId", patientId)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des consultations du patient: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Consultation> findFutureConsultationsByPatientId(Long patientId) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT c FROM Consultation c " +
                                    "LEFT JOIN FETCH c.docteur d " +
                                    "LEFT JOIN FETCH d.departement " +
                                    "LEFT JOIN FETCH c.salle " +
                                    "WHERE c.patient.id = :patientId " +
                                    "AND c.dateETheur > :now " +
                                    "AND (c.statut = :statutReservee OR c.statut = :statutValidee) " +
                                    "ORDER BY c.dateETheur ASC",
                            Consultation.class
                    )
                    .setParameter("patientId", patientId)
                    .setParameter("now", LocalDateTime.now())
                    .setParameter("statutReservee", StatutConsultation.RESERVEE)
                    .setParameter("statutValidee", StatutConsultation.VALIDEE)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des consultations futures: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Consultation> findHistoriqueByPatientId(Long patientId) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT c FROM Consultation c " +
                                    "LEFT JOIN FETCH c.docteur d " +
                                    "LEFT JOIN FETCH d.departement " +
                                    "LEFT JOIN FETCH c.salle " +
                                    "WHERE c.patient.id = :patientId " +
                                    "AND c.statut = :statutTerminee " +
                                    "ORDER BY c.dateETheur DESC",
                            Consultation.class
                    )
                    .setParameter("patientId", patientId)
                    .setParameter("statutTerminee", StatutConsultation.TERMINEE)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération de l'historique: " + e.getMessage());
        } finally {
            em.close();
        }
    }
}