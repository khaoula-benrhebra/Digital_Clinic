package com.clinique.servlet.admin;

import com.clinique.service.admin.Departement.IDepartementService;
import com.clinique.service.admin.Departement.DepartementServiceImpl;
import com.clinique.repository.IDepartement;
import com.clinique.repository.impl.DepartementRepositoryImpl;
import com.clinique.entities.Departement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/departements")
public class departementServlet extends HttpServlet {

    private IDepartementService departementService;

    @Override
    public void init() throws ServletException {
        IDepartement departementRepository = new DepartementRepositoryImpl();
        this.departementService = new DepartementServiceImpl(departementRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("showSection", "departements");
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
                departementService.creerDepartement(nom);
                response.sendRedirect(request.getContextPath() + "/admin/departements?success=created");

            } else if ("modifier".equals(action)) {
                Long id = Long.parseLong(request.getParameter("id"));
                String nouveauNom = request.getParameter("nom");
                departementService.modifierDepartement(id, nouveauNom);
                response.sendRedirect(request.getContextPath() + "/admin/departements?success=updated");

            } else if ("supprimer".equals(action)) {
                Long id = Long.parseLong(request.getParameter("id"));
                departementService.supprimerDepartement(id);
                response.sendRedirect(request.getContextPath() + "/admin/departements?success=deleted");

            } else {
                response.sendRedirect(request.getContextPath() + "/admin/departements?error=Action non reconnue");
            }
        } catch (RuntimeException e) {
            response.sendRedirect(request.getContextPath() + "/admin/departements?error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }
}