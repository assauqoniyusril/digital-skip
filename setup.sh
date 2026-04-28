#!/bin/bash
echo "Setting up Laravel..."

# Generate key
docker exec -it laravel_container php artisan key:generate

# Create tmp directory
mkdir -p tmp storage/framework/cache/data
chmod 777 tmp storage/framework/cache/data

# Run migrations
docker exec -it laravel_container php artisan migrate

# Create storage link
docker exec -it laravel_container php artisan storage:link

# Clear cache
docker exec -it laravel_container php artisan optimize:clear

echo "Setup complete!"