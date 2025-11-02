# Crèche Management System

A Spring Boot application for managing a crèche (nursery school), including features for user authentication, child profile management, and admissions handling (waiting list and validation of new enrollments).

## 🚀 Features

* **User Authentication**

  * Role-based login using HTTP Basic Authentication
  * Roles: Administrator, Educator, Kitchen Staff, Parent

* **Child Profile Management**

  * Add, view, update, and delete child profiles
  * Store details such as date of birth, allergies, special needs, and parent contact info

* **Admission Management**

  * Create and validate new child admissions
  * Maintain a waiting list for pending admissions

## 🛠 Technologies

* Java 17
* Spring Boot
* Spring Security
* Maven
* In-memory H2 database (for development/testing)

## 📂 Project Structure

```
src/main/java/com/acsi/
│
├── AcsiApplication.java          // Entry point
├── SecurityConfig.java           // Security configuration
│
├── AuthController.java           // Signup/login
├── Child.java                    // Child entity
├── ChildController.java          // REST API for children
├── ChildService.java             // Business logic for children
│
├── Admission.java                // Admission entity
├── AdmissionController.java      // REST API for admissions
├── AdmissionService.java         // Business logic for admissions
```

## ✅ Getting Started

### Prerequisites

* Java 17+
* Maven

### Run the Application

```bash
mvn spring-boot:run
```

The application will start on: `http://localhost:8080`

### Example Credentials

You can register users via the `/api/auth/signup` endpoint.

Example:

```bash
curl -X POST http://localhost:8080/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"username":"alice","password":"pass123","role":"educator"}'
```

Then access authenticated endpoints with:

```bash
curl -u alice:pass123 http://localhost:8080/educator/dashboard
```

### Example API Usage

* **Add a Child**:

```bash
curl -X POST http://localhost:8080/api/children \
  -H "Content-Type: application/json" \
  -u alice:pass123 \
  -d '{"name":"Emma","dateOfBirth":"2020-05-10","contactInfo":"emma.parent@example.com","allergies":"peanuts","specialNeeds":"speech therapy"}'
```

* **Create Admission**:

```bash
curl -X POST http://localhost:8080/api/admissions \
  -H "Content-Type: application/json" \
  -u alice:pass123 \
  -d '{"child":{"id":"<child-id>"}}'
```

* **Update Admission Status**:

```bash
curl -X PUT http://localhost:8080/api/admissions/<admission-id> \
  -H "Content-Type: application/json" \
  -u alice:pass123 \
  -d '{"status":"VALIDATED"}'
```

## 🧪 Testing

Run test scripts provided (e.g. `./interface.sh`, `./admissions.sh`) to validate endpoints.

## 📜 License

MIT License — see [LICENSE](LICENSE) for details.

