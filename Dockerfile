# Use the official Node.js image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies for the backend
COPY backend/package.json backend/package-lock.json ./
RUN npm install

# Copy backend files
COPY backend/ ./

# Copy frontend files
COPY frontend/ ./frontend


# Expose port 3000
EXPOSE 3000

# Start the Node.js application
CMD ["node", "server.js"]
