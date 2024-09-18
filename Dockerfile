# Step 1: Use Node.js to build the React app
FROM node:18-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application code and build it
COPY . .
RUN npm run build

# Step 2: Use the same Node.js image to serve the app
FROM node:18-alpine

# Set the working directory for the server
WORKDIR /app

# Copy the build output and server files to the container
COPY --from=build /app/build /app/build
COPY server.js /app

# Install Express (if not already done)
RUN npm install express

# Expose the port (default for Express is 3000)
EXPOSE 3000

# Start the Express server
CMD ["node", "server.js"]
