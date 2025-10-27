# London Ultimate Zuluru 3  
*A containerised, open-source sports league management platform based on Zuluru 3.*

This repository hosts **London Ultimate’s customized implementation of Zuluru 3**, a PHP (CakePHP-based) web application for managing sports leagues, teams, players, and schedules.

The project includes a **Docker-based development and deployment environment** designed to make it simple for contributors to spin up and work on a fully functional Zuluru stack — including the web application, database, and web server — without manual setup.

---

## Project Overview

- **Framework:** CakePHP (PHP 7.4)  
- **Database:** MariaDB 12  
- **Web Server:** NGINX reverse proxy  
- **Runtime:** PHP-FPM on Alpine Linux  
- **Configuration:** Multi-stage Docker build with secrets support and persistent storage  
- **Purpose:** Provide a reliable, reproducible environment for contributors and deployments

All infrastructure details — including service definitions, networking, and secrets management — are found in the included [`Dockerfile`](./Dockerfile) and [`docker-compose.yml`](./docker-compose.yml).

---

## Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/XtraTarTarSauce/London-Ultimate-Zuluru3.git
cd London-Ultimate-Zuluru3
```

### 2. Create Secret Files
The application uses Docker secrets for secure credential management.  
Create the following files in the project root (each containing only the password value):

```bash
echo "supersecuredbpass" > db_password.txt
echo "supersecurerootpass" > root_password.txt
echo "supersecuresmtppass" > smtp_password.txt
```

### 3. Build and Start the Containers
```bash
docker-compose build
docker-compose up -d
```

### 4. Access the Application
Open [http://localhost](http://localhost) in your browser.  
The NGINX reverse proxy serves the web app, which communicates with the PHP-FPM and MariaDB containers internally.

---

## Common Commands

| Action | Command |
|--------|----------|
| View logs | `docker compose logs -f` |
| Rebuild app after code changes | `docker compose build app && docker compose up -d` |
| Run database migrations | `docker compose exec app bin/cake migrations migrate` |
| Open a shell in the app container | `docker compose exec app bash` |
| Stop and remove containers | `docker compose down` |

---

## Contributing

This setup is built for easy contribution:

- Code changes are reflected automatically inside the running containers.  
- The environment matches production as closely as possible.  
- Please avoid committing secrets or local configuration files.  

When contributing:
1. Fork the repository.  
2. Create a feature branch.  
3. Test your changes locally using Docker.  
4. Open a pull request for review.

---

## Environment Notes

- Default PHP runtime: **7.4-FPM (Alpine)**  
- Supported databases: **MariaDB 12 (default)**; MySQL/PostgreSQL supported by CakePHP configuration  
- Secrets are loaded from files (`db_password.txt`, `root_password.txt`, `smtp_password.txt`)  
- Persistent data is stored using Docker volumes

For detailed service configurations, refer directly to:
- [`Dockerfile`](./Dockerfile) — build instructions for the PHP-FPM application image  
- [`docker-compose.yml`](./docker-compose.yml) — container orchestration, secrets, networks, and volumes  

---

## License

This project is licensed under the same terms as the original [Zuluru 3 project](https://github.com/zuluru/zuluru3).  
See the included `LICENSE` file for details.

---

*Maintained by the London Ultimate development team.*
