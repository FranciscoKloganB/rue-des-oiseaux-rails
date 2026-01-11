# Rue des Oiseaux

This README documents the steps necessary to get the application up and running.

## Getting Started

### Prerequisites

- Ruby 3.4.4
- SQLite3

### Setup

Run the setup script to install dependencies and prepare the database:

```bash
bin/setup
```

### Running the Application

Start the development server:

```bash
bin/dev
```

This command uses `foreman` to start the Rails server and the Tailwind CSS watcher as defined in `Procfile.dev`.

### Database Management

To run pending migrations:

```bash
bin/rails db:migrate
```

To rollback the last migration:

```bash
bin/rails db:rollback
```

To generate a new migration:

```bash
bin/rails generate migration MigrationName
```
