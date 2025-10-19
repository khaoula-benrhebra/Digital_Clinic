package com.clinique.servlet.admin;

import com.clinique.service.admin.Salle.ISalleService;
import com.clinique.service.admin.Salle.SalleServiceImpl;
import com.clinique.repository.ISalleRepository;
import com.clinique.repository.IDepartement;
import com.clinique.repository.impl.SalleRepositoryImpl;
import com.clinique.repository.impl.DepartementRepositoryImpl;
import com.clinique.entities.Salle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/salles")
public class SalleServlet extends HttpServlet {

    private ISalleService salleService;

    @Override
    public void init() throws ServletException {
        ISalleRepository salleRepository = new SalleRepositoryImpl();
        IDepartement departementRepository = new DepartementRepositoryImpl();
        this.salleService = new SalleServiceImpl(salleRepository, departementRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("showSection", "salles");
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-dashboard.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("creer".equals(action)) {
                String nom = request.getParameter("nom");
                int capacite = Integer.parseInt(request.getParameter("capacite"));
                Long departementId = Long.parseLong(request.getParameter("departementId"));

                salleService.creerSalle(nom, capacite, departementId);
                response.sendRedirect(request.getContextPath() + "/admin/salles?success=created");

            } else if ("modifier".equals(action)) {
                Long id = Long.parseLong(request.getParameter("id"));
                String nom = request.getParameter("nom");
                int capacite = Integer.parseInt(request.getParameter("capacite"));
                Long departementId = Long.parseLong(request.getParameter("departementId"));

                salleService.modifierSalle(id, nom, capacite, departementId);
                response.sendRedirect(request.getContextPath() + "/admin/salles?success=updated");

            } else if ("supprimer".equals(action)) {
                Long id = Long.parseLong(request.getParameter("id"));
                salleService.supprimerSalle(id);
                response.sendRedirect(request.getContextPath() + "/admin/salles?success=deleted");

            } else {
                response.sendRedirect(request.getContextPath() + "/admin/salles?error=Action non reconnue");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/salles?error=" +
                    java.net.URLEncoder.encode("Données invalides", "UTF-8"));
        } catch (RuntimeException e) {
            response.sendRedirect(request.getContextPath() + "/admin/salles?error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}