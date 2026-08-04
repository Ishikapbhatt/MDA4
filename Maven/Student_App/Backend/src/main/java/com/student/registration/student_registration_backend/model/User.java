package com.student.registration.student_registration_backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "students")
@Data // This annotation from Lombok automatically generates getters, setters, and other methods.
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "course")
    private String course;

    @Column(name = "student_class")
    private String studentClass;

    @Column(name = "percentage")
    private Double percentage;

    @Column(name = "branch")
    private String branch;

    @Column(name = "mobile_number")
    private String mobileNumber;
}
