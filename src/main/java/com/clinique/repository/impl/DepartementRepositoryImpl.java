package com.clinique.repository.impl;

import com.clinique.entities.Departement;
import com.clinique.entities.Docteur;
import com.clinique.repository.IDepartement;
import com.clinique.util.DatabaseUtil;
import jakarta.persistence.EntityManager;
import org.hibernate.engine.spi.EntityUniqueKey;

import java.util.List;
import java.util.Optional;

public class DepartementRepositoryImpl implements IDepartement {
    @Override
    public Departement save(Departement departement) throws RuntimeException {
        EntityManager em =DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(departement);
            em.getTransaction().commit();
            return departement ;

        }catch (Exception e){
            if (em.getTransaction().isActive()){
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error lors de la crationn de departement" + e.getMessage());
        }finally {
            em.close();
        }
    }

    @Override
    public Departement update(Departement departement) throws RuntimeException {
        EntityManager em=DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Departement updated =em.merge(departement);
            em.getTransaction().commit();
            return updated;
        }catch (Exception e){
            if (em.getTransaction().isActive()){
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Error lors  de la modification de departement"+e.getMessage());
        }finally {
            em.close();
        }
    }

    @Override
    public void delete(Long id) throws RuntimeException {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            // Charger le département avec ses docteurs
            Departement departement = em.createQuery(
                            "SELECT d FROM Departement d LEFT JOIN FETCH d.docteurs WHERE d.id = :id",
                            Departement.class
                    )
                    .setParameter("id", id)
                    .getSingleResult();

            if (departement != null) {
                // Vérifier s'il y a des docteurs
                if (departement.getDocteurs() != null && !departement.getDocteurs().isEmpty()) {
                    throw new RuntimeException("Impossible de supprimer ce département car il contient " +
                            departement.getDocteurs().size() + " docteur(s)");
                }
                em.remove(departement);
            }

            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression du département: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Departement> findById(Long id) throws RuntimeException {
        EntityManager em=DatabaseUtil.getEntityManager();
        try {
            Departement departement =em.find(Departement.class, id);
            return Optional.ofNullable(departement);
        }catch (Exception e){
            throw new RuntimeException("Error lors de la recherche du departement " +e.getMessage());
        }finally {
            em.close();
        }
    }

    @Override
    public Optional<Departement> findByNom(String nom) {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            List<Departement> result = em.createQuery("SELECT d FROM Departement d WHERE d.nom = :nom", Departement.class)
                    .setParameter("nom", nom)
                    .getResultList();
            return result.isEmpty() ? Optional.empty() : Optional.of(result.get(0));
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche par nom: " + e.getMessage());
        } finally {
            em.close();
        }
    }

    @Override
    public List<Departement> findAll() throws RuntimeException {
        EntityManager em=DatabaseUtil.getEntityManager();
        try {
           return  em.createQuery("SELECT d from Departement d", Departement.class).getResultList();
        }catch (Exception e){
            throw new RuntimeException("Error lors de la récuperation des départements:: " + e.getMessage());
        }
        finally {
            em.close();
        }
    }


    @Override
    public List<Departement> findAllWithDocteurs() {
        EntityManager em = DatabaseUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT DISTINCT d FROM Departement d LEFT JOIN FETCH d.docteurs",
                    Departement.class
            ).getResultList();
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la récupération des départements avec docteurs: " + e.getMessage());
        } finally {
            em.close();
        }
    }


}
