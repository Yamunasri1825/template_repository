# Use a Node.js base image
FROM node:18

# Install PostgreSQL
RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib

# Set up PostgreSQL
USER postgres
RUN /etc/init.d/postgresql start && \
    psql --command "DO $$ BEGIN IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'myuser') THEN CREATE ROLE myuser WITH LOGIN PASSWORD 'newpassword'; END IF; END $$;" && \
    createdb -O myuser mydb || echo "Database creation failed"

# Switch back to the default user
USER node

# Set the working directory
WORKDIR /workspace

# Copy the Next.js app code
COPY . .

# Install dependencies
RUN npm install
