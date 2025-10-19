<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - DigitalCare</title>
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

    <!-- Left Side - Image & Info -->
    <div class="bg-gradient-to-br from-blue-900 to-blue-700 p-12 flex flex-col justify-center relative overflow-hidden">
        <!-- Decorative Elements -->
        <div class="absolute top-0 right-0 w-64 h-64 bg-blue-800 rounded-full opacity-20 -mr-32 -mt-32"></div>
        <div class="absolute bottom-0 left-0 w-48 h-48 bg-blue-600 rounded-full opacity-20 -ml-24 -mb-24"></div>

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

            <h2 class="text-4xl font-bold text-white mb-6">Bon retour parmi nous !</h2>
            <p class="text-blue-100 text-lg mb-8 leading-relaxed">
                Connectez-vous pour accéder à votre espace personnel et gérer vos rendez-vous médicaux en toute sécurité.
            </p>

            <!-- Features List -->
            <div class="space-y-4">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-blue-800 rounded-lg flex items-center justify-center">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                    </div>
                    <p class="text-blue-100">Accès sécurisé 24/7</p>
                </div>
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-blue-800 rounded-lg flex items-center justify-center">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                    </div>
                    <p class="text-blue-100">Gestion complète de vos dossiers</p>
                </div>
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-blue-800 rounded-lg flex items-center justify-center">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                    </div>
                    <p class="text-blue-100">Support médical instantané</p>
                </div>
            </div>

            <!-- Medical Icon -->
            <div class="mt-12 opacity-20">
                <svg class="w-64 h-64" fill="currentColor" class="text-white" viewBox="0 0 24 24">
                    <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-1 11h-4v4h-4v-4H6v-4h4V6h4v4h4v4z"/>
                </svg>
            </div>
        </div>
    </div>

    <!-- Right Side - Login Form -->
    <div class="p-12 flex flex-col justify-center">
        <div class="mb-8">
            <h3 class="text-3xl font-bold text-blue-900 mb-2">Connexion</h3>
            <p class="text-gray-600">Entrez vos identifiants pour continuer</p>
        </div>

        <form action="login" method="POST" class="space-y-6">

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
                           value="${param.email}"
                           id="email"
                           name="email"
                           required
                           placeholder="exemple@digitalcare.com"
                           class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:ring-4 focus:ring-blue-100 transition-all duration-300 outline-none text-gray-700">
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
                           placeholder="••••••••"
                           class="w-full pl-12 pr-4 py-3.5 border-2 border-gray-200 rounded-xl focus:border-blue-500 focus:ring-4 focus:ring-blue-100 transition-all duration-300 outline-none text-gray-700">
                </div>
            </div>

            <!-- Remember Me & Forgot Password -->
            <div class="flex items-center justify-between">
                <label class="flex items-center space-x-2 cursor-pointer">
                    <input type="checkbox"
                           name="remember"
                           class="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500">
                    <span class="text-sm text-gray-600">Se souvenir de moi</span>
                </label>
                <a href="#" class="text-sm font-semibold text-blue-600 hover:text-blue-800 transition-colors">
                    Mot de passe oublié ?
                </a>
            </div>

            <!-- Submit Button -->
            <button type="submit"
                    class="w-full bg-gradient-to-r from-blue-900 to-blue-700 text-white font-bold py-4 rounded-xl shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300 flex items-center justify-center space-x-2">
                <span>Se connecter</span>
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

            <!-- Register Link -->
            <div class="text-center">
                <p class="text-gray-600">
                    Vous n'avez pas de compte ?
                    <a href="register.jsp" class="font-bold text-blue-600 hover:text-blue-800 transition-colors">
                        Créer un compte
                    </a>
                </p>
            </div>

            <!-- Back to Home -->
            <div class="text-center pt-4">
                <a href="home.jsp" class="text-sm text-gray-500 hover:text-blue-600 transition-colors flex items-center justify-center space-x-1">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                    </svg>
                    <span>Retour à l'accueil</span>
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>