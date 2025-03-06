# Use an official Node.js image
FROM node:16-alpine

# Set the working directory
WORKDIR /app

# Copy all project files
COPY . .

# Install dependencies
RUN npm install

# Build the production version of the app
RUN npm run build

# Install serve globally to serve the built app
RUN npm install -g serve

# Expose port 3000
EXPOSE 3000

# Command to serve the built React app
CMD ["serve", "-s", "build", "-l", "3000"]