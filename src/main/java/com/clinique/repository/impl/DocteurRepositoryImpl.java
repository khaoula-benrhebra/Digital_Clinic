package com.clinique.repository.impl;

import com.clinique.entities.Consultation;
import com.clinique.entities.Departement;
import com.clinique.entities.Docteur;
import com.clinique.repository.IDocteur;
import com.clinique.util.DatabaseUtil;
import jakarta.persistence.EntityManager;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class DocteurRepositoryImpl implements IDocteur {
    @Override
    public Docteur save(Docteur docteur) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(docteur);
            em.getTransaction().commit();
            return docteur;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la création du docteur: " + e.getMessage());
        } finally {
            em.close();
        }
    }


    @Override
    public Docteur update(Docteur docteur) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Docteur updated = em.merge(docteur);
            em.getTransaction().commit();
            return updated;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la modification du docteur: " + e.getMessage());
        } finally {
            em.close();
        }
    }
    @Override
    public void delete(Long id) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Docteur docteur = em.find(Docteur.class, id);
            if (docteur != null) {
                //verification si a des consultations au futures
                List<Consultation> consultationsFutures = em.createQuery(
                                "SELECT c FROM Consultation c WHERE c.docteur.id = :docteurId AND c.dateETheur > :now",
                                Consultation.class)
                        .setParameter("docteurId", id)
                        .setParameter("now", LocalDateTime.now())
                        .getResultList();

                if (!consultationsFutures.isEmpty()) {
                    throw new RuntimeException("Impossible de supprimer le docteur: il a des consultations futures");
                }

                em.remove(docteur);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression du docteur: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Docteur> findById(Long id) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            Docteur docteur = em.find(Docteur.class, id);
            return Optional.ofNullable(docteur);
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche du docteur: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Docteur> findAll() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT d FROM Docteur d LEFT JOIN FETCH d.departement",
                    Docteur.class
            ).getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des docteurs: " + e.getMessage());
        } finally {
            em.close();
        }
    }


    @Override
    public Optional<Docteur> findByEmail(String email) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            Docteur docteur = em.createQuery("SELECT d FROM Docteur d WHERE d.email = :email", Docteur.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return Optional.of(docteur);
        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    @Override
    public void attacherDocteur(Long departementId, Docteur docteur) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            Departement departement = em.find(Departement.class, departementId);
            if (departement == null) {
                throw new RuntimeException("Département non trouvé avec l'ID: " + departementId);
            }

            // CORRECTION : "setDepartement" au lieu de "setDepatement"
            docteur.setDepartement(departement);
            em.merge(docteur);

            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de l'attachement du docteur: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    }
