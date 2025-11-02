package com.acsi;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@RestController
@CrossOrigin(origins = "*") // allow all origins (adjust for production)
@RequestMapping("/api/children")
public class ChildController {

    private final ChildService childService;

    public ChildController(ChildService childService) {
        this.childService = childService;
    }

    @PostMapping
    public ResponseEntity<?> createChild(@RequestBody Child child) {
        Child savedChild = childService.addChild(child);
        return ResponseEntity.ok(child);
    }

    @GetMapping
    public ResponseEntity<?> listChildren() {
        List<Child> children = childService.getAllChildren();
        if (children.isEmpty()) {
            return ResponseEntity.ok("No children found.");
        }
        return ResponseEntity.ok(children);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getChild(@PathVariable String id) {
        return childService.getChildById(id)
                .<ResponseEntity<?>>map(child -> ResponseEntity.ok().body(child))
                .orElse(ResponseEntity.status(404).body("Child not found with ID: " + id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateChild(@PathVariable String id, @RequestBody Child updated) {
        return childService.updateChild(id, updated)
                .<ResponseEntity<?>>map(child -> ResponseEntity.ok("Child updated successfully."))
                .orElse(ResponseEntity.status(404).body("Failed to update. Child not found with ID: " + id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteChild(@PathVariable String id) {
        if (childService.deleteChild(id)) {
            return ResponseEntity.ok("Child deleted successfully with ID: " + id);
        }
        return ResponseEntity.status(404).body("Failed to delete. Child not found with ID: " + id);
    }
}

