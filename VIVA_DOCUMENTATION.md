# City Hospital Management System: Viva Documentation

## 1. Project Overview

### 1.1 What this project is
This is a JSP + Servlet + JDBC based Hospital Management web application built as an academic project.  
It manages:
- Admin authentication
- Doctors
- Patients
- Appointments
- Prescriptions (including multiple medicine items)
- Billing
- Unified search
- Hospital/admin settings

### 1.2 Main goal
The goal is to show full-stack Java web development using:
- Presentation layer (JSP + Tailwind UI)
- Controller layer (Servlets)
- Data access layer (DAO + JDBC)
- Relational database design (MySQL)

### 1.3 Key strengths to mention in viva
- Clean separation of concerns (JSP, Servlet, DAO, Model)
- Prepared statements in SQL queries
- Session-based authentication + protected routes via filter
- Real-time unified search (server JSON + client fetch)
- Transaction-aware insert/update in key modules (appointments/prescriptions/billing/patient/doctor code generation)
- Printable prescription and bill endpoints

---

## 2. Technology Stack

- Language: Java 17
- Web: Jakarta Servlet 6, JSP, JSTL
- Build tool: Maven (`war` packaging)
- DB: MySQL 8
- Server: Apache Tomcat 10.1+
- Frontend: Tailwind CSS CDN + Bootstrap Icons + small custom CSS

Reference files:
- [`pom.xml`](/home/biswass101/Documents/Programming/Enterprise_Java_CityU/Project-Hospital-Management/pom.xml)
- [`src/main/webapp/WEB-INF/web.xml`](/home/biswass101/Documents/Programming/Enterprise_Java_CityU/Project-Hospital-Management/src/main/webapp/WEB-INF/web.xml)
- [`src/main/resources/db.properties`](/home/biswass101/Documents/Programming/Enterprise_Java_CityU/Project-Hospital-Management/src/main/resources/db.properties)

---

## 3. Project Structure (How it is coded)

### 3.1 Layered design
- `com.cityhospital.model`: Plain Java model classes (POJO)
- `com.cityhospital.dao`: Database operations via JDBC
- `com.cityhospital.web`: Servlets + auth filter
- `src/main/webapp/WEB-INF/jsp`: Views (JSP pages)

### 3.2 MVC mapping
- View: JSP (`/WEB-INF/jsp/*.jsp`)
- Controller: Servlet (`/app/*` routes, plus login/logout)
- Model + Data: POJO + DAO + MySQL

---

## 4. URL Routing and Request Flow

### 4.1 Authentication routes
- `/login` and `/` -> `LoginServlet`
- `/logout` -> `LogoutServlet`

### 4.2 Protected app routes (`/app/*`)
All `/app/*` URLs are protected by `AuthFilter`.  
If session has no `currentUser`, user is redirected to `/login`.

### 4.3 Main route list
- `/app/dashboard`
- `/app/doctors`
- `/app/patients`
- `/app/appointments`
- `/app/prescriptions`
- `/app/prescriptions/print`
- `/app/billing`
- `/app/billing/print`
- `/app/search`
- `/app/settings`

References:
- [`src/main/java/com/cityhospital/web/AuthFilter.java`](/home/biswass101/Documents/Programming/Enterprise_Java_CityU/Project-Hospital-Management/src/main/java/com/cityhospital/web/AuthFilter.java)
- [`src/main/java/com/cityhospital/web/LoginServlet.java`](/home/biswass101/Documents/Programming/Enterprise_Java_CityU/Project-Hospital-Management/src/main/java/com/cityhospital/web/LoginServlet.java)

---

## 5. Database Design

### 5.1 Tables
- `users`
- `hospital_settings`
- `doctors`
- `patients`
- `appointments`
- `prescriptions`
- `prescription_items`
- `bills`

### 5.2 Important relationships
- `appointments.patient_id -> patients.id` (FK, cascade delete)
- `appointments.doctor_id -> doctors.id` (FK, cascade delete)
- `prescriptions.patient_id -> patients.id`
- `prescriptions.doctor_id -> doctors.id`
- `prescription_items.prescription_id -> prescriptions.id`
- `bills.patient_id -> patients.id`

### 5.3 Seed data
Schema file inserts:
- Default admin user
- Hospital profile
- Sample doctors/patients/appointments/prescriptions/bills

Reference:
- [`sql/schema.sql`](/home/biswass101/Documents/Programming/Enterprise_Java_CityU/Project-Hospital-Management/sql/schema.sql)

---

## 6. Module-by-Module Explanation

## 6.1 Login/Logout
- Login checks username/password using `UserDao.validate`.
- On success, user object saved in session as `currentUser`.
- Logout invalidates session.

What teacher may ask:
- "Why filter?"  
Answer: To centralize authorization check for all app pages (`/app/*`) and avoid repeating checks in every servlet.

## 6.2 Dashboard
`DashboardServlet` composes statistics from multiple DAOs:
- Total patients
- Total doctors
- Today appointments
- Pending bills
- Plus recent appointments list

## 6.3 Doctors and Patients
Pattern is similar:
- `doGet` loads list and optional search query.
- `doPost` handles create/update/delete based on hidden `action`.
- DAO uses prepared statements.
- New codes are auto-generated:
  - Doctor: `D-...`
  - Patient: `P-...`

## 6.4 Appointments
- Create/update/delete appointments.
- Doctor and patient are selected from dropdowns.
- Appointment code auto-generated (e.g., `A-...`).
- Date and time are stored as SQL `DATE` and `TIME`.

## 6.5 Prescriptions
- Supports multiple medicines (`prescription_items`) in addition to legacy single medicine columns.
- `PrescriptionDao` ensures `prescription_items` table exists.
- Items are saved in transaction with parent prescription.
- UI supports dynamic add/remove medicine rows.
- Print page available via `/app/prescriptions/print?id=...`

