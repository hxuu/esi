package com.acsi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;

@SpringBootApplication
public class AcsiApplication {
    public static void main(String[] args) {
        SpringApplication.run(AcsiApplication.class, args);
    }

    @RestController
    @CrossOrigin(origins = "*") // allow all origins (adjust for production)

    class RoleController {

        @GetMapping("/")
        public String home() {
            return "Welcome to the Crèche Management System";
        }

        @GetMapping("/admin/dashboard")
        public String admin() {
            return "Admin Dashboard";
        }

        @GetMapping("/educator/dashboard")
        public String educator() {
            return "Educator Dashboard";
        }

        @GetMapping("/parent/dashboard")
        public String parent() {
            return "Parent Dashboard";
        }
    }
}
