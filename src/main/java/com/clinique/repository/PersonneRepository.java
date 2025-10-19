package com.clinique.repository;

import com.clinique.entities.Personne;
import com.clinique.entities.Patient;
import com.clinique.util.DatabaseUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public class PersonneRepository {

    public Personne findByEmailAndPassword(String email, String password) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Personne p WHERE p.email = :email AND p.password = :password", Personne.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    // Vérifier si un email existe déjà
    public boolean emailExists(String email) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(p) FROM Personne p WHERE p.email = :email", Long.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    // Enregistrer un patient
    public void savePatient(Patient patient) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
}