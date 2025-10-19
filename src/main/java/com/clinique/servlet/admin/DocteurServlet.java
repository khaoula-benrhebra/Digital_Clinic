package com.clinique.servlet.admin;

import com.clinique.service.admin.Docteur.IDocteurService;
import com.clinique.service.admin.Docteur.DocteurServiceImpl;
import com.clinique.repository.IDocteur;
import com.clinique.repository.IDepartement;
import com.clinique.repository.impl.DocteurRepositoryImpl;
import com.clinique.repository.impl.DepartementRepositoryImpl;
import com.clinique.entities.Docteur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/docteurs")
public class DocteurServlet extends HttpServlet {

    private IDocteurService docteurService;

    @Override
    public void init() throws ServletException {
        IDocteur docteurRepository = new DocteurRepositoryImpl();
        IDepartement departementRepository = new DepartementRepositoryImpl();
        this.docteurService = new DocteurServiceImpl(docteurRepository, departementRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("showSection", "docteurs");
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
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String specialite = request.getParameter("specialite");
                Long departementId = Long.parseLong(request.getParameter("departementId"));

                docteurService.creerDocteur(nom, prenom, email, password, specialite, departementId);
                response.sendRedirect(request.getContextPath() + "/admin/docteurs?success=created");

            } else if ("modifier".equals(action)) {
                Long id = Long.parseLong(request.getParameter("id"));
                String nom = request.getParameter("nom");
                String prenom = request.getParameter("prenom");
                String email = request.getParameter("email");
                String specialite = request.getParameter("specialite");
                Long departementId = Long.parseLong(request.getParameter("departementId"));

                docteurService.modifierDocteur(id, nom, prenom, email, specialite, departementId);
                response.sendRedirect(request.getContextPath() + "/admin/docteurs?success=updated");

            } else if ("supprimer".equals(action)) {
                Long id = Long.parseLong(request.getParameter("id"));
                docteurService.supprimerDocteur(id);
                response.sendRedirect(request.getContextPath() + "/admin/docteurs?success=deleted");

            } else {
                response.sendRedirect(request.getContextPath() + "/admin/docteurs?error=Action non reconnue");
            }
        } catch (RuntimeException e) {
            response.sendRedirect(request.getContextPath() + "/admin/docteurs?error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}