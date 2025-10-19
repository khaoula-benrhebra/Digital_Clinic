<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.clinique.entities.*" %>
<%@ page import="com.clinique.entities.enums.StatutConsultation" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Espace Patient - DigitalCare</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Inter', sans-serif; }
        .modal { display: none; }
        .modal.active { display: flex; }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-blue-100">

<%
    String showSection = (String) request.getAttribute("showSection");
    if (showSection == null) showSection = "dashboard";

    Personne patient = (Personne) session.getAttribute("userConnecte");
    String patientNom = patient.getNom() != null ? patient.getNom() : "Patient";
    String patientPrenom = patient.getPrenom() != null ? patient.getPrenom() : "";
    String patientEmail = patient.getEmail() != null ? patient.getEmail() : "";

    String initiales = "";
    if (patientPrenom != null && !patientPrenom.isEmpty()) initiales += patientPrenom.charAt(0);
    if (patientNom != null && !patientNom.isEmpty()) initiales += patientNom.charAt(0);
    if (initiales.isEmpty()) initiales = "PT";

    // Messages
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("error");
    if (successMessage != null) session.removeAttribute("successMessage");

    // Formatters
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
    DateTimeFormatter heureFormatter = DateTimeFormatter.ofPattern("HH:mm");
%>

<div class="flex h-screen overflow-hidden">
    <!-- Sidebar -->
    <aside class="w-64 bg-gradient-to-b from-blue-900 to-blue-800 text-white flex-shrink-0 shadow-2xl">
        <div class="p-6">
            <div class="flex items-center space-x-3 mb-8">
                <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
                    <svg class="w-6 h-6 text-blue-900" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                    </svg>
                </div>
                <div>
                    <h1 class="text-xl font-bold text-white">DigitalCare</h1>
                    <p class="text-xs text-blue-200">Espace Patient</p>
                </div>
            </div>

            <nav class="space-y-2">
                <a href="${pageContext.request.contextPath}/patient/dashboard?section=dashboard"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg <%= "dashboard".equals(showSection) ? "bg-blue-800" : "hover:bg-blue-800" %> transition-all duration-300">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                    </svg>
                    <span>Accueil</span>
                </a>
                <a href="${pageContext.request.contextPath}/patient/dashboard?section=nouvelle-consultation"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg <%= "nouvelle-consultation".equals(showSection) ? "bg-blue-800" : "hover:bg-blue-800" %> transition-all duration-300">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                    </svg>
                    <span>Nouvelle Consultation</span>
                </a>
                <a href="${pageContext.request.contextPath}/patient/dashboard?section=mes-consultations"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg <%= "mes-consultations".equals(showSection) ? "bg-blue-800" : "hover:bg-blue-800" %> transition-all duration-300">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                    <span>Mes Consultations</span>
                </a>
                <a href="${pageContext.request.contextPath}/patient/dashboard?section=historique"
                   class="flex items-center space-x-3 px-4 py-3 rounded-lg <%= "historique".equals(showSection) ? "bg-blue-800" : "hover:bg-blue-800" %> transition-all duration-300">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    <span>Historique</span>
                </a>
            </nav>
        </div>

        <div class="absolute bottom-0 w-64 p-6 border-t border-blue-700">
            <div class="flex items-center space-x-3">
                <div class="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center">
                    <span class="text-sm font-bold"><%= initiales.toUpperCase() %></span>
                </div>
                <div>
                    <p class="font-semibold text-sm"><%= patientPrenom %> <%= patientNom %></p>
                    <p class="text-xs text-blue-200"><%= patientEmail %></p>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="mt-4 block text-center px-4 py-2 bg-red-600 hover:bg-red-700 rounded-lg text-sm font-semibold transition-colors">
                Déconnexion
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 overflow-y-auto">
        <!-- Header -->
        <header class="bg-white shadow-md sticky top-0 z-40">
            <div class="px-8 py-6 flex justify-between items-center">
                <div>
                    <h2 class="text-3xl font-bold text-blue-900">Bonjour, <%= patientPrenom %> !</h2>
                    <p class="text-gray-600 mt-1">Gérez vos consultations facilement</p>
                </div>
            </div>
        </header>

        <div class="p-8">
            <!-- Messages -->
            <% if (successMessage != null) { %>
            <div class="mb-6 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-lg">
                <p class="font-semibold"><%= successMessage %></p>
            </div>
            <% } %>

            <% if (errorMessage != null) { %>
            <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg">
                <p class="font-semibold"><%= errorMessage %></p>
            </div>
            <% } %>

            <!-- Dashboard Section -->
            <section id="dashboard-section" class="<%= "dashboard".equals(showSection) ? "" : "hidden" %>">
                <%
                    Integer nbFutures = (Integer) request.getAttribute("nbConsultationsFutures");
                    Integer nbTerminees = (Integer) request.getAttribute("nbConsultationsTerminees");
                    List<Consultation> prochaines = (List<Consultation>) request.getAttribute("prochainesConsultations");

                    if (nbFutures == null) nbFutures = 0;
                    if (nbTerminees == null) nbTerminees = 0;
                %>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                    <!-- Stat Card 1 -->
                    <div class="bg-white rounded-2xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-600 text-sm font-medium">Consultations à venir</p>
                                <p class="text-3xl font-bold text-blue-900 mt-2"><%= nbFutures %></p>
                                <% if (prochaines != null && !prochaines.isEmpty()) { %>
                                <p class="text-green-600 text-sm mt-2">Prochaine: <%= prochaines.get(0).getDateETheur().format(dateFormatter) %></p>
                                <% } %>
                            </div>
                            <div class="w-14 h-14 bg-gradient-to-br from-blue-900 to-blue-700 rounded-xl flex items-center justify-center">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <!-- Stat Card 2 -->
                    <div class="bg-white rounded-2xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-600 text-sm font-medium">Consultations terminées</p>
                                <p class="text-3xl font-bold text-blue-900 mt-2"><%= nbTerminees %></p>
                                <p class="text-blue-600 text-sm mt-2">Total</p>
                            </div>
                            <div class="w-14 h-14 bg-gradient-to-br from-green-600 to-green-500 rounded-xl flex items-center justify-center">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <!-- Stat Card 3 -->
                    <div class="bg-white rounded-2xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-600 text-sm font-medium">Statut</p>
                                <p class="text-3xl font-bold text-blue-900 mt-2">Actif</p>
                                <p class="text-purple-600 text-sm mt-2">Compte vérifié</p>
                            </div>
                            <div class="w-14 h-14 bg-gradient-to-br from-purple-600 to-purple-500 rounded-xl flex items-center justify-center">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="bg-white rounded-2xl p-8 shadow-lg mb-8">
                    <h3 class="text-2xl font-bold text-blue-900 mb-6">Actions Rapides</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <a href="${pageContext.request.contextPath}/patient/dashboard?section=nouvelle-consultation" class="flex items-center space-x-4 p-6 bg-gradient-to-br from-blue-50 to-blue-100 rounded-xl hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                            <div class="w-12 h-12 bg-blue-900 rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                </svg>
                            </div>
                            <div class="text-left">
                                <p class="font-bold text-blue-900">Nouvelle Consultation</p>
                                <p class="text-sm text-gray-600">Prendre rendez-vous</p>
                            </div>
                        </a>

                        <a href="${pageContext.request.contextPath}/patient/dashboard?section=mes-consultations" class="flex items-center space-x-4 p-6 bg-gradient-to-br from-green-50 to-green-100 rounded-xl hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                            <div class="w-12 h-12 bg-green-600 rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                </svg>
                            </div>
                            <div class="text-left">
                                <p class="font-bold text-green-900">Mes Consultations</p>
                                <p class="text-sm text-gray-600">Voir mes rendez-vous</p>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Prochaines Consultations -->
                <% if (prochaines != null && !prochaines.isEmpty()) { %>
                <div class="bg-white rounded-2xl p-8 shadow-lg">
                    <h3 class="text-2xl font-bold text-blue-900 mb-6">Mes Prochaines Consultations</h3>
                    <div class="space-y-4">
                        <%
                            String[] colors = {"blue", "green", "purple"};
                            int colorIndex = 0;
                            for (Consultation cons : prochaines) {
                                String color = colors[colorIndex % colors.length];
                                colorIndex++;
                                String docteurInitiales = "";
                                if (cons.getDocteur().getPrenom() != null) docteurInitiales += cons.getDocteur().getPrenom().charAt(0);
                                if (cons.getDocteur().getNom() != null) docteurInitiales += cons.getDocteur().getNom().charAt(0);
                        %>
                        <div class="flex items-center justify-between p-4 bg-<%= color %>-50 rounded-lg hover:shadow-md transition-all">
                            <div class="flex items-center space-x-4">
                                <div class="w-12 h-12 bg-<%= color %>-600 rounded-full flex items-center justify-center text-white font-bold">
                                    <%= docteurInitiales.toUpperCase() %>
                                </div>
                                <div>
                                    <p class="font-bold text-<%= color %>-900">Dr. <%= cons.getDocteur().getPrenom() %> <%= cons.getDocteur().getNom() %></p>
                                    <p class="text-sm text-gray-600"><%= cons.getDocteur().getDepartement() != null ? cons.getDocteur().getDepartement().getNom() : "" %></p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="font-semibold text-<%= color %>-900"><%= cons.getDateETheur().format(dateFormatter) %></p>
                                <p class="text-sm text-gray-600"><%= cons.getDateETheur().format(heureFormatter) %></p>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
                <% } %>
            </section>

            <!-- Nouvelle Consultation Section - CORRECTED -->
            <section id="nouvelle-consultation-section" class="<%= "nouvelle-consultation".equals(showSection) ? "" : "hidden" %>">
                <div class="bg-white rounded-2xl shadow-lg p-8">
                    <h3 class="text-2xl font-bold text-blue-900 mb-6">Nouvelle Consultation</h3>

                    <!-- Formulaire pour sélectionner le département (séparé) -->
                    <form action="${pageContext.request.contextPath}/patient/dashboard" method="get" class="max-w-2xl mx-auto">
                        <input type="hidden" name="section" value="nouvelle-consultation">

                        <!-- Étape 1: Département -->
                        <div class="mb-8">
                            <label class="block text-gray-700 text-sm font-bold mb-3">1. Choisissez un département</label>
                            <select name="departementId" id="departementSelect" onchange="this.form.submit()" class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors">
                                <option value="">Sélectionner un département</option>
                                <%
                                    List<Departement> departements = (List<Departement>) request.getAttribute("departements");
                                    String selectedDeptId = request.getParameter("departementId");
                                    if (departements != null) {
                                        for (Departement dept : departements) {
                                %>
                                <option value="<%= dept.getId() %>" <%= dept.getId().toString().equals(selectedDeptId) ? "selected" : "" %>>
                                    <%= dept.getNom() %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </form>

                    <!-- Formulaire pour créer la consultation -->
                    <form action="${pageContext.request.contextPath}/patient/dashboard" method="post" class="max-w-2xl mx-auto">
                        <input type="hidden" name="action" value="creer">

                        <!-- Conserver le département sélectionné -->
                        <% if (selectedDeptId != null && !selectedDeptId.isEmpty()) { %>
                        <input type="hidden" name="departementId" value="<%= selectedDeptId %>">
                        <% } %>

                        <!-- Étape 2: Date et Heure -->
                        <div class="grid grid-cols-2 gap-6 mb-8">
                            <div>
                                <label class="block text-gray-700 text-sm font-bold mb-3">2. Date souhaitée</label>
                                <input type="date" name="date" required min="<%= java.time.LocalDate.now() %>" class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors">
                            </div>
                            <div>
                                <label class="block text-gray-700 text-sm font-bold mb-3">Heure souhaitée</label>
                                <input type="time" name="heure" required class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors">
                            </div>
                        </div>

                        <!-- Étape 3: Docteurs disponibles -->
                        <div class="mb-8">
                            <label class="block text-gray-700 text-sm font-bold mb-3">3. Sélectionnez votre docteur</label>
                            <div id="docteursDisponibles" class="grid grid-cols-1 gap-4">
                                <%
                                    List<Docteur> docteursDisponibles = (List<Docteur>) request.getAttribute("docteursDisponibles");
                                    if (docteursDisponibles != null && !docteursDisponibles.isEmpty()) {
                                        String[] docteurColors = {"blue", "green", "purple", "orange", "red"};
                                        int dColorIndex = 0;
                                        for (Docteur doc : docteursDisponibles) {
                                            String dColor = docteurColors[dColorIndex % docteurColors.length];
                                            dColorIndex++;
                                            String dInitiales = "";
                                            if (doc.getPrenom() != null) dInitiales += doc.getPrenom().charAt(0);
                                            if (doc.getNom() != null) dInitiales += doc.getNom().charAt(0);
                                %>
                                <label class="flex items-center p-4 border-2 border-gray-200 rounded-lg cursor-pointer hover:border-blue-500 transition-all">
                                    <input type="radio" name="docteurId" value="<%= doc.getId() %>" required class="mr-4 w-5 h-5">
                                    <div class="flex items-center space-x-4 flex-1">
                                        <div class="w-12 h-12 bg-<%= dColor %>-600 rounded-full flex items-center justify-center text-white font-bold">
                                            <%= dInitiales.toUpperCase() %>
                                        </div>
                                        <div>
                                            <p class="font-bold text-<%= dColor %>-900">Dr. <%= doc.getPrenom() %> <%= doc.getNom() %></p>
                                            <p class="text-sm text-gray-600"><%= doc.getSpecialite() %></p>
                                        </div>
                                    </div>
                                </label>
                                <%
                                    }
                                } else if (selectedDeptId != null && !selectedDeptId.isEmpty()) {
                                %>
                                <p class="text-gray-500 text-center py-4">Aucun docteur disponible dans ce département</p>
                                <% } else { %>
                                <p class="text-gray-500 text-center py-4">Veuillez sélectionner un département pour voir les docteurs disponibles</p>
                                <% } %>
                            </div>
                        </div>

                        <!-- Bouton de confirmation -->
                        <% if (docteursDisponibles != null && !docteursDisponibles.isEmpty()) { %>
                        <div class="flex space-x-4">
                            <button type="submit" class="flex-1 bg-gradient-to-r from-blue-900 to-blue-700 text-white font-bold py-4 px-6 rounded-lg hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                                Confirmer la consultation
                            </button>
                            <button type="reset" class="px-6 py-4 bg-gray-200 text-gray-700 font-bold rounded-lg hover:bg-gray-300 transition-colors">
                                Réinitialiser
                            </button>
                        </div>
                        <% } %>
                    </form>
                </div>
            </section>

            <!-- Mes Consultations Section -->
            <section id="mes-consultations-section" class="<%= "mes-consultations".equals(showSection) ? "" : "hidden" %>">
                <div class="bg-white rounded-2xl shadow-lg p-8">
                    <h3 class="text-2xl font-bold text-blue-900 mb-6">Mes Consultations à venir</h3>

                    <%
                        List<Consultation> consultationsFutures = (List<Consultation>) request.getAttribute("consultationsFutures");
                        if (consultationsFutures != null && !consultationsFutures.isEmpty()) {
                    %>
                    <div class="space-y-6">
                        <%
                            String[] consColors = {"blue", "green", "purple", "orange", "red"};
                            int consColorIndex = 0;
                            for (Consultation cons : consultationsFutures) {
                                String consColor = consColors[consColorIndex % consColors.length];
                                consColorIndex++;
                                String consInitiales = "";
                                if (cons.getDocteur().getPrenom() != null) consInitiales += cons.getDocteur().getPrenom().charAt(0);
                                if (cons.getDocteur().getNom() != null) consInitiales += cons.getDocteur().getNom().charAt(0);
                        %>
                        <div class="border-2 border-gray-200 rounded-xl p-6 hover:shadow-lg transition-all">
                            <div class="flex items-center justify-between mb-4">
                                <div class="flex items-center space-x-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-<%= consColor %>-600 to-<%= consColor %>-400 rounded-full flex items-center justify-center text-white text-xl font-bold">
                                        <%= consInitiales.toUpperCase() %>
                                    </div>
                                    <div>
                                        <h4 class="text-lg font-bold text-<%= consColor %>-900">Dr. <%= cons.getDocteur().getPrenom() %> <%= cons.getDocteur().getNom() %></h4>
                                        <p class="text-sm text-gray-600"><%= cons.getDocteur().getDepartement() != null ? cons.getDocteur().getDepartement().getNom() : "" %></p>
                                    </div>
                                </div>
                                <span class="px-4 py-2 bg-<%= consColor %>-100 text-<%= consColor %>-800 rounded-full text-sm font-semibold">
                                    <%= cons.getStatut().toString() %>
                                </span>
                            </div>

                            <div class="grid grid-cols-2 gap-4 mb-4">
                                <div class="flex items-center text-gray-700">
                                    <svg class="w-5 h-5 mr-2 text-<%= consColor %>-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                    </svg>
                                    <span class="font-semibold">Date:</span>&nbsp; <%= cons.getDateETheur().format(dateFormatter) %>
                                </div>
                                <div class="flex items-center text-gray-700">
                                    <svg class="w-5 h-5 mr-2 text-<%= consColor %>-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                    <span class="font-semibold">Heure:</span>&nbsp; <%= cons.getDateETheur().format(heureFormatter) %>
                                </div>
                                <% if (cons.getSalle() != null) { %>
                                <div class="flex items-center text-gray-700">
                                    <svg class="w-5 h-5 mr-2 text-<%= consColor %>-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                    </svg>
                                    <span class="font-semibold">Salle:</span>&nbsp; <%= cons.getSalle().getNom() %>
                                </div>
                                <% } %>
                            </div>

                            <div class="flex space-x-3">
                                <button onclick="openModalModifier(<%= cons.getId() %>, '<%= cons.getDateETheur().toLocalDate() %>', '<%= cons.getDateETheur().format(heureFormatter) %>')" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors font-semibold">
                                    Modifier
                                </button>
                                <button onclick="openModalAnnuler(<%= cons.getId() %>)" class="flex-1 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors font-semibold">
                                    Annuler
                                </button>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <% } else { %>
                    <div class="text-center py-12">
                        <svg class="w-16 h-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                        </svg>
                        <p class="text-gray-500 text-lg">Aucune consultation à venir</p>
                        <a href="${pageContext.request.contextPath}/patient/dashboard?section=nouvelle-consultation" class="mt-4 inline-block px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors font-semibold">
                            Prendre rendez-vous
                        </a>
                    </div>
                    <% } %>
                </div>
            </section>

            <!-- Historique Section -->
            <section id="historique-section" class="<%= "historique".equals(showSection) ? "" : "hidden" %>">
                <div class="bg-white rounded-2xl shadow-lg p-8">
                    <h3 class="text-2xl font-bold text-blue-900 mb-6">Historique des Consultations</h3>

                    <%
                        List<Consultation> historique = (List<Consultation>) request.getAttribute("historique");
                        if (historique != null && !historique.isEmpty()) {
                    %>
                    <div class="space-y-6">
                        <%
                            String[] histColors = {"blue", "green", "orange", "purple", "red"};
                            int histColorIndex = 0;
                            for (Consultation cons : historique) {
                                String histColor = histColors[histColorIndex % histColors.length];
                                histColorIndex++;
                                String histInitiales = "";
                                if (cons.getDocteur().getPrenom() != null) histInitiales += cons.getDocteur().getPrenom().charAt(0);
                                if (cons.getDocteur().getNom() != null) histInitiales += cons.getDocteur().getNom().charAt(0);
                        %>
                        <div class="border-2 border-gray-200 rounded-xl p-6 bg-gray-50">
                            <div class="flex items-center justify-between mb-4">
                                <div class="flex items-center space-x-4">
                                    <div class="w-16 h-16 bg-gradient-to-br from-<%= histColor %>-600 to-<%= histColor %>-400 rounded-full flex items-center justify-center text-white text-xl font-bold">
                                        <%= histInitiales.toUpperCase() %>
                                    </div>
                                    <div>
                                        <h4 class="text-lg font-bold text-<%= histColor %>-900">Dr. <%= cons.getDocteur().getPrenom() %> <%= cons.getDocteur().getNom() %></h4>
                                        <p class="text-sm text-gray-600"><%= cons.getDocteur().getDepartement() != null ? cons.getDocteur().getDepartement().getNom() : "" %></p>
                                    </div>
                                </div>
                                <span class="px-4 py-2 bg-green-100 text-green-800 rounded-full text-sm font-semibold">
                                    Terminée
                                </span>
                            </div>

                            <div class="grid grid-cols-2 gap-4 mb-4">
                                <div class="flex items-center text-gray-700">
                                    <svg class="w-5 h-5 mr-2 text-<%= histColor %>-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                    </svg>
                                    <span class="font-semibold">Date:</span>&nbsp; <%= cons.getDateETheur().format(dateFormatter) %>
                                </div>
                                <div class="flex items-center text-gray-700">
                                    <svg class="w-5 h-5 mr-2 text-<%= histColor %>-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                    <span class="font-semibold">Heure:</span>&nbsp; <%= cons.getDateETheur().format(heureFormatter) %>
                                </div>
                            </div>

                            <% if (cons.getCompteRendu() != null && !cons.getCompteRendu().isEmpty()) { %>
                            <div class="bg-white rounded-lg p-4 border-l-4 border-<%= histColor %>-600">
                                <p class="text-sm font-bold text-gray-800 mb-2">Compte rendu du docteur:</p>
                                <p class="text-sm text-gray-700 leading-relaxed">
                                    <%= cons.getCompteRendu() %>
                                </p>
                            </div>
                            <% } %>
                        </div>
                        <% } %>
                    </div>
                    <% } else { %>
                    <div class="text-center py-12">
                        <svg class="w-16 h-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                        </svg>
                        <p class="text-gray-500 text-lg">Aucune consultation dans l'historique</p>
                    </div>
                    <% } %>
                </div>
            </section>
        </div>
    </main>
</div>

<!-- Modal Modifier Consultation -->
<div id="modifierModal" class="modal fixed inset-0 bg-black bg-opacity-50 items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md mx-4 transform transition-all">
        <div class="bg-gradient-to-r from-blue-900 to-blue-700 px-6 py-4 rounded-t-2xl">
            <h3 class="text-2xl font-bold text-white">Modifier la Consultation</h3>
        </div>
        <form action="${pageContext.request.contextPath}/patient/dashboard" method="post" class="p-6">
            <input type="hidden" name="action" value="modifier">
            <input type="hidden" name="consultationId" id="modifierConsultationId">

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Nouvelle Date</label>
                <input type="date" name="date" id="modifierDate" required min="<%= java.time.LocalDate.now() %>" class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors">
            </div>

            <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2">Nouvelle Heure</label>
                <input type="time" name="heure" id="modifierHeure" required class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors">
            </div>

            <div class="flex space-x-4">
                <button type="submit" class="flex-1 bg-gradient-to-r from-blue-900 to-blue-700 text-white font-bold py-3 px-6 rounded-lg hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                    Confirmer
                </button>
                <button type="button" onclick="closeModal('modifier')" class="flex-1 bg-gray-200 text-gray-700 font-bold py-3 px-6 rounded-lg hover:bg-gray-300 transition-colors">
                    Annuler
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Annuler Consultation -->
<div id="annulerModal" class="modal fixed inset-0 bg-black bg-opacity-50 items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md mx-4 transform transition-all">
        <div class="bg-gradient-to-r from-red-600 to-red-500 px-6 py-4 rounded-t-2xl">
            <h3 class="text-2xl font-bold text-white">Annuler la Consultation</h3>
        </div>
        <form action="${pageContext.request.contextPath}/patient/dashboard" method="post" class="p-6">
            <input type="hidden" name="action" value="annuler">
            <input type="hidden" name="consultationId" id="annulerConsultationId">

            <div class="flex items-center justify-center mb-6">
                <svg class="w-16 h-16 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
                </svg>
            </div>

            <p class="text-center text-gray-700 mb-6">
                Êtes-vous sûr de vouloir annuler cette consultation ?<br>
                <span class="text-sm text-gray-500">Cette action est irréversible.</span>
            </p>

            <div class="flex space-x-4">
                <button type="submit" class="flex-1 bg-red-600 text-white font-bold py-3 px-6 rounded-lg hover:bg-red-700 transition-colors">
                    Oui, annuler
                </button>
                <button type="button" onclick="closeModal('annuler')" class="flex-1 bg-gray-200 text-gray-700 font-bold py-3 px-6 rounded-lg hover:bg-gray-300 transition-colors">
                    Non, garder
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    // Gestion des modals
    function openModal(type) {
        document.getElementById(type + 'Modal').classList.add('active');
    }

    function closeModal(type) {
        document.getElementById(type + 'Modal').classList.remove('active');
    }

    function openModalModifier(id, date, heure) {
        document.getElementById('modifierConsultationId').value = id;
        document.getElementById('modifierDate').value = date;
        document.getElementById('modifierHeure').value = heure;
        openModal('modifier');
    }

    function openModalAnnuler(id) {
        document.getElementById('annulerConsultationId').value = id;
        openModal('annuler');
    }

    // Fermer en cliquant à l'extérieur
    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.classList.remove('active');
        }
    }

    // Fermer avec la touche Escape
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            const modals = document.querySelectorAll('.modal.active');
            modals.forEach(modal => modal.classList.remove('active'));
        }
    });
</script>

</body>
</html>