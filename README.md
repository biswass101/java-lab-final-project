# City Hospital Management System (JSP + JDBC + MySQL)

This project is now a Java web application built with:
- Java Servlets + JSP (Jakarta EE)
- JDBC
- MySQL
- Maven (`war` packaging)

## Features
- Admin login/logout
- Dashboard with live counts and recent appointments
- Doctor management (list/search/add/delete)
- Patient management (list/search/add/delete)
- Appointment booking/list/delete
- Prescription add/list/delete
- Billing add/list/delete with total calculation
- Unified search across patient/appointment/prescription/billing
- Admin settings and hospital settings update

## Project Structure
- `src/main/java/com/cityhospital` - Java source (models, DAOs, servlets, auth filter)
- `src/main/webapp/WEB-INF/jsp` - JSP pages
- `src/main/resources/db.properties` - MySQL JDBC config
- `sql/schema.sql` - database schema + seed data

## Prerequisites
- Java 17+
- Maven 3.9+
- MySQL 8+
- Tomcat 10.1+ (or any Jakarta EE 10 compatible servlet container)

## Database Setup
1. Create schema and seed data:
```bash
mysql -u root -p < sql/schema.sql
```
2. Update DB credentials in `src/main/resources/db.properties`.

## Build
```bash
mvn clean package
```
This creates `target/hospital-management.war`.

## Deploy
1. Copy `target/hospital-management.war` to Tomcat `webapps/`.
2. Start Tomcat.
3. Open:
```text
http://localhost:8080/hospital-management/login
```

## Default Login
- Username: `admin`
- Password: `admin`

## Notes
- This is a functional academic/demo system.
- Passwords are currently stored as plain text for demo simplicity. Use hashing (BCrypt/Argon2) before production use.

## Run Everything At Once
```bash
./run-project.sh
```

Optional (auto-start backend Tomcat):
```bash
export CATALINA_HOME=/path/to/apache-tomcat
./run-project.sh
```
# java-lab-final-project
