package com.clinique.service.admin.Salle;

import com.clinique.entities.Departement;
import com.clinique.entities.Salle;
import com.clinique.repository.IDepartement;
import com.clinique.repository.ISalleRepository;
import java.util.List;
import java.util.Optional;

public class SalleServiceImpl implements ISalleService {

    private ISalleRepository salleRepository;
    private IDepartement departementRepository;

    public SalleServiceImpl(ISalleRepository salleRepository, IDepartement departementRepository) {
        this.salleRepository = salleRepository;
        this.departementRepository = departementRepository;
    }

    @Override
    public Salle creerSalle(String nom, int capacite, Long departementId) throws RuntimeException {
        // Validation des données
        if (nom == null || nom.trim().isEmpty()) {
            throw new RuntimeException("Le nom de la salle est obligatoire");
        }

        if (capacite <= 0) {
            throw new RuntimeException("La capacité doit être supérieure à 0");
        }

        if (departementId == null) {
            throw new RuntimeException("L'ID du département est obligatoire");
        }

        Optional<Salle> salleExistant = salleRepository.findByNom(nom);
        if (salleExistant.isPresent()) {
            throw new RuntimeException("Une salle avec le nom '" + nom + "' existe déjà");
        }

        Optional<Departement> departement = departementRepository.findById(departementId);
        if (departement.isEmpty()) {
            throw new RuntimeException("Département non trouvé avec l'ID: " + departementId);
        }

        Salle nouvelleSalle = new Salle();
        nouvelleSalle.setNom(nom);
        nouvelleSalle.setCapacite(capacite);
        nouvelleSalle.setDepartement(departement.get());

        return salleRepository.save(nouvelleSalle);
    }

    @Override
    public Salle modifierSalle(Long id, String nom, int capacite, Long departementId) throws RuntimeException {
        if (nom == null || nom.trim().isEmpty()) {
            throw new RuntimeException("Le nom de la salle est obligatoire");
        }

        if (capacite <= 0) {
            throw new RuntimeException("La capacité doit être supérieure à 0");
        }

        if (departementId == null) {
            throw new RuntimeException("L'ID du département est obligatoire");
        }

        Optional<Salle> salleOpt = salleRepository.findById(id);
        if (salleOpt.isEmpty()) {
            throw new RuntimeException("Salle non trouvée avec l'ID: " + id);
        }

        Optional<Salle> salleAvecMemeNom = salleRepository.findByNom(nom);
        if (salleAvecMemeNom.isPresent() && !salleAvecMemeNom.get().getId().equals(id)) {
            throw new RuntimeException("Une autre salle avec le nom '" + nom + "' existe déjà");
        }

        Optional<Departement> departement = departementRepository.findById(departementId);
        if (departement.isEmpty()) {
            throw new RuntimeException("Département non trouvé avec l'ID: " + departementId);
        }

        Salle salle = salleOpt.get();
        salle.setNom(nom);
        salle.setCapacite(capacite);
        salle.setDepartement(departement.get());

        return salleRepository.update(salle);
    }

    @Override
    public void supprimerSalle(Long id) throws RuntimeException {
        Optional<Salle> salleOpt = salleRepository.findById(id);
        if (salleOpt.isEmpty()) {
            throw new RuntimeException("Salle non trouvée avec l'id : " + id);
        }

        salleRepository.delete(id);
    }

    @Override
    public Optional<Salle> trouverParId(Long id) throws RuntimeException {
        return salleRepository.findById(id);
    }

    @Override
    public Optional<Salle> trouverParNom(String nom) throws RuntimeException {
        return salleRepository.findByNom(nom);
    }

    @Override
    public List<Salle> listerToutesLesSalles() throws RuntimeException {
        return salleRepository.findAll();
    }

    @Override
    public List<Salle> listerSallesParDepartement(Long departementId) throws RuntimeException {
        Optional<Departement> departement = departementRepository.findById(departementId);
        if (departement.isEmpty()) {
            throw new RuntimeException("Département non trouvé avec l'ID: " + departementId);
        }
        return salleRepository.findByDepartementId(departementId);
    }
}