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
