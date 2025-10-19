package com.clinique.repository.impl;

import com.clinique.entities.Patient;
import com.clinique.repository.IPatient;
import com.clinique.util.DatabaseUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

import java.util.List;
import java.util.Optional;

public class PatientRepositoryImpl implements IPatient {

    @Override
    public Patient save(Patient patient) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
            return patient;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la création du patient: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public Patient update(Patient patient) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Patient updated = em.merge(patient);
            em.getTransaction().commit();
            return updated;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la modification du patient: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Long id) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression du patient: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Patient> findById(Long id) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            Patient patient = em.find(Patient.class, id);
            return Optional.ofNullable(patient);
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche du patient: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Patient> findByEmail(String email) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            Patient patient = em.createQuery("SELECT p FROM Patient p WHERE p.email = :email", Patient.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return Optional.of(patient);
        } catch (NoResultException e) {
            return Optional.empty();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche par email: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Patient> findAll() throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Patient p", Patient.class)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des patients: " + e.getMessage());
        } finally {
            em.close();
        }
    }
}