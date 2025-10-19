<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.clinique.service.admin.Departement.IDepartementService" %>
<%@ page import="com.clinique.service.admin.Departement.DepartementServiceImpl" %>
<%@ page import="com.clinique.repository.IDepartement" %>
<%@ page import="com.clinique.repository.impl.DepartementRepositoryImpl" %>
<%@ page import="com.clinique.entities.Departement" %>

<%@ page import="com.clinique.service.admin.Salle.ISalleService" %>
<%@ page import="com.clinique.service.admin.Salle.SalleServiceImpl" %>
<%@ page import="com.clinique.repository.ISalleRepository" %>
<%@ page import="com.clinique.repository.impl.SalleRepositoryImpl" %>
<%@ page import="com.clinique.entities.Salle" %>
<%@ page import="java.util.List" %>

<%@ page import="com.clinique.service.admin.Docteur.IDocteurService" %>
<%@ page import="com.clinique.service.admin.Docteur.DocteurServiceImpl" %>
<%@ page import="com.clinique.repository.IDocteur" %>
<%@ page import="com.clinique.repository.impl.DocteurRepositoryImpl" %>
<%@ page import="com.clinique.entities.Docteur" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - DigitalCare</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }
        .modal {
            display: none;
        }
        .modal.active {
            display: flex;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-blue-100">

<%
    System.out.println("=== DÉBUT DU CHARGEMENT JSP ===");

    String showSection = (String) request.getAttribute("showSection");
    if (showSection == null) {
        showSection = "dashboard";
    }
    System.out.println("Section à afficher: " + showSection);

    // INITIALISATION DES VARIABLES
    IDepartement departementRepository = null;
    IDepartementService departementService = null;
    List<Departement> departements = null;

    ISalleService salleService = null;
    List<Salle> salles = null;

    IDocteurService docteurService = null;
    List<Docteur> docteurs = null;

    // CHARGEMENT DES DÉPARTEMENTS (nécessaire pour tous les dropdowns)
    try {
        System.out.println("Chargement des départements...");
        departementRepository = new DepartementRepositoryImpl();
        departementService = new DepartementServiceImpl(departementRepository);
        departements = departementService.listerTousLesDepartements();
        System.out.println("Départements chargés: " + (departements != null ? departements.size() : 0));
    } catch (Exception e) {
        System.err.println("ERREUR lors du chargement des départements: " + e.getMessage());
        e.printStackTrace();
%>
<div class='fixed top-4 right-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded z-50'>
    Erreur départements: <%= e.getMessage() %>
</div>
<%
    }

    // CHARGEMENT DES SALLES (seulement si nécessaire)
    if ("salles".equals(showSection) || "dashboard".equals(showSection)) {
        try {
            System.out.println("Chargement des salles...");
            ISalleRepository salleRepository = new SalleRepositoryImpl();
            salleService = new SalleServiceImpl(salleRepository, departementRepository);
            salles = salleService.listerToutesLesSalles();
            System.out.println("Salles chargées: " + (salles != null ? salles.size() : 0));
        } catch (Exception e) {
            System.err.println("ERREUR lors du chargement des salles: " + e.getMessage());
            e.printStackTrace();
%>
<div class='fixed top-4 right-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded z-50'>
    Erreur salles: <%= e.getMessage() %>
</div>
<%
        }
    }

    // CHARGEMENT DES DOCTEURS (seulement si nécessaire)
    if ("docteurs".equals(showSection) || "dashboard".equals(showSection)) {
        try {
            System.out.println("Chargement des docteurs...");
            IDocteur docteurRepository = new DocteurRepositoryImpl();
            docteurService = new DocteurServiceImpl(docteurRepository, departementRepository);
            docteurs = docteurService.listerTousLesDocteurs();
            System.out.println("Docteurs chargés: " + (docteurs != null ? docteurs.size() : 0));
        } catch (Exception e) {
            System.err.println("ERREUR lors du chargement des docteurs: " + e.getMessage());
            e.printStackTrace();
%>
<div class='fixed top-4 right-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded z-50'>
    Erreur docteurs: <%= e.getMessage() %>
</div>
<%
        }
    }

    System.out.println("=== FIN DU CHARGEMENT DES DONNÉES ===");
%>


<!-- Sidebar -->
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
                <!-- AJOUTER CECI -->
                <div>
                    <h1 class="text-xl font-bold text-white">DigitalCare</h1>
                    <p class="text-xs text-blue-200">Admin Panel</p>
                </div>
            </div>

            <nav class="space-y-2">
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="nav-link flex items-center space-x-3 px-4 py-3 rounded-lg <%= "dashboard".equals(showSection) ? "bg-blue-800" : "hover:bg-blue-800" %> transition-all duration-300">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                    </svg>
                    <span>Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/departements"
                   class="nav-link flex items-center space-x-3 px-4 py-3 rounded-lg <%= "departements".equals(showSection) ? "bg-blue-800" : "hover:bg-blue-800" %> transition-all duration-300">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                    </svg>
                    <span>Départements</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/salles"
                   class="nav-link flex items-center space-x-3 px-4 py-3 rounded-lg <%= "salles".equals(showSection) ? "bg-blue-800" : "hover:bg-blue-800" %> transition-all duration-300">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 5a1 1 0 011-1h14a1 1 0 011 1v2a1 1 0 01-1 1H5a1 1 0 01-1-1V5zM4 13a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H5a1 1 0 01-1-1v-6zM16 13a1 1 0 011-1h2a1 1 0 011 1v6a1 1 0 01-1 1h-2a1 1 0 01-1-1v-6z"></path>
                    </svg>
                    <span>Salles</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/docteurs"
                   class="nav-link flex items-center space-x-3 px-4 py-3 rounded-lg <%= "docteurs".equals(showSection) ? "bg-blue-800" : "hover:bg-blue-800" %> transition-all duration-300">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                    </svg>
                    <span>Docteurs</span>
                </a>
            </nav>
        </div>

        <div class="absolute bottom-0 w-64 p-6 border-t border-blue-700">
            <div class="flex items-center space-x-3">
                <div class="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center">
                    <span class="text-sm font-bold">AD</span>
                </div>
                <div>
                    <p class="font-semibold text-sm">Admin</p>
                    <p class="text-xs text-blue-200">admin@digitalcare.com</p>
                </div>
            </div>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 overflow-y-auto">
        <!-- Header -->
        <header class="bg-white shadow-md sticky top-0 z-40">
            <div class="px-8 py-6 flex justify-between items-center">
                <div>
                    <h2 class="text-3xl font-bold text-blue-900" id="pageTitle">Dashboard</h2>
                    <p class="text-gray-600 mt-1">Gérez votre établissement médical</p>
                </div>
                <button class="px-6 py-3 bg-gradient-to-r from-blue-900 to-blue-700 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                    <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path>
                    </svg>
                    Notifications
                </button>
            </div>
        </header>

        <div class="p-8">
            <!-- Dashboard Section -->
            <section id="dashboard-section" class="content-section <%= "dashboard".equals(showSection) ? "" : "hidden" %>">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    <!-- Stat Card 1 -->
                    <div class="bg-white rounded-2xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-600 text-sm font-medium">Départements</p>
                                <p class="text-3xl font-bold text-blue-900 mt-2">12</p>
                                <p class="text-green-600 text-sm mt-2">↑ 2 ce mois</p>
                            </div>
                            <div class="w-14 h-14 bg-gradient-to-br from-blue-900 to-blue-700 rounded-xl flex items-center justify-center">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <!-- Stat Card 2 -->
                    <div class="bg-white rounded-2xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-600 text-sm font-medium">Salles</p>
                                <p class="text-3xl font-bold text-blue-900 mt-2">45</p>
                                <p class="text-green-600 text-sm mt-2">↑ 5 ce mois</p>
                            </div>
                            <div class="w-14 h-14 bg-gradient-to-br from-green-600 to-green-500 rounded-xl flex items-center justify-center">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 5a1 1 0 011-1h14a1 1 0 011 1v2a1 1 0 01-1 1H5a1 1 0 01-1-1V5zM4 13a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H5a1 1 0 01-1-1v-6zM16 13a1 1 0 011-1h2a1 1 0 011 1v6a1 1 0 01-1 1h-2a1 1 0 01-1-1v-6z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <!-- Stat Card 3 -->
                    <div class="bg-white rounded-2xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-600 text-sm font-medium">Docteurs</p>
                                <p class="text-3xl font-bold text-blue-900 mt-2">87</p>
                                <p class="text-green-600 text-sm mt-2">↑ 12 ce mois</p>
                            </div>
                            <div class="w-14 h-14 bg-gradient-to-br from-purple-600 to-purple-500 rounded-xl flex items-center justify-center">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>

                    <!-- Stat Card 4 -->
                    <div class="bg-white rounded-2xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-gray-600 text-sm font-medium">Capacité Totale</p>
                                <p class="text-3xl font-bold text-blue-900 mt-2">850</p>
                                <p class="text-blue-600 text-sm mt-2">patients/jour</p>
                            </div>
                            <div class="w-14 h-14 bg-gradient-to-br from-orange-600 to-orange-500 rounded-xl flex items-center justify-center">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="bg-white rounded-2xl p-8 shadow-lg mb-8">
                    <h3 class="text-2xl font-bold text-blue-900 mb-6">Actions Rapides</h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <!-- Bouton Département - CORRECT -->
                        <button onclick="openModalCreer()" class="flex items-center space-x-4 p-6 bg-gradient-to-br from-blue-50 to-blue-100 rounded-xl hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                            <div class="w-12 h-12 bg-blue-900 rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                </svg>
                            </div>
                            <div class="text-left">
                                <p class="font-bold text-blue-900">Ajouter Département</p>
                                <p class="text-sm text-gray-600">Créer un nouveau département</p>
                            </div>
                        </button>

                        <!-- Bouton Salle - CORRIGÉ -->
                        <button onclick="openModalCreerSalle()" class="flex items-center space-x-4 p-6 bg-gradient-to-br from-green-50 to-green-100 rounded-xl hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                            <div class="w-12 h-12 bg-green-600 rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                </svg>
                            </div>
                            <div class="text-left">
                                <p class="font-bold text-green-900">Ajouter Salle</p>
                                <p class="text-sm text-gray-600">Créer une nouvelle salle</p>
                            </div>
                        </button>

                        <!-- Bouton Docteur - CORRECT -->
                        <button onclick="openModalCreerDocteur()" class="flex items-center space-x-4 p-6 bg-gradient-to-br from-purple-50 to-purple-100 rounded-xl hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                            <div class="w-12 h-12 bg-purple-600 rounded-lg flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                </svg>
                            </div>
                            <div class="text-left">
                                <p class="font-bold text-purple-900">Ajouter Docteur</p>
                                <p class="text-sm text-gray-600">Ajouter un nouveau docteur</p>
                            </div>
                        </button>
                    </div>
                </div>
            </section>

            <!-- Section Départements -->
            <section id="departements-section" class="content-section <%= "departements".equals(showSection) ? "" : "hidden" %>">
                <div class="bg-white rounded-2xl shadow-lg p-8">

                    <!-- Messages de succès et d'erreur -->
                    <%
                        String successMessage = (String) request.getAttribute("successMessage");
                        String errorMessage = (String) request.getAttribute("errorMessage");

                        if (successMessage != null) { %>
                    <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <%= successMessage %>
                    </div>
                    <% }

                        if (errorMessage != null) { %>
                    <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <%= errorMessage %>
                    </div>
                    <% } %>

                    <div class="flex justify-between items-center mb-6">
                        <h3 class="text-2xl font-bold text-blue-900">Gestion des Départements</h3>
                        <button onclick="openModalCreer()" class="px-6 py-3 bg-gradient-to-r from-blue-900 to-blue-700 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                            <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                            </svg>
                            Nouveau Département
                        </button>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                            <tr class="bg-blue-50 border-b-2 border-blue-100">
                                <th class="px-6 py-4 text-left text-sm font-bold text-blue-900">ID</th>
                                <th class="px-6 py-4 text-left text-sm font-bold text-blue-900">Nom du Département</th>
                                <th class="px-6 py-4 text-left text-sm font-bold text-blue-900">Actions</th>
                            </tr>
                            </thead>
                            <tbody id="departementsTable">
                            <% if (departements != null && !departements.isEmpty()) {
                                for (Departement dep : departements) { %>
                            <tr class="border-b border-gray-100 hover:bg-blue-50 transition-colors">
                                <td class="px-6 py-4 text-gray-800"><%= dep.getId() %></td>
                                <td class="px-6 py-4 font-semibold text-blue-900"><%= dep.getNom() %></td>
                                <td class="px-6 py-4">
                                    <div class="flex space-x-2">
                                        <!-- Bouton Modifier -->
                                        <button onclick="openModalModifier(<%= dep.getId() %>, '<%= dep.getNom() %>')"
                                                class="text-blue-600 hover:text-blue-800 px-3 py-1 rounded hover:bg-blue-100 transition-colors">
                                            <svg class="w-5 h-5 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                            </svg>
                                            Modifier
                                        </button>

                                        <!-- Bouton Supprimer sans confirmation -->
                                        <form action="${pageContext.request.contextPath}/admin/departements" method="post" class="inline">
                                            <input type="hidden" name="action" value="supprimer">
                                            <input type="hidden" name="id" value="<%= dep.getId() %>">
                                            <button type="submit"
                                                    class="text-red-600 hover:text-red-800 px-3 py-1 rounded hover:bg-red-100 transition-colors">
                                                <svg class="w-5 h-5 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                </svg>
                                                Supprimer
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                            <%   }
                            } else { %>
                            <tr>
                                <td colspan="3" class="px-6 py-8 text-center text-gray-500">
                                    <svg class="w-16 h-16 mx-auto mb-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
                                    </svg>
                                    <p class="text-lg font-semibold">Aucun département trouvé</p>
                                    <p class="text-sm mt-2">Commencez par créer votre premier département</p>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- Modal Département (Version améliorée) -->
            <div id="departementModal" class="modal fixed inset-0 bg-black bg-opacity-50 items-center justify-center z-50">
                <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md mx-4 transform transition-all">
                    <div class="bg-gradient-to-r from-blue-900 to-blue-700 px-6 py-4 rounded-t-2xl">
                        <h3 class="text-2xl font-bold text-white" id="departementModalTitle">Ajouter un Département</h3>
                    </div>
                    <form id="departementForm" action="${pageContext.request.contextPath}/admin/departements" method="post" class="p-6">
                        <input type="hidden" name="action" id="departementAction" value="creer">
                        <input type="hidden" name="id" id="departementId">

                        <div class="mb-6">
                            <label class="block text-gray-700 text-sm font-bold mb-2">Nom du Département</label>
                            <input type="text" name="nom" id="departementNom" required
                                   class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-blue-500 focus:outline-none transition-colors"
                                   placeholder="Ex: Cardiologie">
                        </div>

                        <div class="flex space-x-4">
                            <button type="submit"
                                    class="flex-1 bg-gradient-to-r from-blue-900 to-blue-700 text-white font-bold py-3 px-6 rounded-lg hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                                Enregistrer
                            </button>
                            <button type="button" onclick="closeModal('departement')"
                                    class="flex-1 bg-gray-200 text-gray-700 font-bold py-3 px-6 rounded-lg hover:bg-gray-300 transition-colors">
                                Annuler
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Salles Section -->
            <section id="salles-section" class="content-section <%= "salles".equals(showSection) ? "" : "hidden" %>">
                <div class="bg-white rounded-2xl shadow-lg p-8">

                    <%
                        String successMessageSalle = (String) request.getAttribute("successMessage");
                        String errorMessageSalle = (String) request.getAttribute("errorMessage");

                        if (successMessageSalle != null) { %>
                    <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <%= successMessageSalle %>
                    </div>
                    <% }

                        if (errorMessageSalle != null) { %>
                    <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <%= errorMessageSalle %>
                    </div>
                    <% } %>

                    <div class="flex justify-between items-center mb-6">
                        <h3 class="text-2xl font-bold text-blue-900">Gestion des Salles</h3>
                        <button onclick="openModalCreerSalle()" class="px-6 py-3 bg-gradient-to-r from-green-600 to-green-500 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                            <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                            </svg>
                            Nouvelle Salle
                        </button>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="sallesGrid">
                        <% if (salles != null && !salles.isEmpty()) {
                            for (Salle salle : salles) {
                                String colorClass = "green";
                                if (salle.getId() % 3 == 0) colorClass = "purple";
                                else if (salle.getId() % 2 == 0) colorClass = "blue";
                        %>
                        <!-- Salle Card -->
                        <div class="bg-gradient-to-br from-<%= colorClass %>-50 to-<%= colorClass %>-100 rounded-xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                            <div class="flex justify-between items-start mb-4">
                                <div>
                                    <h4 class="text-xl font-bold text-<%= colorClass %>-900"><%= salle.getNom() %></h4>
                                    <p class="text-sm text-gray-600"><%= salle.getDepartement().getNom() %></p>
                                </div>
                                <span class="px-3 py-1 bg-<%= colorClass %>-500 text-white text-xs font-semibold rounded-full">Active</span>
                            </div>
                            <div class="mb-4">
                                <p class="text-gray-700 flex items-center">
                                    <svg class="w-5 h-5 mr-2 text-<%= colorClass %>-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                    </svg>
                                    <span class="font-semibold">Capacité:</span> <%= salle.getCapacite() %> personnes
                                </p>
                            </div>
                            <div class="flex space-x-2">
                                <button onclick="openModalModifierSalle(<%= salle.getId() %>, '<%= salle.getNom() %>', <%= salle.getCapacite() %>, <%= salle.getDepartement().getId() %>)"
                                        class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
                                    Modifier
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/salles" method="post" class="inline">
                                    <input type="hidden" name="action" value="supprimer">
                                    <input type="hidden" name="id" value="<%= salle.getId() %>">
                                    <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                        </svg>
                                    </button>
                                </form>
                            </div>
                        </div>
                        <%   }
                        } else { %>
                        <div class="col-span-full">
                            <div class="text-center py-12">
                                <svg class="w-16 h-16 mx-auto mb-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 5a1 1 0 011-1h14a1 1 0 011 1v2a1 1 0 01-1 1H5a1 1 0 01-1-1V5zM4 13a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H5a1 1 0 01-1-1v-6zM16 13a1 1 0 011-1h2a1 1 0 011 1v6a1 1 0 01-1 1h-2a1 1 0 01-1-1v-6z"></path>
                                </svg>
                                <p class="text-lg font-semibold text-gray-600">Aucune salle trouvée</p>
                                <p class="text-sm text-gray-500 mt-2">Commencez par créer votre première salle</p>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </section>

            <!-- Docteurs Section -->

            <!-- Docteurs Section - VERSION CORRIGÉE -->
            <!-- Docteurs Section - VERSION CORRIGÉE -->
            <section id="docteurs-section" class="content-section <%= "docteurs".equals(showSection) ? "" : "hidden" %>">
                <div class="bg-white rounded-2xl shadow-lg p-8">

                    <!-- Messages de succès et d'erreur -->
                    <%
                        String successMessageDocteur = (String) request.getAttribute("successMessage");
                        String errorMessageDocteur = (String) request.getAttribute("errorMessage");

                        if (successMessageDocteur != null) { %>
                    <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <%= successMessageDocteur %>
                    </div>
                    <% }

                        if (errorMessageDocteur != null) { %>
                    <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <%= errorMessageDocteur %>
                    </div>
                    <% } %>

                    <div class="flex justify-between items-center mb-6">
                        <h3 class="text-2xl font-bold text-blue-900">Gestion des Docteurs</h3>
                        <button onclick="openModalCreerDocteur()" class="px-6 py-3 bg-gradient-to-r from-purple-600 to-purple-500 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                            <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                            </svg>
                            Nouveau Docteur
                        </button>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="docteursGrid">
                        <%
                            try {
                                if (docteurs != null && !docteurs.isEmpty()) {
                                    String[] colors = {"purple", "blue", "green", "orange", "red", "indigo"};
                                    int colorIndex = 0;

                                    for (Docteur docteur : docteurs) {
                                        try {
                                            String colorClass = colors[colorIndex % colors.length];
                                            colorIndex++;

                                            // Gestion sécurisée des initiales
                                            String initiales = "DR";
                                            if (docteur.getNom() != null && !docteur.getNom().isEmpty()) {
                                                initiales = String.valueOf(docteur.getNom().charAt(0));
                                            }
                                            if (docteur.getPrenom() != null && !docteur.getPrenom().isEmpty()) {
                                                initiales += docteur.getPrenom().charAt(0);
                                            }

                                            // Valeurs par défaut pour éviter les nulls
                                            String nom = docteur.getNom() != null ? docteur.getNom() : "N/A";
                                            String prenom = docteur.getPrenom() != null ? docteur.getPrenom() : "N/A";
                                            String email = docteur.getEmail() != null ? docteur.getEmail() : "email@example.com";
                                            String specialite = docteur.getSpecialite() != null ? docteur.getSpecialite() : "Non spécifié";
                                            String departementNom = docteur.getDepartement() != null ? docteur.getDepartement().getNom() : "Non assigné";
                                            Long departementId = docteur.getDepartement() != null ? docteur.getDepartement().getId() : null;
                        %>
                        <!-- Docteur Card -->
                        <div class="bg-white border-2 border-gray-200 rounded-xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300">
                            <div class="flex items-center space-x-4 mb-4">
                                <!-- Avatar avec initiales - COULEUR FIXE -->
                                <div class="w-16 h-16 bg-gradient-to-br from-purple-600 to-purple-400 rounded-full flex items-center justify-center text-white text-2xl font-bold">
                                    <%= initiales.toUpperCase() %>
                                </div>
                                <div>
                                    <h4 class="text-lg font-bold text-blue-900">Dr. <%= prenom %> <%= nom %></h4>
                                    <p class="text-sm text-gray-600"><%= specialite %></p>
                                </div>
                            </div>
                            <div class="space-y-2 mb-4">
                                <p class="text-sm text-gray-700 flex items-center">
                                    <svg class="w-4 h-4 mr-2 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                                    </svg>
                                    <%= email %>
                                </p>
                                <p class="text-sm text-gray-700 flex items-center">
                                    <svg class="w-4 h-4 mr-2 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                                    </svg>
                                    <span class="font-semibold mr-2">Département:</span> <%= departementNom %>
                                </p>
                            </div>
                            <div class="flex space-x-2">
                                <button onclick="openModalModifierDocteur(<%= docteur.getId() %>, '<%= nom.replace("'", "\\'") %>', '<%= prenom.replace("'", "\\'") %>', '<%= email.replace("'", "\\'") %>', '<%= specialite.replace("'", "\\'") %>', <%= departementId != null ? departementId : "null" %>)"
                                        class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors text-sm font-semibold">
                                    Modifier
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/docteurs" method="post" class="inline">
                                    <input type="hidden" name="action" value="supprimer">
                                    <input type="hidden" name="id" value="<%= docteur.getId() %>">
                                    <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                        </svg>
                                    </button>
                                </form>
                            </div>
                        </div>
                        <%
                                } catch (Exception cardError) {
                                    System.err.println("Erreur lors de l'affichage d'un docteur: " + cardError.getMessage());
                                    cardError.printStackTrace();
                                }
                            }
                        } else { %>
                        <div class="col-span-full">
                            <div class="text-center py-12">
                                <svg class="w-16 h-16 mx-auto mb-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                </svg>
                                <p class="text-lg font-semibold text-gray-600">Aucun docteur trouvé</p>
                                <p class="text-sm text-gray-500 mt-2">Commencez par créer votre premier docteur</p>
                            </div>
                        </div>
                        <%
                            }
                        } catch (Exception e) {
                            System.err.println("ERREUR CRITIQUE dans la section docteurs: " + e.getMessage());
                            e.printStackTrace();
                        %>
                        <div class="col-span-full bg-red-50 border-2 border-red-200 rounded-xl p-8 text-center">
                            <p class="text-red-700 font-bold text-lg mb-2">Erreur lors du chargement des docteurs</p>
                            <p class="text-red-600 text-sm"><%= e.getMessage() %></p>
                        </div>
                        <% } %>
                    </div>
                </div>
            </section>
        </div>
    </main>
</div>


<!-- Modal Salle -->
<div id="salleModal" class="modal fixed inset-0 bg-black bg-opacity-50 items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md mx-4 transform transition-all">
        <div class="bg-gradient-to-r from-green-600 to-green-500 px-6 py-4 rounded-t-2xl">
            <h3 class="text-2xl font-bold text-white" id="salleModalTitle">Ajouter une Salle</h3>
        </div>
        <form id="salleForm" action="${pageContext.request.contextPath}/admin/salles" method="post" class="p-6">
            <input type="hidden" name="action" id="salleAction" value="creer">
            <input type="hidden" name="id" id="salleId">

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Nom de la Salle</label>
                <input type="text" name="nom" id="salleNom" required
                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-green-500 focus:outline-none transition-colors"
                       placeholder="Ex: Salle 101">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Capacité</label>
                <input type="number" name="capacite" id="salleCapacite" required min="1"
                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-green-500 focus:outline-none transition-colors"
                       placeholder="Ex: 25">
            </div>

            <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2">Département</label>
                <select name="departementId" id="salleDepartementId" required
                        class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-green-500 focus:outline-none transition-colors">
                    <option value="">Sélectionner un département</option>
                    <% if (departements != null) {
                        for (Departement dep : departements) { %>
                    <option value="<%= dep.getId() %>"><%= dep.getNom() %></option>
                    <%   }
                    } %>
                </select>
            </div>

            <div class="flex space-x-4">
                <button type="submit"
                        class="flex-1 bg-gradient-to-r from-green-600 to-green-500 text-white font-bold py-3 px-6 rounded-lg hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                    Enregistrer
                </button>
                <button type="button" onclick="closeModal('salle')"
                        class="flex-1 bg-gray-200 text-gray-700 font-bold py-3 px-6 rounded-lg hover:bg-gray-300 transition-colors">
                    Annuler
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Docteur -->
<div id="docteurModal" class="modal fixed inset-0 bg-black bg-opacity-50 items-center justify-center z-50">
    <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md mx-4 transform transition-all">
        <div class="bg-gradient-to-r from-purple-600 to-purple-500 px-6 py-4 rounded-t-2xl">
            <h3 class="text-2xl font-bold text-white" id="docteurModalTitle">Ajouter un Docteur</h3>
        </div>
        <form id="docteurForm" action="${pageContext.request.contextPath}/admin/docteurs" method="post" class="p-6">
            <input type="hidden" name="action" id="docteurAction" value="creer">
            <input type="hidden" name="id" id="docteurId">

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Nom</label>
                <input type="text" name="nom" id="docteurNom" required
                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-purple-500 focus:outline-none transition-colors"
                       placeholder="Ex: Alami">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Prénom</label>
                <input type="text" name="prenom" id="docteurPrenom" required
                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-purple-500 focus:outline-none transition-colors"
                       placeholder="Ex: Ahmed">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Email</label>
                <input type="email" name="email" id="docteurEmail" required
                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-purple-500 focus:outline-none transition-colors"
                       placeholder="Ex: docteur@digitalcare.com">
            </div>

            <div id="docteurPasswordGroup" class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Mot de passe</label>
                <input type="password" name="password" id="docteurPassword" required
                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-purple-500 focus:outline-none transition-colors"
                       placeholder="••••••••">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Spécialité</label>
                <input type="text" name="specialite" id="docteurSpecialite" required
                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-purple-500 focus:outline-none transition-colors"
                       placeholder="Ex: Cardiologie">
            </div>

            <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2">Département</label>
                <select name="departementId" id="docteurDepartementId" required
                        class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:border-purple-500 focus:outline-none transition-colors">
                    <option value="">Sélectionner un département</option>
                    <% if (departements != null) {
                        for (Departement dep : departements) { %>
                    <option value="<%= dep.getId() %>"><%= dep.getNom() %></option>
                    <%   }
                    } %>
                </select>
            </div>

            <div class="flex space-x-4">
                <button type="submit"
                        class="flex-1 bg-gradient-to-r from-purple-600 to-purple-500 text-white font-bold py-3 px-6 rounded-lg hover:shadow-lg transform hover:scale-105 transition-all duration-300">
                    Enregistrer
                </button>
                <button type="button" onclick="closeModal('docteur')"
                        class="flex-1 bg-gray-200 text-gray-700 font-bold py-3 px-6 rounded-lg hover:bg-gray-300 transition-colors">
                    Annuler
                </button>
            </div>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/admin-dashboard.js"></script>
</body>
</html>