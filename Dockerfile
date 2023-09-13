FROM node:lts as deps

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application source code to the container
COPY . .

# Build the application
RUN npm run build

FROM node:lts as runner 

WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install application dependencies
RUN npm install --production

# Copy the rest of the application source code to the container
COPY --from=deps /app/dist ./dist

# Run the application
CMD ["node", "dist/main"]

