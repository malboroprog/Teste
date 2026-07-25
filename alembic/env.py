import os
import sys
from logging.config import fileConfig

from sqlmodel import SQLModel

from alembic import context

# ensure repo root is on sys.path
repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if repo_root not in sys.path:
    sys.path.insert(0, repo_root)

# try to import engine from app; fallback to None
try:
    from src.app.crud import engine as app_engine
except (ImportError, ModuleNotFoundError):
    app_engine = None

config = context.config
if config.config_file_name is not None:
    fileConfig(config.config_file_name)

target_metadata = SQLModel.metadata


def run_migrations_offline():
    url = config.get_main_option("sqlalchemy.url") or "sqlite:///./dev.db"
    context.configure(url=url, target_metadata=target_metadata, literal_binds=True)
    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online():
    connectable = app_engine
    if connectable is None:
        from sqlmodel import create_engine

        connectable = create_engine(
            config.get_main_option("sqlalchemy.url") or "sqlite:///./dev.db",
            connect_args={"check_same_thread": False},
        )
    with connectable.connect() as connection:
        context.configure(
            connection=connection, target_metadata=target_metadata, compare_type=True
        )
        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
