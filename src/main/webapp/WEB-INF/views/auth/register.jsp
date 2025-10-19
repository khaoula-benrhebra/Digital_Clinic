<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - DigitalCare</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 via-blue-100 to-blue-200 min-h-screen flex items-center justify-center p-4">
<div class="w-full max-w-6xl grid md:grid-cols-2 gap-0 bg-white rounded-3xl shadow-2xl overflow-hidden">

    <!-- Left Side - Registration Form -->
    <div class="p-12 flex flex-col justify-center order-2 md:order-1">
        <div class="mb-8">
            <h3 class="text-3xl font-bold text-blue-900 mb-2">Créer votre compte</h3>
            <p class="text-gray-600">Rejoignez DigitalCare dès aujourd'hui</p>
        </div>

        <!-- Message d'erreur -->
        <% if(request.getAttribute("error") != null) { %>
        <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg">
            <div class="flex items-center">
                <svg class="w-5 h-5 text-red-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                </svg>
                <p class="text-red-700 font-semibold"><%= request.getAttribute("error") %></p>
            </div>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="POST" class="space-y-5">

            <!-- Prénom -->
            <div>
                <label for="prenom" class="block text-sm font-semibold text-blue-900 mb-2">
                    Prénom
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <input type="text"
                           id="prenom"
                           name="prenom"
                           required
                           placeholder="Jean"
                           value="<%= request.getParameter("prenom") != null ? request.getParameter("prenom") : "" %>"
                           class="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:ring-4 focus:ring-blue-100 transition-all duration-300 outline-none text-gray-700">
                </div>
            </div>

            <!-- Nom -->
            <div>
                <label for="nom" class="block text-sm font-semibold text-blue-900 mb-2">
                    Nom
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <input type="text"
                           id="nom"
                           name="nom"
                           required
                           placeholder="Dupont"
                           value="<%= request.getParameter("nom") != null ? request.getParameter("nom") : "" %>"
                           class="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:ring-4 focus:ring-blue-100 transition-all duration-300 outline-none text-gray-700">
                </div>
            </div>

            <!-- Email Input -->
            <div>
                <label for="email" class="block text-sm font-semibold text-blue-900 mb-2">
                    Adresse email
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"></path>
                        </svg>
                    </div>
                    <input type="email"
                           id="email"
                           name="email"
                           required
                           placeholder="exemple@digitalcare.com"
                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"
                           class="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:ring-4 focus:ring-blue-100 transition-all duration-300 outline-none text-gray-700">
                </div>
            </div>

            <!-- Password Input -->
            <div>
                <label for="password" class="block text-sm font-semibold text-blue-900 mb-2">
                    Mot de passe
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                        </svg>
                    </div>
                    <input type="password"
                           id="password"
                           name="password"
                           required
                           minlength="8"
                           placeholder="••••••••"
                           class="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:ring-4 focus:ring-blue-100 transition-all duration-300 outline-none text-gray-700">
                </div>
                <p class="text-xs text-gray-500 mt-2">Minimum 8 caractères</p>
            </div>

            <!-- Confirm Password -->
            <div>
                <label for="confirmPassword" class="block text-sm font-semibold text-blue-900 mb-2">
                    Confirmer le mot de passe
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                    <input type="password"
                           id="confirmPassword"
                           name="confirmPassword"
                           required
                           placeholder="••••••••"
                           class="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:ring-4 focus:ring-blue-100 transition-all duration-300 outline-none text-gray-700">
                </div>
            </div>

            <!-- Taille Input -->
            <div>
                <label for="taille" class="block text-sm font-semibold text-blue-900 mb-2">
                    Taille (cm)
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"></path>
                        </svg>
                    </div>
                    <input type="number"
                           id="taille"
                           name="taille"
                           required
                           placeholder="170"
                           min="50"
                           max="250"
                           step="0.1"
                           value="<%= request.getParameter("taille") != null ? request.getParameter("taille") : "" %>"
                           class="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:ring-4 focus:ring-blue-100 transition-all duration-300 outline-none text-gray-700">
                </div>
            </div>

            <!-- Poids Input -->
            <div>
                <label for="poids" class="block text-sm font-semibold text-blue-900 mb-2">
                    Poids (kg)
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 6l3 1m0 0l-3 9a5.002 5.002 0 006.001 0M6 7l3 9M6 7l6-2m6 2l3-1m-3 1l-3 9a5.002 5.002 0 006.001 0M18 7l3 9m-3-9l-6-2m0-2v2m0 16V5m0 16H9m3 0h3"></path>
                        </svg>
                    </div>
                    <input type="number"
                           id="poids"
                           name="poids"
                           required
                           placeholder="70"
                           min="20"
                           max="300"
                           step="0.1"
                           value="<%= request.getParameter("poids") != null ? request.getParameter("poids") : "" %>"
                           class="w-full pl-12 pr-4 py-3 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:ring-4 focus:ring-blue-100 transition-all duration-300 outline-none text-gray-700">
                </div>
            </div>

            <!-- Terms & Conditions -->
            <div class="flex items-start space-x-3">
                <input type="checkbox"
                       id="terms"
                       name="terms"
                       required
                       class="w-5 h-5 text-blue-600 border-gray-300 rounded focus:ring-blue-500 mt-1">
                <label for="terms" class="text-sm text-gray-600 leading-relaxed">
                    J'accepte les
                    <a href="#" class="text-blue-600 hover:text-blue-800 font-semibold">conditions d'utilisation</a>
                    et la
                    <a href="#" class="text-blue-600 hover:text-blue-800 font-semibold">politique de confidentialité</a>
                </label>
            </div>

            <!-- Submit Button -->
            <button type="submit"
                    class="w-full bg-gradient-to-r from-blue-900 to-blue-700 text-white font-bold py-4 rounded-xl shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300 flex items-center justify-center space-x-2">
                <span>Créer mon compte</span>
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path>
                </svg>
            </button>

            <!-- Divider -->
            <div class="relative my-6">
                <div class="absolute inset-0 flex items-center">
                    <div class="w-full border-t border-gray-300"></div>
                </div>
                <div class="relative flex justify-center text-sm">
                    <span class="px-4 bg-white text-gray-500">ou</span>
                </div>
            </div>

            <!-- Login Link -->
            <div class="text-center">
                <p class="text-gray-600">
                    Vous avez déjà un compte ?
                    <a href="${pageContext.request.contextPath}/login" class="font-bold text-blue-600 hover:text-blue-800 transition-colors">
                        Se connecter
                    </a>
                </p>
            </div>

            <!-- Back to Home -->
            <div class="text-center pt-4">
                <a href="${pageContext.request.contextPath}/" class="text-sm text-gray-500 hover:text-blue-600 transition-colors flex items-center justify-center space-x-1">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                    </svg>
                    <span>Retour à l'accueil</span>
                </a>
            </div>
        </form>
    </div>

    <!-- Right Side - Image & Info -->
    <div class="bg-gradient-to-br from-blue-900 to-blue-700 p-12 flex flex-col justify-center relative overflow-hidden order-1 md:order-2">
        <!-- Decorative Elements -->
        <div class="absolute top-0 left-0 w-64 h-64 bg-blue-800 rounded-full opacity-20 -ml-32 -mt-32"></div>
        <div class="absolute bottom-0 right-0 w-48 h-48 bg-blue-600 rounded-full opacity-20 -mr-24 -mb-24"></div>

        <div class="relative z-10">
            <!-- Logo -->
            <div class="flex items-center space-x-3 mb-8">
                <div class="w-14 h-14 bg-white rounded-xl flex items-center justify-center shadow-lg">
                    <svg class="w-8 h-8 text-blue-900" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                    </svg>
                </div>
                <h1 class="text-3xl font-bold text-white">DigitalCare</h1>
            </div>

            <h2 class="text-4xl font-bold text-white mb-6">Rejoignez notre communauté</h2>
            <p class="text-blue-100 text-lg mb-8 leading-relaxed">
                Créez votre compte gratuitement et accédez à une plateforme complète de gestion de santé digitale.
            </p>

            <!-- Benefits List -->
            <div class="space-y-4">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-blue-800 rounded-lg flex items-center justify-center flex-shrink-0">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                    </div>
                    <p class="text-blue-100">Inscription 100% gratuite et rapide</p>
                </div>
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-blue-800 rounded-lg flex items-center justify-center flex-shrink-0">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                    </div>
                    <p class="text-blue-100">Dossier médical sécurisé et confidentiel</p>
                </div>
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-blue-800 rounded-lg flex items-center justify-center flex-shrink-0">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                    </div>
                    <p class="text-blue-100">Prise de rendez-vous simplifiée</p>
                </div>
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-blue-800 rounded-lg flex items-center justify-center flex-shrink-0">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                    </div>
                    <p class="text-blue-100">Support médical 24/7</p>
                </div>
            </div>

            <!-- Stats -->
            <div class="grid grid-cols-2 gap-6 mt-12 pt-8 border-t border-blue-800">
                <div>
                    <p class="text-4xl font-bold text-white mb-1">25K+</p>
                    <p class="text-blue-200 text-sm">Utilisateurs actifs</p>
                </div>
                <div>
                    <p class="text-4xl font-bold text-white mb-1">500+</p>
                    <p class="text-blue-200 text-sm">Médecins partenaires</p>
                </div>
            </div>

            <!-- Medical Cross Icon -->
            <div class="mt-12 opacity-10">
                <svg class="w-48 h-48" fill="currentColor" class="text-white" viewBox="0 0 24 24">
                    <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1 11h-4v4h-4v-4H6v-4h4V6h4v4h4v4z"/>
                </svg>
            </div>
        </div>
    </div>
</div>
</body>
</html>