# E-Commerce Microservices Architecture

This project is a comprehensive implementation of a microservices architecture using **Spring Boot**, **Spring Cloud**, and **Kafka**. It demonstrates a scalable e-commerce backend with event-driven capabilities and AI integration.

## Architecture Overview

The system consists of the following microservices:

| Service | Port | Description |
| :--- | :--- | :--- |
| **Discovery Service** | `8761` | Eureka Server for service registration and discovery. |
| **Config Service** | `9999` | Centralized configuration management (Git-backed). |
| **Gateway Service** | `8888` | Spring Cloud Gateway acting as the single entry point. |
| **Customer Service** | `8081` | Manages customer data (H2 DB). |
| **Inventory Service** | `8082` | Manages product inventory (H2 DB). |
| **Billing Service** | `8083` | Handles invoicing and communicates with Customer/Inventory via OpenFeign. Produces Kafka events. |
| **Chatbot Service** | `8084` | **RAG Chatbot** using Spring AI & Telegram to answer queries from PDF docs. |
| **Kafka Ecom** | N/A | Analytics service consuming Kafka events (`BillCreated`). |

## 🚀 Key Features

### 1. Core Microservices
*   **REST APIs**: Built with Spring Data REST.
*   **Inter-service Communication**: Uses **OpenFeign** for synchronous calls (e.g., Billing fetching Customer details).
*   **Discovery**: All services register with Eureka.
*   **Gateway**: Dynamic routing based on service names (`lb://SERVICE-NAME`).

### 2. Event-Driven Architecture (Kafka)
*   **Producer**: `Billing-Service` publishes a `BillEvent` to the `bills-topic` whenever a bill is created.
*   **Consumer**: `Kafka-Ecom` listens to this topic and performs real-time analytics (via Spring Cloud Stream).

### 3. AI & RAG Integration (Chatbot)
*   **Spring AI**: Implements Retrieval Augmented Generation.
*   **Vector Store**: In-memory vector store for PDF document ingestion.
*   **Telegram Bot**: Interactive bot interface for users to ask questions about course material or products.
    *   Command: `/start` - Greet the user.
    *   Command: `/ping` - Health check.
    *   Natural Language: Ask any question based on the provided PDF.

### 4. Configuration Management
*   **Config Server**: Centralizes `application.properties` for all services.
*   **Hot Reload**: Supports dynamic configuration updates via `/actuator/refresh`.

## 🛠️ Tech Stack
*   **Java 17**
*   **Spring Boot 3.x**
*   **Spring Cloud** (Gateway, Config, Eureka, OpenFeign, Stream)
*   **Apache Kafka**
*   **Spring AI**
*   **H2 Database**
*   **Telegram Bots API**

## 🏃‍♂️ How to Run

1.  **Start Infrastructure**:
    *   Start `discovery-service` (8761).
    *   Start `config-service` (9999).
2.  **Start Core Services**:
    *   Start `customer-service`, `inventory-service`, `gateway-service`.
3.  **Start Kafka & Analytics**:
    *   Ensure Kafka / Zookeeper are running.
    *   Start `billing-service` and `kafka-ecom`.
4.  **Start Chatbot**:
    *   Place your PDF in `chatbot-service/src/main/resources/docs/`.
    *   Run `chatbot-service`.

## 📸 Screenshots

*(Add screenshots of Eureka Dashboard, OpenFeign response, or Telegram Bot here)*

## 👤 Author
**Mounib Ghita**
