# FastAPI com SQLite3

*Segue a Avaliação 06 da disciplina Programação de Dispositivos Móveis 2*

*Este projeto é um exemplo de aplicação backend usando FastAPI e SQLite3 para gerenciar dados de alunos.*

* Estudante: Sure Rocha Bezerra 

* Professor: Ricardo Duarte Taveira

* Data de Entrega: 01/08/2024

Enunciado:
Desenvolver um Backend Python que usa FASTAPI 

Como um programador Python, crie uma aplicação backend que usa o framework FASTAPI seguindo os seguintes passos:

1) Crie um banco de dados SQLITE3 com o nome dbalunos.db.

2) Crie uma entidade aluno que será persistida em uma tabela TB_ALUNO com os seguintes campos:
* id chave primária do tipo inteiro com autoincremento;
* aluno_nome do tipo string com tamanho 50;
* endereço do tipo string com tamanho 100;

3) Crie os seguintes endpoints FASTAPI abaixo descritos:

* criar_aluno grava dados de um objeto aluno na tabela TB_ALUNO;

* listar_alunos ler todos os registros da tabela TB_ALUNO; 

* listar_um_aluno ler um registro da tabela TB_ALUNO a partir do campo id; 

* atualizar_aluno atualiza um registro da tabela TB_ALUNO a partir de um campo id e dos dados de uma entidade aluno; 

* excluir_aluno exclui um registro da tabela TB_ALUNO a partir de um campo id e dos dados de uma entidade aluno;
  
## Requisitos

- Python 3.7+
- Virtualenv

## Instalação

1. Clone o repositório:

    ```bash
    git clone https://github.com/seu-usuario/seu-repositorio.git
    cd seu-repositorio
    ```

2. Crie e ative um ambiente virtual:

    ```bash
    python3 -m venv venv
    source venv/bin/activate
    ```

3. Instale as dependências:

    ```bash
    pip install fastapi uvicorn sqlalchemy
    ```

## Configuração do Banco de Dados

1. Crie um arquivo `database.py` com a seguinte configuração:

    ```python
    from sqlalchemy import create_engine, Column, Integer, String
    from sqlalchemy.ext.declarative import declarative_base
    from sqlalchemy.orm import sessionmaker

    DATABASE_URL = "sqlite:///./dbalunos.db"

    engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

    Base = declarative_base()

    class Aluno(Base):
        __tablename__ = "TB_ALUNO"
        id = Column(Integer, primary_key=True, index=True, autoincrement=True)
        aluno_nome = Column(String(50), index=True)
        endereco = Column(String(100))

    Base.metadata.create_all(bind=engine)
    ```

## Configuração da Aplicação FastAPI

1. Crie um arquivo `main.py` com o seguinte código:

    ```python
    from fastapi import FastAPI, Depends, HTTPException
    from sqlalchemy.orm import Session
    from pydantic import BaseModel
    from typing import List

    from database import SessionLocal, engine, Aluno

    app = FastAPI()

    class AlunoCreate(BaseModel):
        aluno_nome: str
        endereco: str

    class AlunoResponse(BaseModel):
        id: int
        aluno_nome: str
        endereco: str

        class Config:
            orm_mode = True

    def get_db():
        db = SessionLocal()
        try:
            yield db
        finally:
            db.close()

    @app.post("/criar_aluno/", response_model=AlunoResponse)
    def criar_aluno(aluno: AlunoCreate, db: Session = Depends(get_db)):
        db_aluno = Aluno(aluno_nome=aluno.aluno_nome, endereco=aluno.endereco)
        db.add(db_aluno)
        db.commit()
        db.refresh(db_aluno)
        return db_aluno

    @app.get("/listar_alunos/", response_model=List[AlunoResponse])
    def listar_alunos(db: Session = Depends(get_db)):
        alunos = db.query(Aluno).all()
        return alunos

    @app.get("/listar_um_aluno/{id}", response_model=AlunoResponse)
    def listar_um_aluno(id: int, db: Session = Depends(get_db)):
        aluno = db.query(Aluno).filter(Aluno.id == id).first()
        if aluno is None:
            raise HTTPException(status_code=404, detail="Aluno não encontrado")
        return aluno

    @app.put("/atualizar_aluno/{id}", response_model=AlunoResponse)
    def atualizar_aluno(id: int, aluno: AlunoCreate, db: Session = Depends(get_db)):
        db_aluno = db.query(Aluno).filter(Aluno.id == id).first()
        if db_aluno is None:
            raise HTTPException(status_code=404, detail="Aluno não encontrado")
        db_aluno.aluno_nome = aluno.aluno_nome
        db_aluno.endereco = aluno.endereco
        db.commit()
        db.refresh(db_aluno)
        return db_aluno

    @app.delete("/excluir_aluno/{id}", response_model=AlunoResponse)
    def excluir_aluno(id: int, db: Session = Depends(get_db)):
        db_aluno = db.query(Aluno).filter(Aluno.id == id).first()
        if db_aluno is None:
            raise HTTPException(status_code=404, detail="Aluno não encontrado")
        db.delete(db_aluno)
        db.commit()
        return db_aluno
    ```

## Executando a Aplicação

1. Execute a aplicação FastAPI usando Uvicorn:

    ```bash
    uvicorn main:app --reload
    ```

2. Acesse a documentação automática gerada pelo FastAPI em `http://127.0.0.1:8000/docs` para testar os endpoints.

## Endpoints

- **POST /criar_aluno/**: Cria um novo aluno.
- **GET /listar_alunos/**: Lista todos os alunos.
- **GET /listar_um_aluno/{id}**: Lista um aluno específico por ID.
- **PUT /atualizar_aluno/{id}**: Atualiza um aluno específico por ID.
- **DELETE /excluir_aluno/{id}**: Exclui um aluno específico por ID.


**Evidênciando Testes no Postman:** [fastapi_vscode_postman.pdf](https://github.com/user-attachments/files/16461569/fastapi_vscode_postman.pdf)
