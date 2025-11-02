package com.acsi;

import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class AdmissionService {

    private final ChildService childService;

    // In-memory storage for demo purposes
    private final Map<String, Admission> admissionStore = new HashMap<>();

    public AdmissionService(ChildService childService) {
        this.childService = childService;
    }

    public Admission addAdmission(Admission admission) {
        // Link the child by ID, if child id is provided and exists
        if (admission.getChild() != null && admission.getChild().getId() != null) {
            childService.getChildById(admission.getChild().getId())
                .ifPresent(admission::setChild);
        }
        // If no ID present, generate one
        if (admission.getId() == null) {
            admission.setId(UUID.randomUUID().toString());
        }
        admissionStore.put(admission.getId(), admission);
        return admission;
    }

    public List<Admission> getAllAdmissions() {
        return new ArrayList<>(admissionStore.values());
    }

    public Optional<Admission> getAdmissionById(String id) {
        return Optional.ofNullable(admissionStore.get(id));
    }

    public Optional<Admission> updateAdmission(String id, Admission updated) {
        Admission existing = admissionStore.get(id);
        if (existing == null) {
            return Optional.empty();
        }

        // Update status or child if provided
        if (updated.getStatus() != null) {
            existing.setStatus(updated.getStatus());
        }

        if (updated.getChild() != null && updated.getChild().getId() != null) {
            childService.getChildById(updated.getChild().getId())
                .ifPresent(existing::setChild);
        }

        admissionStore.put(id, existing);
        return Optional.of(existing);
    }

    public boolean deleteAdmission(String id) {
        return admissionStore.remove(id) != null;
    }
}

