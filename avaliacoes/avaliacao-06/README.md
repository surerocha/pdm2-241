# FastAPI com SQLite3

Este projeto é um exemplo de aplicação backend usando FastAPI e SQLite3 para gerenciar dados de alunos.

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

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir uma issue ou enviar um pull request.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
