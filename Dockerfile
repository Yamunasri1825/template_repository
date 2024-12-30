FROM node:16

# Install PostgreSQL CLI
RUN apt-get update && apt-get install -y postgresql-client

# Set working directory
WORKDIR /workspace

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy app code
COPY . .

# Expose app port
EXPOSE 3000

# Default command to start the app
CMD ["npm", "run", "dev"]
