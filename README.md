# AutoCar Garage Management System

A web-based Java servlet application for managing automotive repair and sales operations. This system provides dedicated dashboards and functionalities for three distinct user roles: **Salespersons**, **Mechanics**, and **Customers**.

---

## Project Overview

This application allows internal staff and customers to manage and access vehicle-related services, car inventory, parts, invoices, and service tickets. After login, each user is directed to a role-specific dashboard.

### Authentication
- Role-based login:
  - Salesperson, Mechanic: by **name**
  - Customer: by **name + phone number**

---

## Technologies

- **Java 8**
- **Servlet & JSP**
- **HTML/CSS & Bootstrap**
- **JSTL**
- **SQL Server**
- **MVC pattern (manual)**
- **JDBC for DB access**

---

## Features

### For Salespersons
- CRUD **Customers**
- CRUD **Cars** (Search by serial, model, year)
- Create/View **Service Tickets**
- CRUD **Parts**
- Create **Invoices**
- View **Reports**:
  - Cars sold by year
  - Car sales revenue by year
  - Best-selling models
  - Most-used parts
  - Top 3 mechanics by repair count

### For Mechanics
- View/Search **Service Tickets**
- Update **Service Tickets** (hours, comments, rating)
- CRUD **Services**

### For Customers
- View personal **Service Tickets** & **Details**
- View **Invoices**
- Update personal **Profile**

---

## Project Structure

```
.
├── build.xml                   # Apache Ant build script
├── nbproject/                 # NetBeans project config
├── build/web/                 # Compiled JSP/HTML output
├── src/
│   ├── conf/                  # Manifest configuration
│   └── java/
│       ├── controller/        # Servlets / Controllers
│       ├── dao/               # Data access layer (JDBC)
│       ├── dto/               # Data transfer objects
│       ├── filter/            # Servlet filters (auth, etc.)
│       ├── model/             # Entities / Models
│       └── mylib/             # Utilities
├── web/                       # JSP Views, HTML, Bootstrap assets
```

---

## How to Run

> Ensure you have **Java 8**, **NetBeans IDE**, and a **local SQL Server** instance.

1. **Clone this repo**
2. **Import into NetBeans** (or compatible IDE)
3. **Configure DB** connection in `DBUtils.java`
4. **Start SQL Server** and create the required tables
5. **Run Project** using built-in Tomcat/Glassfish

---

## Notes

- No external CSS/JS frameworks besides Bootstrap
- All view logic is done using raw **JSP** and **HTML**
- Follows a simplified **MVC** structure without frameworks

---

## Developer

**Author:** Minh Kha  
**Environment:** Local development with NetBeans and SQL Server
