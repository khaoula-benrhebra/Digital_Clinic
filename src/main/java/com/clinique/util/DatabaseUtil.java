package com.clinique.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DatabaseUtil implements ServletContextListener {
    private static EntityManagerFactory emf;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Initialisation de la base de données");
        getEntityManager().close();
        System.out.println("Tables créées ");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        close();
    }

    public static EntityManager getEntityManager() {
        if (emf == null) {
            emf = Persistence.createEntityManagerFactory("myJPAUnit");
        }
        return emf.createEntityManager();
    }

    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}