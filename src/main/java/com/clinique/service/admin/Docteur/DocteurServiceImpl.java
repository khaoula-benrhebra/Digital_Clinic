package com.clinique.service.admin.Docteur;

import com.clinique.entities.Departement;
import com.clinique.entities.Docteur;
import com.clinique.entities.enums.Role;
import com.clinique.repository.IDepartement;
import com.clinique.repository.IDocteur;
import java.util.List;
import java.util.Optional;

public class DocteurServiceImpl implements IDocteurService {

    private IDocteur docteurRepository;
    private IDepartement departementRepository;

    public DocteurServiceImpl(IDocteur docteurRepository, IDepartement departementRepository) {
        this.docteurRepository = docteurRepository;
        this.departementRepository = departementRepository;
    }

    @Override
    public Docteur creerDocteur(String nom, String prenom, String email, String password,
                                String specialite, Long departementId) throws RuntimeException {
        // Validation des données
        if (nom == null || nom.trim().isEmpty()) {
            throw new RuntimeException("Le nom du docteur est obligatoire");
        }

        if (prenom == null || prenom.trim().isEmpty()) {
            throw new RuntimeException("Le prénom du docteur est obligatoire");
        }

        if (email == null || email.trim().isEmpty()) {
            throw new RuntimeException("L'email du docteur est obligatoire");
        }

        if (password == null || password.trim().isEmpty()) {
            throw new RuntimeException("Le mot de passe du docteur est obligatoire");
        }

        if (specialite == null || specialite.trim().isEmpty()) {
            throw new RuntimeException("La spécialité du docteur est obligatoire");
        }

        if (departementId == null) {
            throw new RuntimeException("L'ID du département est obligatoire");
        }

        // Vérifier si un docteur avec le même email existe déjà
        Optional<Docteur> docteurExistant = docteurRepository.findByEmail(email);
        if (docteurExistant.isPresent()) {
            throw new RuntimeException("Un docteur avec l'email '" + email + "' existe déjà");
        }

        // Vérifier si le département existe
        Optional<Departement> departement = departementRepository.findById(departementId);
        if (departement.isEmpty()) {
            throw new RuntimeException("Département non trouvé avec l'ID: " + departementId);
        }

        // Créer le nouveau docteur
        Docteur nouveauDocteur = new Docteur();
        nouveauDocteur.setNom(nom);
        nouveauDocteur.setPrenom(prenom);
        nouveauDocteur.setEmail(email);
        nouveauDocteur.setPassword(password);
        nouveauDocteur.setRole(Role.DOCTEUR);
        nouveauDocteur.setSpecialite(specialite);
        nouveauDocteur.setDepartement(departement.get());

        return docteurRepository.save(nouveauDocteur);
    }

    @Override
    public Docteur modifierDocteur(Long id, String nom, String prenom, String email,
                                   String specialite, Long departementId) throws RuntimeException {
        // Validation des données
        if (nom == null || nom.trim().isEmpty()) {
            throw new RuntimeException("Le nom du docteur est obligatoire");
        }

        if (prenom == null || prenom.trim().isEmpty()) {
            throw new RuntimeException("Le prénom du docteur est obligatoire");
        }

        if (email == null || email.trim().isEmpty()) {
            throw new RuntimeException("L'email du docteur est obligatoire");
        }

        if (specialite == null || specialite.trim().isEmpty()) {
            throw new RuntimeException("La spécialité du docteur est obligatoire");
        }

        if (departementId == null) {
            throw new RuntimeException("L'ID du département est obligatoire");
        }

        // Vérifier si le docteur existe
        Optional<Docteur> docteurOpt = docteurRepository.findById(id);
        if (docteurOpt.isEmpty()) {
            throw new RuntimeException("Docteur non trouvé avec l'ID: " + id);
        }

        // Vérifier si un autre docteur avec le même email existe déjà
        Optional<Docteur> docteurAvecMemeEmail = docteurRepository.findByEmail(email);
        if (docteurAvecMemeEmail.isPresent() && !docteurAvecMemeEmail.get().getId().equals(id)) {
            throw new RuntimeException("Un autre docteur avec l'email '" + email + "' existe déjà");
        }

        // Vérifier si le département existe
        Optional<Departement> departement = departementRepository.findById(departementId);
        if (departement.isEmpty()) {
            throw new RuntimeException("Département non trouvé avec l'ID: " + departementId);
        }

        // Modifier le docteur
        Docteur docteur = docteurOpt.get();
        docteur.setNom(nom);
        docteur.setPrenom(prenom);
        docteur.setEmail(email);
        docteur.setSpecialite(specialite);
        docteur.setDepartement(departement.get());

        return docteurRepository.update(docteur);
    }

    @Override
    public void supprimerDocteur(Long id) throws RuntimeException {
        // Vérifier si le docteur existe
        Optional<Docteur> docteurOpt = docteurRepository.findById(id);
        if (docteurOpt.isEmpty()) {
            throw new RuntimeException("Docteur non trouvé avec l'id : " + id);
        }

        // La suppression avec vérification des consultations se fait dans le repository
        docteurRepository.delete(id);
    }

    @Override
    public Optional<Docteur> trouverParId(Long id) throws RuntimeException {
        return docteurRepository.findById(id);
    }

    @Override
    public Optional<Docteur> trouverParEmail(String email) throws RuntimeException {
        return docteurRepository.findByEmail(email);
    }

    @Override
    public List<Docteur> listerTousLesDocteurs() throws RuntimeException {
        return docteurRepository.findAll();
    }

    @Override
    public List<Docteur> listerDocteursParDepartement(Long departementId) throws RuntimeException {
        // Pour l'instant, on récupère tous les docteurs et on filtre
        List<Docteur> tousLesDocteurs = docteurRepository.findAll();
        return tousLesDocteurs.stream()
                .filter(docteur -> docteur.getDepartement() != null &&
                        docteur.getDepartement().getId().equals(departementId))
                .toList();
    }

    @Override
    public void attacherDocteurAuDepartement(Long docteurId, Long departementId) throws RuntimeException {
        // Vérifier si le docteur existe
        Optional<Docteur> docteurOpt = docteurRepository.findById(docteurId);
        if (docteurOpt.isEmpty()) {
            throw new RuntimeException("Docteur non trouvé avec l'ID: " + docteurId);
        }

        // Vérifier si le département existe
        Optional<Departement> departementOpt = departementRepository.findById(departementId);
        if (departementOpt.isEmpty()) {
            throw new RuntimeException("Département non trouvé avec l'ID: " + departementId);
        }

        // Attacher le docteur au département
        Docteur docteur = docteurOpt.get();
        docteurRepository.attacherDocteur(departementId, docteur);
    }
}