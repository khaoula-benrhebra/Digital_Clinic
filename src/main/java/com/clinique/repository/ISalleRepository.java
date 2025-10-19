package com.clinique.repository;

import com.clinique.entities.Salle;

import java.util.List;
import java.util.Optional;

public interface ISalleRepository {
    Salle save(Salle salle);
    Salle update(Salle salle);
    void delete(Long id);
    Optional<Salle> findById(Long id);
    List<Salle> findAll();
    Optional<Salle> findByNom(String nom);
    List<Salle> findByDepartementId(Long departementId);
}
