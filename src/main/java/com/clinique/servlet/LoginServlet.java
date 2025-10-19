package com.clinique.servlet;

import com.clinique.entities.Personne;
import com.clinique.entities.enums.Role;
import com.clinique.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() {
        this.authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("=== LOGIN ATTEMPT ===");
        System.out.println("Email: " + email);

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("erreur", "Email et mot de passe requis");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        try {
            Personne user = authService.authentifier(email, password);

            if (user != null) {
                System.out.println("User authenticated: " + user.getEmail() + " - Role: " + user.getRole());

                HttpSession session = request.getSession();
                session.setAttribute("userConnecte", user);
                session.setAttribute("role", user.getRole());

                String redirectUrl;
                switch (user.getRole()) {
                    case ADMIN:
                        redirectUrl = request.getContextPath() + "/admin/dashboard";
                        break;
                    case DOCTEUR:
                        redirectUrl = request.getContextPath() + "/docteur/dashboard";
                        break;
                    case PATIENT:
                        redirectUrl = request.getContextPath() + "/patient/dashboard";
                        break;
                    default:
                        redirectUrl = request.getContextPath() + "/";
                }

                System.out.println("Redirecting to: " + redirectUrl);
                response.sendRedirect(redirectUrl);
            } else {
                System.out.println("Authentication failed");
                request.setAttribute("erreur", "Email ou mot de passe incorrect");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error during login: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("erreur", "Erreur lors de la connexion: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}