# Step 1: Build the React app
FROM node:18-alpine AS build

WORKDIR /app

# Copy and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the app files and build the app
COPY . .
RUN npm run build

# Step 2: Set up the production environment
FROM node:18-alpine

WORKDIR /app

# Copy the build output and server.js
COPY --from=build /app/build ./build
COPY server.js ./

# Install express in the production container
RUN npm install express

# Expose the correct port
EXPOSE 8080

# Start the server
CMD ["node", "server.js"]
