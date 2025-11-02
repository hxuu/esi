package com.acsi;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.Map;
import java.util.Set;

@RestController
@CrossOrigin(origins = "*") // allow all origins (adjust for production)
@RequestMapping("/api/auth")
public class AuthController {

    private final InMemoryUserDetailsManager userDetailsManager;

    private static final Set<String> ALLOWED_ROLES = Set.of("ADMIN", "USER", "EDUCATOR", "PARENT");

    public AuthController(InMemoryUserDetailsManager userDetailsManager) {
        this.userDetailsManager = userDetailsManager;
    }

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody Map<String, String> payload) {
        String username = payload.get("username");
        String password = payload.get("password");
        String role = payload.getOrDefault("role", "USER").toUpperCase();

        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            return ResponseEntity.badRequest().body("Username and password must be provided.");
        }

        if (!ALLOWED_ROLES.contains(role)) {
            return ResponseEntity.badRequest().body("Invalid role. Allowed: " + ALLOWED_ROLES);
        }

        if (userDetailsManager.userExists(username)) {
            return ResponseEntity.badRequest().body("User already exists.");
        }

        UserDetails user = User.withDefaultPasswordEncoder()
                .username(username)
                .password(password)
                .roles(role)
                .build();

        userDetailsManager.createUser(user);
        return ResponseEntity.ok("User '" + username + "' registered successfully with role '" + role + "'.");
    }
}

