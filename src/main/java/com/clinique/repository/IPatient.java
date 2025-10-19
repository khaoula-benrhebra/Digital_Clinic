package com.clinique.repository;

import com.clinique.entities.Patient;
import java.util.List;
import java.util.Optional;

public interface IPatient {

    Patient save(Patient patient) throws RuntimeException;

    Patient update(Patient patient) throws RuntimeException;

    void delete(Long id) throws RuntimeException;

    Optional<Patient> findById(Long id) throws RuntimeException;

    Optional<Patient> findByEmail(String email) throws RuntimeException;

    List<Patient> findAll() throws RuntimeException;
}