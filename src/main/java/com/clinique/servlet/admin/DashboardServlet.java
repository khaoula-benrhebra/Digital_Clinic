package com.clinique.servlet.admin;

import com.clinique.service.admin.Departement.IDepartementService;
import com.clinique.service.admin.Departement.DepartementServiceImpl;
import com.clinique.repository.IDepartement;
import com.clinique.repository.impl.DepartementRepositoryImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {

    private IDepartementService departementService;

    @Override
    public void init() throws ServletException {
        try {
            IDepartement departementRepository = new DepartementRepositoryImpl();
            this.departementService = new DepartementServiceImpl(departementRepository);
            System.out.println("DashboardServlet initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing DashboardServlet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Failed to initialize DashboardServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== DASHBOARD ACCESS ===");

        if (request.getSession().getAttribute("userConnecte") == null) {
            System.out.println("No user in session, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        System.out.println("User in session, showing dashboard");

        try {
            request.setAttribute("showSection", "dashboard");
            request.getRequestDispatcher("/WEB-INF/views/admin/admin-dashboard.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            System.err.println("Error forwarding to dashboard: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().println("Error loading dashboard: " + e.getMessage());
        }
    }
}