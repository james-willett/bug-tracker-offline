#!/bin/bash

echo "Starting server setup..."

# Kill any existing processes
echo "Cleaning up existing processes..."
./cleanup.sh

# Clean the database
rm -f bugtracker-backend/bugs.db

# Start the backend
echo "Starting backend server..."
cd bugtracker-backend
go run cmd/bugtracker/main.go & echo $! > ../backend.pid
cd ..

# Start the frontend
echo "Starting frontend server..."
cd bugtracker-frontend
npm install
npm run dev & echo $! > ../frontend.pid
cd ..

# Wait for the frontend to be ready
echo "Waiting for frontend server to be ready..."
npx wait-port 3000

echo "Server setup complete." 