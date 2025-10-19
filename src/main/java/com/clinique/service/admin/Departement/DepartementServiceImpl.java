package com.clinique.service.admin.Departement;

import com.clinique.entities.Departement;
import com.clinique.repository.IDepartement;

import java.util.List;
import java.util.Optional;

public class DepartementServiceImpl implements IDepartementService {

    private IDepartement departementRepository;

    public DepartementServiceImpl(IDepartement departementRepository) {
        this.departementRepository = departementRepository;
    }

        @Override
    public Departement creerDepartement(String nom) throws RuntimeException {
                if (nom == null || nom.trim().isEmpty()) {
                    throw new RuntimeException("Le nom du département est obligatoire");
                }

                Optional<Departement> departementExistant = departementRepository.findByNom(nom);
                if (departementExistant.isPresent()) {
                    throw new RuntimeException("Un département avec le nom '" + nom + "' existe déjà");
                }

                Departement nouveauDepartement = new Departement(nom);
                return departementRepository.save(nouveauDepartement);
    }

    @Override
    public Departement modifierDepartement(Long id, String nouveauNom) throws RuntimeException {
        if (nouveauNom == null || nouveauNom.trim().isEmpty()) {
            throw new RuntimeException("Le nouveau nom du département est obligatoire");
        }

        Optional<Departement> departementOpt = departementRepository.findById(id);
        if (departementOpt.isEmpty()) {
            throw new RuntimeException("Département non trouvé avec l'ID: " + id);
        }
        Optional<Departement> departementAvecMemeNom = departementRepository.findByNom(nouveauNom);
        if (departementAvecMemeNom.isPresent() && !departementAvecMemeNom.get().getId().equals(id)) {
            throw new RuntimeException("Un autre département avec le nom '" + nouveauNom + "' existe déjà");
        }

        Departement departement = departementOpt.get();
        departement.setNom(nouveauNom);

        return departementRepository.update(departement);
    }

    @Override
    public void supprimerDepartement(Long id) throws RuntimeException {
        Optional<Departement> departementOpt = departementRepository.findById(id);
        if (departementOpt.isEmpty()) {
            throw new RuntimeException("Département non trouvé avec l'id : " + id);
        }

        // La vérification des docteurs est maintenant faite dans le repository
        departementRepository.delete(id);
    }

    @Override
    public Optional<Departement> trouverParId(Long id) throws RuntimeException {
        return departementRepository.findById(id);
    }

    @Override
    public Optional<Departement> trouverParNom(String nom) throws RuntimeException {
        return departementRepository.findByNom(nom);
    }

    @Override
    public List<Departement> listerTousLesDepartements() throws RuntimeException {
        return departementRepository.findAll();
    }

    @Override
    public List<Departement> listerDepartementsAvecDocteurs() throws RuntimeException {
        return departementRepository.findAllWithDocteurs();
    }
}
