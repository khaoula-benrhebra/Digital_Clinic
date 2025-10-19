package com.clinique.servlet;

import com.clinique.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() throws ServletException {
        authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Afficher la page d'inscription
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupérer les paramètres du formulaire
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String tailleStr = request.getParameter("taille");
        String poidsStr = request.getParameter("poids");

        try {
            // Vérifier que les mots de passe correspondent
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Les mots de passe ne correspondent pas");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                return;
            }

            // Convertir taille et poids
            double taille = Double.parseDouble(tailleStr);
            double poids = Double.parseDouble(poidsStr);

            // Tenter l'inscription
            boolean success = authService.inscrirePatient(nom, prenom, email, password, taille, poids);

            if (success) {
                // Inscription réussie - rediriger vers la page de connexion
                request.setAttribute("success", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
                response.sendRedirect(request.getContextPath() + "/login?success=registered");
            } else {
                // Échec de l'inscription
                request.setAttribute("error", "Cette adresse email est déjà utilisée ou les données sont invalides");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "La taille et le poids doivent être des nombres valides");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur s'est produite lors de l'inscription");
            e.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}