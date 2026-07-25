# src/app/crud.py (stub temporário)
from sqlmodel import create_engine

engine = create_engine("sqlite:///./dev.db", connect_args={"check_same_thread": False})


def create_db_and_tables():
    from sqlmodel import SQLModel

    SQLModel.metadata.create_all(engine)
