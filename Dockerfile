# Use an official Node.js runtime as the base image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the app dependencies
RUN npm install

# Copy the rest of the application source code to the container
COPY . .

# Build the React app for production
RUN npm run build

# Use an Nginx image to serve the app
FROM nginx:alpine

# Copy the built React app from the first stage to the Nginx HTML directory
COPY --from=0 /usr/src/app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]