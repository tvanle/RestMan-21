# RestMan

A restaurant management web application (Java Servlet/JSP + MySQL), built as a coursework project for the Information Systems Analysis and Design course at PTIT.

## Features

- Staff login (`LoginServlet`, `UserDAO`) that leads to the warehouse staff page.
- Warehouse staff flow for importing ingredients from suppliers: search suppliers, pick ingredients, and save an import invoice with its detail lines.
- Customer pages for searching dishes by name and viewing dish details.
- Domain model for users, customers, managers, sale staff, warehouse staff, suppliers, ingredients, dishes and import invoices.
- Design documents: `SEQUENCE_DIAGRAM_FINAL.md` (the 65-step scenario of the "import ingredients from supplier" module) and a full design PDF.

## Tech stack

- Java 8, Servlet 4.0 / JSP 2.3 / JSTL 1.2
- MySQL 8 (JDBC via `mysql-connector-java` 8.0.33)
- Maven (WAR packaging), Tomcat 9
- Docker and Docker Compose

## Getting started

```bash
docker compose up --build
```

This starts MySQL (initialised from `database/restman.sql`) and builds and deploys `RestMan.war` to Tomcat on port 8080. Optional sample data is in `add_test_data.sql`.

To build the WAR without Docker: `mvn clean package`.
