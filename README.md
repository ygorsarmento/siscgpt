# SISCGPT

Plataforma integrada que combina **Apache Airflow**, **dbt Core** e **API FastAPI** para orquestrar, transformar e gerenciar dados organizacionais, possibilitando a criação de dashboards com os principais indicadores da coordenação.

## 🚀 Quick Start

### Pré-requisitos
- Docker Desktop instalado

### Instalação

1. Clone o repositório:
```bash
git clone <repo-url>
cd siscgpt
```

2. Configure as variáveis de ambiente (`.env`):
```bash
cp .env.example .env  # Se existir, caso contrário edite .env
```

3. Inicie os serviços:
```bash
docker compose up -d
```

4. Teste a conexão:
```bash
cd siscgpt_dw
dbt debug
```

## 📁 Estrutura

```
siscgpt/
├── siscgpt_dw/       # Projeto dbt (transformação de dados)
│   ├── models/       # Modelos dbt
│   ├── tests/        # Testes
│   └── macros/       # Macros dbt
├── docker-compose.yml # Stack: PostgreSQL
├── pyproject.toml    # Dependências Python
└── README.md
```

## 🛠️ Stack Tecnológico

- **PostgreSQL**: Banco de dados
- **dbt Core**: Transformação de dados
- **Apache Airflow**: Orquestração (futuro)
- **FastAPI**: API REST (futuro)

## 📖 Documentação

- [dbt Core](https://docs.getdbt.com/)
- [PostgreSQL](https://www.postgresql.org/docs/)

---

**Porta padrão**: PostgreSQL na porta `5433`
