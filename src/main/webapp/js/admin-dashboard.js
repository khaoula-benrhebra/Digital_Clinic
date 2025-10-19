// ========================================
// GESTION DES MODALS UNIQUEMENT
// ========================================

function openModal(type) {
    document.getElementById(type + 'Modal').classList.add('active');
}

function closeModal(type) {
    const modal = document.getElementById(type + 'Modal');
    modal.classList.remove('active');

    // Reset form
    if (type === 'departement') {
        document.getElementById('departementForm').reset();
    } else if (type === 'salle') {
        document.getElementById('salleForm').reset();
    } else if (type === 'docteur') {
        document.getElementById('docteurForm').reset();
    }
}

// Fermer en cliquant à l'extérieur
window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        event.target.classList.remove('active');
    }
}

// ========================================
// DEPARTEMENTS
// ========================================

function openModalCreer() {
    document.getElementById('departementModalTitle').textContent = 'Ajouter un Département';
    document.getElementById('departementAction').value = 'creer';
    document.getElementById('departementId').value = '';
    document.getElementById('departementNom').value = '';
    openModal('departement');
}

function openModalModifier(id, nom) {
    document.getElementById('departementModalTitle').textContent = 'Modifier le Département';
    document.getElementById('departementAction').value = 'modifier';
    document.getElementById('departementId').value = id;
    document.getElementById('departementNom').value = nom;
    openModal('departement');
}

// ========================================
// SALLES
// ========================================

function openModalCreerSalle() {
    document.getElementById('salleModalTitle').textContent = 'Ajouter une Salle';
    document.getElementById('salleAction').value = 'creer';
    document.getElementById('salleId').value = '';
    document.getElementById('salleNom').value = '';
    document.getElementById('salleCapacite').value = '';
    document.getElementById('salleDepartementId').value = '';
    openModal('salle');
}

function openModalModifierSalle(id, nom, capacite, departementId) {
    document.getElementById('salleModalTitle').textContent = 'Modifier la Salle';
    document.getElementById('salleAction').value = 'modifier';
    document.getElementById('salleId').value = id;
    document.getElementById('salleNom').value = nom;
    document.getElementById('salleCapacite').value = capacite;
    document.getElementById('salleDepartementId').value = departementId;
    openModal('salle');
}

// ========================================
// DOCTEURS
// ========================================

function openModalCreerDocteur() {
    document.getElementById('docteurModalTitle').textContent = 'Ajouter un Docteur';
    document.getElementById('docteurAction').value = 'creer';
    document.getElementById('docteurForm').reset();
    document.getElementById('docteurPasswordGroup').style.display = 'block';
    document.getElementById('docteurPassword').required = true;
    openModal('docteur');
}

function openModalModifierDocteur(id, nom, prenom, email, specialite, departementId) {
    document.getElementById('docteurModalTitle').textContent = 'Modifier le Docteur';
    document.getElementById('docteurAction').value = 'modifier';
    document.getElementById('docteurId').value = id;
    document.getElementById('docteurNom').value = nom;
    document.getElementById('docteurPrenom').value = prenom;
    document.getElementById('docteurEmail').value = email;
    document.getElementById('docteurSpecialite').value = specialite;
    document.getElementById('docteurDepartementId').value = departementId || '';
    document.getElementById('docteurPasswordGroup').style.display = 'none';
    document.getElementById('docteurPassword').required = false;
    openModal('docteur');
}