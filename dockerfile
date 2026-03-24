# Imagem base Python 3.13
FROM python:3.13

# Define variável de ambiente para não criar virtualenv no container
ENV POETRY_VIRTUALENVS_CREATE=false

# Instala o Poetry (gerenciador de dependências)
RUN pip install poetry

# Define o diretório de trabalho
WORKDIR /src

# Copia apenas arquivos de dependência para aproveitar cache do Docker
COPY . /src

# Instala apenas as dependências (não o projeto em si)
RUN poetry install --no-root

# Copia o restante dos arquivos do projeto
COPY . /src

# Expõe a porta 8501 (padrão do Streamlit)
EXPOSE 8501

# Comando de entrada: executa o Streamlit com a aplicação
ENTRYPOINT ["poetry", "run", "streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
