import sqlite3
from faker import Faker
import random

NUMBER_USERS = 20
NUMBER_TASKS = 30


conn = sqlite3.connect("./test.db")
cursor = conn.cursor()
faker = Faker()

# Додаємо статуси
statuses = [("new",), ("in progress",), ("completed",)]
cursor.executemany("INSERT OR IGNORE INTO status (name) VALUES (?)", statuses)

# Додаємо користувачів
users = [(faker.name(), faker.email()) for _ in range(NUMBER_USERS)]
cursor.executemany("INSERT INTO users (fullname, email) VALUES (?, ?)", users)

# Отримуємо ID користувачів та статусів
cursor.execute("SELECT id FROM users")
user_ids = [row[0] for row in cursor.fetchall()]

cursor.execute("SELECT id FROM status")
status_ids = [row[0] for row in cursor.fetchall()]

# Додаємо завдання
tasks = [
    (faker.sentence(), faker.text(), random.choice(status_ids), random.choice(user_ids))
    for _ in range(NUMBER_TASKS)
]
cursor.executemany("INSERT INTO tasks (title, description, status_id, user_id) VALUES (?, ?, ?, ?)", tasks)

conn.commit()
conn.close()
