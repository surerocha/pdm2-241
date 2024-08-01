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
