package com.acsi;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    private final InMemoryUserDetailsManager userDetailsManager = new InMemoryUserDetailsManager();

    @Bean
    public InMemoryUserDetailsManager userDetailsService() {
        // Optional: default user user
        UserDetails user = User.withDefaultPasswordEncoder()
                .username("user")
                .password("user123")
                .roles("user")
                .build();
        userDetailsManager.createUser(user);
        return userDetailsManager;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/auth/signup").permitAll()
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/educator/**").hasRole("EDUCATOR")
                .requestMatchers("/parent/**").hasRole("PARENT")
                .anyRequest().authenticated()
            )
            .httpBasic();

        return http.build();
    }
}

