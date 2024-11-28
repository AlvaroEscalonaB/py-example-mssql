from enum import StrEnum

from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    server: str
    port: str
    database: str
    username: str
    password: str
    db_driver: str = "ODBC+Driver+17+for+SQL+Server"

    class Config:
        env_file = ".env"
        extra = "ignore"

    def config(self) -> str:
        return f"mssql+pyodbc://{self.username}:{self.password}@{self.server}/{self.database}?driver={self.db_driver}"

    def connection_string(self) -> str:
        return f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={self.server},{self.port};DATABASE={self.database};UID={self.username};PWD={self.password}"


settings = Settings()  # type: ignore
