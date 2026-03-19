# SIS-CGPT

Sistema de Orquestração de Pipelines ETL para a Coordenação Geral de Populações Tradicionais (CGPT).

## 📖 Visão Geral

O **SIS-CGPT** é uma plataforma integrada que combina **Apache Airflow**, **dbt Core** e uma **API REST** para orquestrar, transformar e gerenciar dados organizacionais, possibilitando a criação de dashboards com os principais indicadores da coordenação.

## 🎯 Objetivos

- Orquestrar pipelines ETL de forma automatizada e escalável
- Transformar dados brutos em indicadores estratégicos usando dbt
- Disponibilizar API CRUD para gestão de dados da coordenação
- Centralizar o acesso a informações relevantes para tomada de decisão
- Facilitar a manutenção e evolução das pipelines de dados

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────────────────────────┐
│                         DOCKER COMPOSE                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐     ┌─────────────────┐                   │
│  │   Apache Airflow│     │   API FastAPI   │                   │
│  │   (Orquestração)│     │   (CRUD)        │                   │
│  │                 │     │                 │                   │
│  │  - Webserver    │     │  - Endpoints    │                   │
│  │  - Scheduler    │     │  - Modelos      │                   │
│  │  - Worker       │     │  - Validações   │                   │
│  └────────┬────────┘     └────────┬────────┘                   │
│           │                       │                             │
│           │    ┌──────────────┐   │                             │
│           └───►│   PostgreSQL │◄──┘                             │
│                │   (Database) │                                  │
│                └───────┬──────┘                                  │
│                        │                                         │
│                ┌───────▼───────┐                                 │
│                │    dbt Core   │                                 │
│                │ (Transform.)  │                                 │
│                │               │                                 │
│                │ - Models      │                                 │
│                │ - Seeds       │                                 │
│                │ - Tests       │                                 │
│                └───────────────┘                                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🛠️ Tecnologias

| Componente | Tecnologia |
|------------|------------|
| **Linguagem** | Python 3.13.7 |
| **Orquestração** | Apache Airflow 2.x |
| **Transformação** | dbt Core (PostgreSQL) |
| **API** | FastAPI + Uvicorn |
| **Banco de Dados** | PostgreSQL 15 |
| **Containerização** | Docker + Docker Compose |

## 📁 Estrutura do Projeto

```
siscgpt/
├── docker-compose.yml          # Orquestração dos containers
├── .env                        # Variáveis de ambiente
├── .gitignore                  # Ignorados pelo Git
├── README.md                   # Este arquivo
│
├── api/                        # API REST CRUD
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── main.py                 # Entry point da API
│   ├── config.py               # Configurações
│   ├── database.py             # Conexão com banco
│   ├── models/                 # Modelos SQLAlchemy
│   │   └── __init__.py
│   ├── schemas/                # Schemas Pydantic
│   │   └── __init__.py
│   └── routers/                # Endpoints
│       └── __init__.py
│
├── airflow/                    # Apache Airflow
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── dags/                   # DAGs de orquestração
│   │   ├── __init__.py
│   │   └── etl_pipeline.py
│   └── scripts/                # Scripts auxiliares
│       └── __init__.py
│
├── dbt/                        # dbt Core
│   ├── dbt_project.yml         # Configuração do projeto
│   ├── profiles.yml            # Perfis de conexão
│   ├── models/                 # Modelos SQL
│   │   ├── staging/            # Camada de staging
│   │   ├── intermediate/       # Camada intermediária
│   │   └── marts/              # Camada de negócios
│   ├── seeds/                  # Dados estáticos
│   ├── tests/                  # Testes de qualidade
│   └── macros/                 # Macros SQL
│
└── scripts/                    # Scripts utilitários
    ├── init.sh                 # Inicialização do ambiente
    └── backup.sh               # Backup do banco
```

## 🚀 Quick Start

### Pré-requisitos

- Docker >= 20.10
- Docker Compose >= 2.0
- Git

