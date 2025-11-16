FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

# Copy source code
COPY . .

# Build the app
RUN npm run build

RUN npm install -g serve

# app turns on port 3500
EXPOSE 3500

# Serve the built app
CMD ["serve", "-s", "dist", "-l", "3500"]