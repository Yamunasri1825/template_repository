# Use a Node.js base image
FROM node:18

# Install PostgreSQL
RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib

# Set up PostgreSQL
USER postgres
RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER postgres WITH SUPERUSER PASSWORD 'newpassword';" && \
    createdb -O myuser mydb

# Switch back to the default user
USER node

# Set the working directory
WORKDIR /workspace

# Copy the Next.js app code
COPY . .

# Install dependencies
RUN npm install
