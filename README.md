# SIS-CGPT

Sistema de Orquestração de Pipelines ETL para a Coordenação Geral de Populações Tradicionais (CGPT).

## 📖 Visão Geral

Plataforma integrada que combina **Apache Airflow**, **dbt Core** e **API FastAPI** para orquestrar, transformar e gerenciar dados organizacionais, possibilitando a criação de dashboards com os principais indicadores da coordenação.

**Desenvolvido pela COBEM** • Projeto Open-Source

## 🏗️ Arquitetura

- **Apache Airflow** - Orquestração de pipelines ETL
- **dbt Core** - Transformação de dados
- **FastAPI** - API CRUD para gestão de dados
- **PostgreSQL** - Banco de dados principal
- **Docker** - Containerização de todos os serviços

## 🚀 Quick Start

```bash
# Clonar e entrar no projeto
git clone <repository-url>
cd siscgpt

# Configurar ambiente
cp .env.example .env

# Iniciar serviços
docker-compose up -d

# Verificar status
docker-compose ps
```

### Acessando os Serviços

| Serviço | URL | Credenciais |
|---------|-----|-------------|
| Airflow | `http://localhost:8080` | admin / admin |
| API | `http://localhost:8000` | - |
| API Docs | `http://localhost:8000/docs` | - |
| PostgreSQL | `localhost:5432` | postgres / postgres |

## 📁 Estrutura

```
siscgpt/
├── docker-compose.yml
├── .env.example
├── api/           # API FastAPI
├── airflow/       # DAGs e orquestração
├── dbt/           # Modelos dbt
└── scripts/       # Scripts utilitários
```

## 🛠️ Tecnologias

| Componente | Tecnologia |
|------------|------------|
| Python | 3.13.7 |
| Airflow | 2.x |
| dbt Core | PostgreSQL adapter |
| FastAPI | Uvicorn |
| PostgreSQL | 15 |
| Docker | Docker Compose |

## � Comandos Úteis

```bash
# Ver logs
docker-compose logs -f

# Parar serviços
docker-compose down

# Rebuild de um serviço
docker-compose build api
docker-compose up api
```

## 📄 Licença

Open-Source • CGPT

---

**Status:** 🚧 Em desenvolvimento
