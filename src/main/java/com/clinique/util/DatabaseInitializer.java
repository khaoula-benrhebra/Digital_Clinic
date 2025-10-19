package com.clinique.util;

import com.clinique.entities.Admin;
import com.clinique.entities.enums.Role;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        System.out.println("initialisation de la base de donnée ");
        creerAdminParDefuat();

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        DatabaseUtil.close();
    }

    private void creerAdminParDefuat(){
        EntityManager em =DatabaseUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            Long adminCount = em.createQuery("SELECT COUNT(a) FROM Admin a WHERE a.email = :email", Long.class)
                    .setParameter("email", "admin@clinique.com")
                    .getSingleResult();

            if (adminCount ==0){
                Admin admin = new Admin("Khaoula", "Benrhebra" , "admin@clinique.com", "admin123", Role.ADMIN);
                em.persist(admin);
                System.out.println("admin a étét crée");
            }else {
                System.out.println("admin existe deja");
            }

            em.getTransaction().commit();
        }catch (Exception e){
            if (em.getTransaction().isActive()){
                em.getTransaction().rollback();
            }
            System.err.println("error lors de la creartion de admin " + e.getMessage());
        }finally {
            em.close();
        }
    }
}
