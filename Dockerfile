# Use Node.js base image
FROM node:18

# Install PostgreSQL
RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib && \
    apt-get clean

# Switch to the PostgreSQL user
USER postgres

# Set up PostgreSQL
RUN service postgresql start && \
    psql --command "DO $$ BEGIN IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'myuser') THEN CREATE ROLE myuser WITH LOGIN PASSWORD 'newpassword'; END IF; END $$;" && \
    psql --command "ALTER ROLE myuser CREATEDB;" && \
    createdb -O myuser mydb || echo "Database creation failed"

# Set PostgreSQL data directory for persistence
VOLUME ["/var/lib/postgresql/data"]

# Switch back to the default user
USER node

# Set the working directory
WORKDIR /workspace

# Copy the Next.js app code
COPY . .

# Install dependencies
RUN npm install

# Expose Next.js and PostgreSQL ports
EXPOSE 3000 5432

# Start both PostgreSQL and Next.js when the container starts
CMD service postgresql start && npm run dev
