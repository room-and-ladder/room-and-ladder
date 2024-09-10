# Code Notes


## Model-Database Enum Sync


* Attributes that utilize the Enum type should always have two enums: one on the database and one on the model. When making changes, always update both enums. Updating the database enum requires a migration.

---



