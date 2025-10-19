package com.clinique.repository;

import com.clinique.entities.Docteur;

import java.util.List;
import java.util.Optional;

public interface IDocteur {
    Docteur save(Docteur docteur);
    Docteur update(Docteur docteur);
    void delete(Long id);
    Optional<Docteur> findById(Long id);
    List<Docteur> findAll();
    Optional<Docteur> findByEmail(String email);
    void attacherDocteur(Long departementId , Docteur docteur) throws  RuntimeException;
}
