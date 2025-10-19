<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DigitalCare - Votre santé digitalisée</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-blue-100">
<!-- Navigation -->
<nav class="bg-white shadow-lg sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-20">
            <!-- Logo -->
            <div class="flex items-center space-x-3">
                <div class="relative">
                    <div class="w-12 h-12 bg-gradient-to-br from-blue-900 to-blue-700 rounded-xl flex items-center justify-center transform rotate-3 shadow-lg">
                        <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                        </svg>
                    </div>
                </div>
                <div>
                    <h1 class="text-2xl font-bold text-blue-900">Digital<span class="text-blue-600">Care</span></h1>
                    <p class="text-xs text-gray-500 -mt-1">Santé Connectée</p>
                </div>
            </div>

            <!-- Navigation Links -->
            <div class="flex space-x-4">
                <a href="${pageContext.request.contextPath}/login" class="px-6 py-2.5 text-blue-900 font-semibold hover:text-blue-600 transition-all duration-300 hover:scale-105">
                    Connexion
                </a>
                <a href="${pageContext.request.contextPath}/register" class="px-6 py-2.5 bg-gradient-to-r from-blue-900 to-blue-700 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                    Inscription
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="py-20 px-4">
    <div class="max-w-7xl mx-auto">
        <div class="grid md:grid-cols-2 gap-12 items-center">
            <!-- Left Content -->
            <div class="space-y-6">
                <div class="inline-block">
                        <span class="bg-blue-100 text-blue-900 px-4 py-2 rounded-full text-sm font-semibold">
                            🏥 Plateforme de Santé Digitale
                        </span>
                </div>
                <h1 class="text-5xl md:text-6xl font-bold text-blue-900 leading-tight">
                    Votre santé, <br/>
                    <span class="text-blue-600">notre priorité</span>
                </h1>
                <p class="text-lg text-gray-600 leading-relaxed">
                    DigitalCare révolutionne votre expérience de santé avec une plateforme moderne, sécurisée et intuitive.
                    Gérez vos rendez-vous, consultations et dossiers médicaux en toute simplicité.
                </p>
                <div class="flex space-x-4 pt-4">
                    <a href="${pageContext.request.contextPath}/register" class="px-8 py-4 bg-gradient-to-r from-blue-900 to-blue-700 text-white font-bold rounded-lg shadow-xl hover:shadow-2xl transform hover:scale-105 transition-all duration-300">
                        Commencer Gratuitement
                    </a>
                    <a href="#features" class="px-8 py-4 bg-white text-blue-900 font-bold rounded-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                        En savoir plus
                    </a>
                </div>
            </div>

            <!-- Right Image -->
            <div class="relative">
                <div class="absolute inset-0 bg-gradient-to-r from-blue-900 to-blue-600 rounded-3xl transform rotate-3 opacity-20"></div>
                <div class="relative bg-white rounded-3xl shadow-2xl p-8 transform hover:scale-105 transition-all duration-500">
                    <img src="https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800"
                         alt="Médecin professionnel"
                         class="rounded-2xl w-full h-96 object-cover shadow-lg">
                    <div class="absolute -bottom-6 -left-6 bg-white rounded-2xl shadow-xl p-4 flex items-center space-x-3">
                        <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                        </div>
                        <div>
                            <p class="text-2xl font-bold text-blue-900">98%</p>
                            <p class="text-sm text-gray-600">Satisfaction</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section id="features" class="py-20 px-4 bg-white">
    <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
            <h2 class="text-4xl font-bold text-blue-900 mb-4">Pourquoi choisir DigitalCare ?</h2>
            <p class="text-lg text-gray-600">Une solution complète pour gérer votre santé au quotidien</p>
        </div>

        <div class="grid md:grid-cols-3 gap-8">
            <!-- Feature 1 -->
            <div class="bg-gradient-to-br from-blue-50 to-blue-100 rounded-2xl p-8 hover:shadow-2xl transform hover:scale-105 transition-all duration-300">
                <div class="w-16 h-16 bg-gradient-to-br from-blue-900 to-blue-700 rounded-2xl flex items-center justify-center mb-6 shadow-lg">
                    <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                </div>
                <h3 class="text-2xl font-bold text-blue-900 mb-4">Rendez-vous en ligne</h3>
                <p class="text-gray-600">Prenez rendez-vous avec vos médecins en quelques clics, 24h/24 et 7j/7.</p>
            </div>

            <!-- Feature 2 -->
            <div class="bg-gradient-to-br from-blue-50 to-blue-100 rounded-2xl p-8 hover:shadow-2xl transform hover:scale-105 transition-all duration-300">
                <div class="w-16 h-16 bg-gradient-to-br from-blue-900 to-blue-700 rounded-2xl flex items-center justify-center mb-6 shadow-lg">
                    <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                </div>
                <h3 class="text-2xl font-bold text-blue-900 mb-4">Dossier médical</h3>
                <p class="text-gray-600">Accédez à votre historique médical complet de manière sécurisée.</p>
            </div>

            <!-- Feature 3 -->
            <div class="bg-gradient-to-br from-blue-50 to-blue-100 rounded-2xl p-8 hover:shadow-2xl transform hover:scale-105 transition-all duration-300">
                <div class="w-16 h-16 bg-gradient-to-br from-blue-900 to-blue-700 rounded-2xl flex items-center justify-center mb-6 shadow-lg">
                    <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                    </svg>
                </div>
                <h3 class="text-2xl font-bold text-blue-900 mb-4">Suivi personnalisé</h3>
                <p class="text-gray-600">Bénéficiez d'un suivi médical adapté à vos besoins spécifiques.</p>
            </div>
        </div>
    </div>
