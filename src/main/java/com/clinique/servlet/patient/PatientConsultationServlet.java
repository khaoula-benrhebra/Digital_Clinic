package com.clinique.servlet.patient;

import com.clinique.entities.*;
import com.clinique.entities.enums.StatutConsultation;
import com.clinique.repository.IConsultation;
import com.clinique.repository.IDepartement;
import com.clinique.repository.IDocteur;
import com.clinique.repository.ISalleRepository;
import com.clinique.repository.impl.*;
import com.clinique.service.consultation.ConsultationServiceImpl;
import com.clinique.service.consultation.IConsultationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/patient/dashboard")
public class PatientConsultationServlet extends HttpServlet {

    private IConsultationService consultationService;
    private IDepartement departementRepository;
    private IDocteur docteurRepository;

    @Override
    public void init() throws ServletException {
        // Initialisation des repositories et services
        IConsultation consultationRepository = new ConsultationRepositoryImpl();
        departementRepository = new DepartementRepositoryImpl();
        docteurRepository = new DocteurRepositoryImpl();
        ISalleRepository salleRepository = new SalleRepositoryImpl();

        consultationService = new ConsultationServiceImpl(
                consultationRepository,
                docteurRepository,
                new PatientRepositoryImpl(),
                salleRepository
        );
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userConnecte") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Personne user = (Personne) session.getAttribute("userConnecte");
        if (!(user instanceof Patient)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Patient patient = (Patient) user;
        String section = request.getParameter("section");

        if (section == null) {
            section = "dashboard";
        }

        try {
            switch (section) {
                case "dashboard":
                    handleDashboard(request, patient);
                    break;
                case "nouvelle-consultation":
                    handleNouvelleConsultation(request);
                    break;
                case "mes-consultations":
                    handleMesConsultations(request, patient);
                    break;
                case "historique":
                    handleHistorique(request, patient);
                    break;
                default:
                    section = "dashboard";
                    handleDashboard(request, patient);
            }

            request.setAttribute("showSection", section);
            request.getRequestDispatcher("/WEB-INF/views/patient/patient-dashboard.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/patient/patient-dashboard.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userConnecte") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Personne user = (Personne) session.getAttribute("userConnecte");
        if (!(user instanceof Patient)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Patient patient = (Patient) user;
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "creer":
                    handleCreerConsultation(request, response, patient);
                    break;
                case "modifier":
                    handleModifierConsultation(request, response);
                    break;
                case "annuler":
                    handleAnnulerConsultation(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/patient/dashboard");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur: " + e.getMessage());
            request.setAttribute("showSection", "mes-consultations");
            request.getRequestDispatcher("/WEB-INF/views/patient/patient-dashboard.jsp")
                    .forward(request, response);
        }
    }

    private void handleDashboard(HttpServletRequest request, Patient patient) {
        try {
            // Récupérer les consultations futures pour les stats
            List<Consultation> consultationsFutures = consultationService.getConsultationsFutures(patient.getId());
            List<Consultation> historique = consultationService.getHistoriqueConsultations(patient.getId());

            // Statistiques
            request.setAttribute("nbConsultationsFutures", consultationsFutures.size());
            request.setAttribute("nbConsultationsTerminees", historique.size());

            // Prochaines consultations (max 3)
            List<Consultation> prochaines = consultationsFutures.stream()
                    .limit(3)
                    .toList();
            request.setAttribute("prochainesConsultations", prochaines);

        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement du dashboard: " + e.getMessage());
        }
    }

    private void handleNouvelleConsultation(HttpServletRequest request) {
        try {
            // Récupérer tous les départements
            List<Departement> departements = departementRepository.findAll();
            request.setAttribute("departements", departements);

            // Si un département est sélectionné, récupérer ses docteurs
            String departementIdStr = request.getParameter("departementId");
            if (departementIdStr != null && !departementIdStr.isEmpty()) {
                try {
                    Long departementId = Long.parseLong(departementIdStr);
                    List<Docteur> docteurs = docteurRepository.findAll().stream()
                            .filter(d -> d.getDepartement() != null &&
                                    d.getDepartement().getId().equals(departementId))
                            .toList();
                    request.setAttribute("docteursDisponibles", docteurs);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID de département invalide");
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement des données: " + e.getMessage());
        }
    }

    private void handleMesConsultations(HttpServletRequest request, Patient patient) {
        try {
            List<Consultation> consultationsFutures = consultationService.getConsultationsFutures(patient.getId());
            request.setAttribute("consultationsFutures", consultationsFutures);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement des consultations: " + e.getMessage());
        }
    }

    private void handleHistorique(HttpServletRequest request, Patient patient) {
        try {
            List<Consultation> historique = consultationService.getHistoriqueConsultations(patient.getId());
            request.setAttribute("historique", historique);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement de l'historique: " + e.getMessage());
        }
    }

    private void handleCreerConsultation(HttpServletRequest request, HttpServletResponse response,
                                         Patient patient) throws IOException, ServletException {
        try {
            // Validation des paramètres
            String docteurIdStr = request.getParameter("docteurId");
            String dateStr = request.getParameter("date");
            String heureStr = request.getParameter("heure");

            if (docteurIdStr == null || docteurIdStr.trim().isEmpty()) {
                throw new RuntimeException("Veuillez sélectionner un docteur");
            }

            if (dateStr == null || dateStr.trim().isEmpty()) {
                throw new RuntimeException("Veuillez sélectionner une date");
            }

            if (heureStr == null || heureStr.trim().isEmpty()) {
                throw new RuntimeException("Veuillez sélectionner une heure");
            }

            Long docteurId = Long.parseLong(docteurIdStr);
            LocalDate date = LocalDate.parse(dateStr);
            LocalTime heure = LocalTime.parse(heureStr);
            LocalDateTime dateEtHeure = LocalDateTime.of(date, heure);

            // Créer la consultation
            consultationService.creerConsultation(patient.getId(), docteurId, dateEtHeure);

            // Rediriger vers mes consultations avec message de succès
            request.getSession().setAttribute("successMessage",
                    "Consultation créée avec succès! Un email de confirmation vous a été envoyé.");
            response.sendRedirect(request.getContextPath() + "/patient/dashboard?section=mes-consultations");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Données invalides");
            request.setAttribute("showSection", "nouvelle-consultation");
            handleNouvelleConsultation(request);
            request.getRequestDispatcher("/WEB-INF/views/patient/patient-dashboard.jsp")
                    .forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("showSection", "nouvelle-consultation");
            handleNouvelleConsultation(request);
            request.getRequestDispatcher("/WEB-INF/views/patient/patient-dashboard.jsp")
                    .forward(request, response);
        }
    }

    private void handleModifierConsultation(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            Long consultationId = Long.parseLong(request.getParameter("consultationId"));
            String dateStr = request.getParameter("date");
            String heureStr = request.getParameter("heure");

            LocalDate date = LocalDate.parse(dateStr);
            LocalTime heure = LocalTime.parse(heureStr);
            LocalDateTime nouvelleDate = LocalDateTime.of(date, heure);

            consultationService.modifierConsultation(consultationId, nouvelleDate);

            request.getSession().setAttribute("successMessage",
                    "Consultation modifiée avec succès!");
            response.sendRedirect(request.getContextPath() + "/patient/dashboard?section=mes-consultations");

        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("showSection", "mes-consultations");
            request.getRequestDispatcher("/WEB-INF/views/patient/patient-dashboard.jsp")
                    .forward(request, response);
        }
    }

    private void handleAnnulerConsultation(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            Long consultationId = Long.parseLong(request.getParameter("consultationId"));

            consultationService.annulerConsultation(consultationId);

            request.getSession().setAttribute("successMessage",
                    "Consultation annulée avec succès!");
            response.sendRedirect(request.getContextPath() + "/patient/dashboard?section=mes-consultations");

        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("showSection", "mes-consultations");
            request.getRequestDispatcher("/WEB-INF/views/patient/patient-dashboard.jsp")
                    .forward(request, response);
        }
    }
}