## 6.6 Billing
- Creates bills with fee breakdown:
  - consultation fee
  - medicine cost
  - service charge
- Total is calculated in servlet (`sum of 3`).
- Payment status tracked (`Paid` / `Unpaid`).
- Print page available via `/app/billing/print?id=...`

## 6.7 Search
- Single search box across Patient/Appointment/Prescription/Billing.
- Optional type filter.
- Supports both:
  - JSP rendering
  - JSON API (`format=json`) for realtime UI updates
- Client-side JS calls backend via `fetch`.

## 6.8 Settings
- Hospital info update
- Admin account update (username/role/password)
- Password update logic keeps old password if new password field is blank.

---

## 7. Code-Level Design Choices

### 7.1 Why DAO pattern
To isolate SQL/database logic from Servlet logic.  
Benefits:
- Cleaner code
- Easier maintenance/testing
- Lower coupling

### 7.2 Why PreparedStatement
- Prevent SQL injection in query parameters
- Cleaner parameter binding

### 7.3 Why JSP inside `WEB-INF`
Direct browser access to JSP is blocked; requests must go through servlets.

### 7.4 Why session-based auth
Simple and suitable for academic demo with server-side rendered JSP app.

### 7.5 Code generation strategy
Codes are generated from current `MAX(id)+1` and formatted using `AppUtil`.
Examples:
- `D-101` style for doctors
- `P-2001` style for patients

Reference:
- [`src/main/java/com/cityhospital/util/AppUtil.java`](/home/biswass101/Documents/Programming/Enterprise_Java_CityU/Project-Hospital-Management/src/main/java/com/cityhospital/util/AppUtil.java)

---

## 8. Security and Limitations (important for viva honesty)

Current limitations:
- Passwords are stored in plain text (demo-only, not production-safe).
- No role-based authorization enforcement beyond login.
- No CSRF protection tokens.
- Limited server-side validation (mostly parsing + required fields from form).

How to improve (production roadmap):
- Hash passwords using BCrypt/Argon2
- Implement role-based access control
- Add CSRF tokens
- Add Bean Validation / stricter input validation
- Add global exception handler/logging framework
- Move Tailwind from CDN to local build for offline stability

---

## 9. Transaction and Data Integrity Notes

Where transactions are used:
- Insert operations where code generation and insert should be atomic
- Prescription insert/update with child medicine item writes

Why this matters:
- Prevents partially saved records during failure
- Keeps parent-child consistency (`prescriptions` + `prescription_items`)

---

## 10. How to Run and Deploy

### 10.1 Build
```bash
mvn clean package
```
Generates:
- `target/hospital-management.war`

### 10.2 Deploy to Tomcat
You already have script:
- [`run-project.sh`](/home/biswass101/Documents/Programming/Enterprise_Java_CityU/Project-Hospital-Management/run-project.sh)

It:
- Stops Tomcat
- Builds WAR
- Copies WAR to Tomcat `webapps`
- Starts Tomcat

---

## 11. Frequently Asked Viva Questions and Ready Answers

1. **Why did you choose JSP/Servlet instead of Spring Boot?**  
For this course, I wanted to demonstrate core Java EE web fundamentals first: request handling, session management, JDBC, JSP rendering, and MVC flow without heavy framework abstraction.

2. **How do you enforce login?**  
Using `AuthFilter` on `/app/*`. It checks session attribute `currentUser`; if absent, redirects to `/login`.

3. **How is SQL injection handled?**  
All dynamic query inputs are bound through `PreparedStatement` placeholders (`?`), not string concatenation.

4. **How are IDs/codes generated?**  
Business codes (like `P-2001`, `D-101`) are generated in Java using next numeric id logic from DB (`MAX(id)+1`) and formatting helper methods in `AppUtil`.

5. **How do you support multiple medicines in one prescription?**  
A separate child table `prescription_items` stores each medicine row linked by `prescription_id`. DAO writes parent + child rows in one transaction.

6. **What is your architecture pattern?**  
MVC-style with layered separation:
- JSP for view
- Servlet for controller
- DAO for persistence
- POJO for model

7. **How does real-time search work?**  
Frontend JS sends debounced fetch requests to `/app/search?format=json`. Backend returns JSON results from `SearchDao`, and JS re-renders table rows.

8. **What are major assumptions/constraints?**  
Single admin-oriented use case, academic/demo security, no distributed session management, and local MySQL/Tomcat setup.

9. **How do you handle deletion consistency?**  
Foreign keys use `ON DELETE CASCADE` in relational tables (e.g., appointment/prescription/bill rows tied to parent entities).

10. **What would you improve if given more time?**  
- Password hashing + RBAC  
- Better validation/error feedback  
- Unit/integration tests  
- REST API layer + frontend separation  
- Audit logs and reporting

---

## 12. Demo Script for Presentation (2-3 minutes)

1. Login using admin credentials.  
2. Show dashboard stats changing after an operation.  
3. Add a patient and doctor.  
4. Create an appointment for that patient.  
5. Create a prescription with multiple medicine rows.  
6. Create billing and show auto total calculation.  
7. Use unified search to find the same patient in different modules.  
8. Open print view for prescription or bill.  
9. Show settings update page.

This order proves full flow coverage from master data -> clinical workflow -> billing -> search.

---

## 13. Honest Summary (good closing answer)

This project demonstrates end-to-end Java web application development using classical Jakarta stack.  
The strongest technical points are layered architecture, relational modeling, prepared-statement based JDBC, and functional coverage of common hospital operations.  
The main known gap is production-grade security, which is clearly identified with an upgrade roadmap.
