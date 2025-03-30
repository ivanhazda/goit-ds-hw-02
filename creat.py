import sqlite3
from contextlib import contextmanager

database = './test.db'

@contextmanager
def create_connection(db_file):
    """Створити з'єднання з базою даних SQLite"""
    conn = sqlite3.connect(db_file)
    yield conn
    conn.rollback()
    conn.close()


with create_connection(database) as conn:
    cursor = conn.cursor()
    # Створення таблиці users
    create_table_query = '''
    CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);
'''
    cursor.execute(create_table_query)
    
    # Створення таблиці status
    create_table_query = '''
    CREATE TABLE IF NOT EXISTS status (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL UNIQUE
);
'''
    cursor.execute(create_table_query)

   # Створення таблиці status
    create_table_query = '''
    CREATE TABLE IF NOT EXISTS tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(100),
    description text,
    status_id integer,
    user_id integer,
    FOREIGN KEY (status_id) REFERENCES status (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
);
'''
    cursor.execute(create_table_query)

    conn.commit()  # Виконайте, якщо хочете зберегти зміни
