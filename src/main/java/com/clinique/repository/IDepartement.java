package com.clinique.repository;

import com.clinique.entities.Departement;

import java.util.List;
import java.util.Optional;

public interface IDepartement {

Departement save (Departement departement) throws RuntimeException;
Departement update(Departement departement) throws  RuntimeException;
void delete(Long id) throws RuntimeException;


Optional<Departement> findById(Long id) throws RuntimeException;
Optional<Departement> findByNom(String nom) throws RuntimeException;
List<Departement> findAll() throws RuntimeException;

List<Departement> findAllWithDocteurs() throws RuntimeException;



}
