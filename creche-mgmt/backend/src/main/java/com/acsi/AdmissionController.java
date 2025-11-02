package com.acsi;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;


import java.util.List;

@RestController
@CrossOrigin(origins = "*") // allow all origins (adjust for production)
@RequestMapping("/api/admissions")
public class AdmissionController {

    private final AdmissionService admissionService;

    public AdmissionController(AdmissionService admissionService) {
        this.admissionService = admissionService;
    }

    @PostMapping
    public ResponseEntity<Admission> createAdmission(@RequestBody Admission admission) {
        Admission created = admissionService.addAdmission(admission);
        return ResponseEntity.ok(created);
    }

    @GetMapping
    public List<Admission> getAllAdmissions() {
        return admissionService.getAllAdmissions();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Admission> getAdmissionById(@PathVariable String id) {
        return admissionService.getAdmissionById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Admission> updateAdmission(@PathVariable String id, @RequestBody Admission updated) {
        return admissionService.updateAdmission(id, updated)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAdmission(@PathVariable String id) {
        if (admissionService.deleteAdmission(id)) {
            return ResponseEntity.ok("Admission deleted.");
        }
        return ResponseEntity.notFound().build();
    }
}

