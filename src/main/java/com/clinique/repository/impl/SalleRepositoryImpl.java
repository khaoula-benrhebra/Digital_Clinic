package com.clinique.repository.impl;

import com.clinique.entities.Salle;
import com.clinique.repository.ISalleRepository;
import com.clinique.util.DatabaseUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

import java.util.List;
import java.util.Optional;

public class SalleRepositoryImpl implements ISalleRepository {

    @Override
    public Salle save(Salle salle) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(salle);
            em.getTransaction().commit();
            return salle;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la création de la salle: " + e.getMessage());
        } finally {
            em.close();
        }
    }


    @Override
    public Salle update(Salle salle) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Salle updated = em.merge(salle);
            em.getTransaction().commit();
            return updated;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la modification de la salle: " + e.getMessage());
        } finally {
            em.close();


        }
    }



    @Override
    public void delete(Long id) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Salle salle = em.find(Salle.class, id);
            if (salle != null) {
                em.remove(salle);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression de la salle: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Salle> findById(Long id) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            Salle salle = em.find(Salle.class, id);
            return Optional.ofNullable(salle);
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche de la salle: " + e.getMessage());
        } finally {
            em.close();
        }
    }


    @Override
    public List<Salle> findAll() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM Salle s", Salle.class)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des salles: " + e.getMessage());
        } finally {
            em.close();
        }
    }


    @Override
    public Optional<Salle> findByNom(String nom) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            Salle salle = em.createQuery("SELECT s FROM Salle s WHERE s.nom = :nom", Salle.class)
                    .setParameter("nom", nom)
                    .getSingleResult();
            return Optional.of(salle);
        } catch (NoResultException e) {
            return Optional.empty();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche par nom: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Salle> findByDepartementId(Long departementId) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM Salle s WHERE s.departement.id = :departementId", Salle.class)
                    .setParameter("departementId", departementId)
                    .getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche des salles par département: " + e.getMessage());
        } finally {
            em.close();
        }
    }



}
