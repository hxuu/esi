package com.acsi;

import java.util.UUID;

public class Admission {
    private String id;
    private Child child;
    private AdmissionStatus status;

    public Admission() {
        this.id = UUID.randomUUID().toString();
        this.status = AdmissionStatus.WAITING;
    }

    public Admission(Child child) {
        this();
        this.child = child;
    }

    // Getters and setters

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Child getChild() {
        return child;
    }

    public void setChild(Child child) {
        this.child = child;
    }

    public AdmissionStatus getStatus() {
        return status;
    }

    public void setStatus(AdmissionStatus status) {
        this.status = status;
    }

    public enum AdmissionStatus {
        WAITING,
        VALIDATED,
        REJECTED
    }
}

