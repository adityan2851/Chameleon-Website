# Step 1: Build the React app
FROM node:18-alpine AS build

WORKDIR /app

# Copy package.json and package-lock.json and install dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy the rest of the app and build
COPY . .
RUN npm run build

# Step 2: Serve with Express
FROM node:18-alpine

WORKDIR /app

# Copy the build files and the server file from the build stage
COPY --from=build /app/build /app/build
COPY package*.json ./
COPY server.js ./

# Install only production dependencies (for Express)
RUN npm ci --only=production

# Expose port 3000
EXPOSE 3000

# Start the server
CMD ["node", "server.js"]