</section>

<!-- Health Tips Section -->
<section class="py-20 px-4 bg-gradient-to-br from-blue-50 to-white">
    <div class="max-w-7xl mx-auto">
        <div class="text-center mb-16">
                <span class="bg-blue-100 text-blue-900 px-4 py-2 rounded-full text-sm font-semibold">
                    💡 Conseils Santé
                </span>
            <h2 class="text-4xl font-bold text-blue-900 mt-6 mb-4">Nos recommandations pour votre bien-être</h2>
            <p class="text-lg text-gray-600 max-w-2xl mx-auto">
                Découvrez nos conseils d'experts pour maintenir une santé optimale au quotidien
            </p>
        </div>

        <div class="grid md:grid-cols-3 gap-8">
            <!-- Conseil 1 - Nutrition -->
            <div class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2">
                <div class="relative h-56 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=800"
                         alt="Alimentation saine"
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-blue-900/80 to-transparent"></div>
                    <div class="absolute bottom-4 left-4">
                            <span class="bg-blue-500 text-white px-3 py-1 rounded-full text-sm font-semibold">
                                Nutrition
                            </span>
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-xl font-bold text-blue-900 mb-3">Alimentation équilibrée</h3>
                    <p class="text-gray-600 mb-4 leading-relaxed">
                        Adoptez une alimentation riche en fruits, légumes et protéines. Évitez les aliments ultra-transformés et privilégiez les produits frais.
                    </p>
                    <a href="#" class="inline-flex items-center text-blue-600 font-semibold hover:text-blue-800 transition-colors">
                        En savoir plus
                        <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                </div>
            </div>

            <!-- Conseil 2 - Exercice -->
            <div class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2">
                <div class="relative h-56 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=800"
                         alt="Exercice physique"
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-blue-900/80 to-transparent"></div>
                    <div class="absolute bottom-4 left-4">
                            <span class="bg-green-500 text-white px-3 py-1 rounded-full text-sm font-semibold">
                                Activité physique
                            </span>
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-xl font-bold text-blue-900 mb-3">Restez actif</h3>
                    <p class="text-gray-600 mb-4 leading-relaxed">
                        Pratiquez au moins 30 minutes d'exercice par jour. La marche, le yoga ou la course amélioreront votre santé cardiovasculaire.
                    </p>
                    <a href="#" class="inline-flex items-center text-blue-600 font-semibold hover:text-blue-800 transition-colors">
                        En savoir plus
                        <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                </div>
            </div>

            <!-- Conseil 3 - Sommeil -->
            <div class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2">
                <div class="relative h-56 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?w=800"
                         alt="Sommeil de qualité"
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-blue-900/80 to-transparent"></div>
                    <div class="absolute bottom-4 left-4">
                            <span class="bg-purple-500 text-white px-3 py-1 rounded-full text-sm font-semibold">
                                Bien-être
                            </span>
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-xl font-bold text-blue-900 mb-3">Sommeil réparateur</h3>
                    <p class="text-gray-600 mb-4 leading-relaxed">
                        Dormez 7 à 8 heures par nuit. Un bon sommeil renforce votre système immunitaire et améliore votre concentration.
                    </p>
                    <a href="#" class="inline-flex items-center text-blue-600 font-semibold hover:text-blue-800 transition-colors">
                        En savoir plus
                        <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                </div>
            </div>

            <!-- Conseil 4 - Hydratation -->
            <div class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2">
                <div class="relative h-56 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1548839140-29a749e1cf4d?w=800"
                         alt="Hydratation"
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-blue-900/80 to-transparent"></div>
                    <div class="absolute bottom-4 left-4">
                            <span class="bg-cyan-500 text-white px-3 py-1 rounded-full text-sm font-semibold">
                                Hydratation
                            </span>
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-xl font-bold text-blue-900 mb-3">Buvez suffisamment</h3>
                    <p class="text-gray-600 mb-4 leading-relaxed">
                        Consommez au moins 1,5 à 2 litres d'eau par jour. Une bonne hydratation est essentielle pour votre organisme.
                    </p>
                    <a href="#" class="inline-flex items-center text-blue-600 font-semibold hover:text-blue-800 transition-colors">
                        En savoir plus
                        <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                </div>
            </div>

            <!-- Conseil 5 - Prévention -->
            <div class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2">
                <div class="relative h-56 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1631217868264-e5b90bb7e133?w=800"
                         alt="Consultation médicale"
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-blue-900/80 to-transparent"></div>
                    <div class="absolute bottom-4 left-4">
                            <span class="bg-red-500 text-white px-3 py-1 rounded-full text-sm font-semibold">
                                Prévention
                            </span>
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-xl font-bold text-blue-900 mb-3">Consultations régulières</h3>
                    <p class="text-gray-600 mb-4 leading-relaxed">
                        Effectuez un bilan de santé annuel. La prévention est la clé pour détecter et traiter les problèmes à temps.
                    </p>
                    <a href="#" class="inline-flex items-center text-blue-600 font-semibold hover:text-blue-800 transition-colors">
                        En savoir plus
                        <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                </div>
            </div>

            <!-- Conseil 6 - Santé mentale -->
            <div class="group bg-white rounded-2xl overflow-hidden shadow-lg hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2">
                <div class="relative h-56 overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800"
                         alt="Santé mentale"
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-blue-900/80 to-transparent"></div>
                    <div class="absolute bottom-4 left-4">
                            <span class="bg-pink-500 text-white px-3 py-1 rounded-full text-sm font-semibold">
                                Santé mentale
                            </span>
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-xl font-bold text-blue-900 mb-3">Prenez soin de vous</h3>
                    <p class="text-gray-600 mb-4 leading-relaxed">
                        Pratiquez la méditation et prenez du temps pour vous. Votre santé mentale est tout aussi importante que votre santé physique.
                    </p>
                    <a href="#" class="inline-flex items-center text-blue-600 font-semibold hover:text-blue-800 transition-colors">
                        En savoir plus
                        <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="py-20 px-4 bg-gradient-to-r from-blue-900 to-blue-700">
    <div class="max-w-7xl mx-auto">
        <div class="grid md:grid-cols-4 gap-8 text-center text-white">
            <div class="transform hover:scale-110 transition-all duration-300">
                <p class="text-5xl font-bold mb-2">25K+</p>
                <p class="text-blue-200">Patients actifs</p>
            </div>
            <div class="transform hover:scale-110 transition-all duration-300">
                <p class="text-5xl font-bold mb-2">500+</p>
                <p class="text-blue-200">Médecins partenaires</p>
            </div>
            <div class="transform hover:scale-110 transition-all duration-300">
                <p class="text-5xl font-bold mb-2">50K+</p>
                <p class="text-blue-200">Consultations réussies</p>
            </div>
            <div class="transform hover:scale-110 transition-all duration-300">
                <p class="text-5xl font-bold mb-2">98%</p>
                <p class="text-blue-200">Taux de satisfaction</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-blue-900 text-white py-12 px-4">
    <div class="max-w-7xl mx-auto text-center">
        <div class="flex items-center justify-center space-x-3 mb-6">
            <div class="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
                <svg class="w-6 h-6 text-blue-900" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                </svg>
            </div>
            <h3 class="text-2xl font-bold">DigitalCare</h3>
        </div>
        <p class="text-blue-200 mb-4">Votre santé, notre engagement</p>
        <p class="text-blue-300 text-sm">© 2025 DigitalCare. Tous droits réservés.</p>
    </div>
</footer>
</body>
</html>