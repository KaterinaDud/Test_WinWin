# Test_WinWin
This project implements a tiny service containerized with Docker Compose and exposed via Nginx reverse proxy.

---

# WinWin Travel — Тестове завдання DevOps

Цей проєкт реалізує міні-сервіс у контейнерах з Docker Compose та Nginx reverse proxy.

---

## 📌 Що зроблено

* Контейнерізовано простий веб-сервіс (`hashicorp/http-echo`), який віддає JSON у форматі:

  ```json
  {"status":"ok","service":"app","env":"<ENV_NAME>"}
  ```
* Перед сервісом налаштовано **nginx reverse proxy**:

  * слухає на `localhost:8080`;
  * прокидує заголовок `X-Request-ID` (генерує, якщо відсутній);
  * обмежує запити: максимум **10 запитів/сек з одного клієнта**, інакше повертає `429 Too Many Requests`.
* Реалізовано підтримку змінних оточення через `.env` (параметр `ENV_NAME`).
* Додано **healthchecks** для обох контейнерів.
* Створено **Makefile** для зручного керування (`make up / make down / make logs / make test`).

---

## Передумови

* Встановлений **Docker** та **docker-compose**.
* Для `make test` рекомендовано мати `jq` (для форматування JSON).

---

## Як запустити

```bash
# 1. Клонуй репозиторій
git clone <repo-url>
cd winwin-devops-test

# 2. Створи файл .env на основі прикладу
cp .env.example .env

# 3. Запусти контейнери
make up
```

---

## Тестування

1. Перевір сервіс:

   ```bash
   curl -s http://localhost:8080/healthz
   ```

   Очікувано:

   ```json
   {"status":"ok","service":"app","env":"local"}
   ```

2. Перевір rate-limit:

   ```bash
   make test
   ```

   У відповідях будуть `200` і частина `429`.

---

##  Зупинка

```bash
make down
```

---

### Bonus (Kubernetes)

> Не обов’язково, але можна реалізувати через **Kind + Ingress**.
> (тут можна буде описати, якщо ти доробиш K8s маніфести).

---

---




Хочеш, я одразу підставлю приклад твого кастомного JSON (наприклад `"service":"winwin"`, `"env":"prod"`) у `README`, щоб збігалося з тим, що реально у тебе віддає `/healthz`?