### Instalação

```bash
# Clonar o repositório
git clone <repository-url>
cd siscgpt

# Copiar arquivo de ambiente
cp .env.example .env

# Iniciar todos os serviços
docker-compose up -d

# Verificar status dos containers
docker-compose ps
```

### Acessando os Serviços

| Serviço | URL | Credenciais |
|---------|-----|-------------|
| Airflow Webserver | `http://localhost:8080` | admin / admin |
| API FastAPI | `http://localhost:8000` | - |
| API Docs (Swagger) | `http://localhost:8000/docs` | - |
| PostgreSQL | `localhost:5432` | postgres / postgres |

### Parar os Serviços

```bash
docker-compose down
```

## 📊 Pipelines ETL

### Fluxo de Dados

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Fonte     │────►│   Staging   │────►│Intermediate │────►│   Marts     │
│   (Raw)     │     │   (Raw)     │     │   (Clean)   │     │ (Indicadores)│
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
```

### DAGs Disponíveis

| DAG | Descrição | Schedule |
|-----|-----------|----------|
| `etl_pipeline_daily` | Pipeline diária de ETL | `@daily` |
| `dbt_run_staging` | Executa modelos de staging | `@hourly` |
| `dbt_run_marts` | Executa modelos de marts | `@daily` |

## 🔌 API Endpoints

### Principais Endpoints

```
GET    /api/v1/items          # Listar todos os itens
POST   /api/v1/items          # Criar novo item
GET    /api/v1/items/{id}     # Obter item por ID
PUT    /api/v1/items/{id}     # Atualizar item
DELETE /api/v1/items/{id}     # Deletar item
```

### Documentação Completa

Acesse `http://localhost:8000/docs` para visualizar a documentação Swagger/OpenAPI completa.

## 🧪 dbt Models

### Camadas

| Camada | Descrição | Prefixo |
|--------|-----------|---------|
| **Staging** | Dados brutos tratados | `stg_` |
| **Intermediate** | Transformações intermediárias | `int_` |
| **Marts** | Indicadores de negócio | `fct_`, `dim_` |

### Comandos dbt

```bash
# Rodar todos os modelos
dbt run

# Rodar modelos específicos
dbt run --select stg_*

# Executar testes
dbt test

# Gerar documentação
dbt docs generate
```

## ⚙️ Configuração

### Variáveis de Ambiente

```bash
# PostgreSQL
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=siscgpt
POSTGRES_PORT=5432

# Airflow
AIRFLOW__CORE__EXECUTOR=LocalExecutor
AIRFLOW__CORE__LOAD_EXAMPLES=False
AIRFLOW_VAR_ENVIRONMENT=development

# API
API_HOST=0.0.0.0
API_PORT=8000
DATABASE_URL=postgresql://postgres:postgres@postgres:5432/siscgpt
```

## 🔧 Desenvolvimento

### Rodar em modo desenvolvimento

```bash
# Build dos containers
docker-compose build

# Iniciar com logs
docker-compose up

# Rebuild de um serviço específico
docker-compose build api
docker-compose up api
```

### Adicionar novas DAGs

1. Crie o arquivo em `airflow/dags/`
2. Defina a DAG com os operadores necessários
3. A DAG aparecerá automaticamente na UI do Airflow

### Adicionar modelos dbt

1. Crie o arquivo `.sql` em `dbt/models/`
2. Adicione testes em `dbt/models/schema.yml`
3. Execute `dbt run` para materializar

## 📝 Logs e Debug

```bash
# Ver logs de todos os serviços
docker-compose logs -f

# Ver logs de um serviço específico
docker-compose logs -f airflow
docker-compose logs -f api
docker-compose logs -f dbt
```

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob licença interna da CGPT.

## 👥 Equipe

Desenvolvido pela **COBEM** para a **Coordenação Geral de Populações Tradicionais (CGPT)**.

---

**Status:** 🚧 Em desenvolvimento
