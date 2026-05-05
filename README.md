# 🚀 Laravel Docker Backend System (Production-Ready Setup)

This project demonstrates a **real-world backend architecture** built using Laravel and Docker.

It covers everything from basic setup to advanced concepts like caching, queues, and automation — exactly how modern backend systems are designed.

---

# 📚 Full Learning Series (YouTube)

This repository follows a step-by-step YouTube playlist:

1. Docker Setup (Laravel + MySQL)
2. Nginx Integration
3. Redis Caching (Performance Optimization)
4. Queues + Horizon (Async Processing)
5. Scheduler (Automation)
6. Final Architecture (System Design)

---

# 🧱 Tech Stack

* Laravel
* Docker
* Nginx
* MySQL
* Redis
* Horizon (Queues)
* Scheduler

---

# 🏗 Architecture Overview

```
Browser
   ↓
Nginx
   ↓
Laravel App (PHP-FPM)
   ↓
MySQL

Redis
   ↓
Cache + Queue

Horizon → processes jobs  
Scheduler → runs automated tasks
```

---

# ⚡ Features Implemented

## ✅ 1. Dockerized Laravel Setup

* No local PHP/MySQL required
* Same environment everywhere

---

## 🌐 2. Nginx (Production Server)

* Handles incoming requests
* Forwards to PHP-FPM

---

## ⚡ 3. Redis Caching

* Reduces database load
* Improves performance (1s → 0.01s)

---

## 🔥 4. Queues + Horizon

* Background job processing
* Non-blocking APIs
* Monitoring via Horizon dashboard

---

## 🔄 5. Scheduler (Automation)

* Runs tasks automatically
* No manual triggers needed

---

## 🧠 6. System Architecture

* Clean separation of concerns
* Scalable backend design

---

# 🚀 Getting Started

## 1. Clone Repository

```bash
git clone <your-repo-url>
cd <project-folder>
```

---

## 2. Setup Environment

```bash
cp .env.example .env
```

---

## 3. Start Docker Containers

```bash
docker compose up -d --build
```

---

## 4. Install Dependencies

```bash
docker exec -it laravel_app composer install
docker exec -it laravel_app php artisan key:generate
docker exec -it laravel_app php artisan migrate
```

---

## 5. Access Application

* App: http://localhost:8000
* Horizon: http://localhost:8000/horizon

---

# 🧪 Demo Endpoints

| Feature            | Endpoint       |
| ------------------ | -------------- |
| Slow API (DB hit)  | /slow-projects |
| Cached API (Redis) | /fast-projects |
| Queue Demo         | /with-queue    |
| Blocking Demo      | /without-queue |

---

# 🧠 Key Learnings

* How to design scalable backend systems
* Difference between blocking vs async processing
* How caching improves performance
* How automation works in real applications
* How Docker simplifies development

---

# 🔥 Why This Project?

Most tutorials stop at basic setup.

This project goes beyond:

* Performance
* Scalability
* Real-world architecture

---

# 📈 Next Steps

* Deploy to AWS (EC2)
* Add CI/CD pipeline
* Scale using containers

---

# 🤝 Contributing

Feel free to fork and improve this project.

---

# ⭐ Support

If this helped you:

* Star the repo ⭐
* Subscribe on YouTube 🚀

---

# 📩 Connect

Created by: Anirban Bhowmick
