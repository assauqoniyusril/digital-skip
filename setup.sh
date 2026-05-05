#!/bin/bash
echo "Setting up Laravel for VPS..."

# Copy .env file if not exists
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Set the application key if not set
if grep -q "APP_KEY=.*" .env && ! grep -q "APP_KEY=base64:" .env; then
    php artisan key:generate --force
fi

# Create tmp directory
mkdir -p tmp storage/framework/cache/data
chmod 777 tmp storage/framework/cache/data

# Run migrations
php artisan migrate --force

# Create storage link
php artisan storage:link

# Clear cache
php artisan optimize:clear

# Install Filament if not already installed
if ! php artisan filament:install --help > /dev/null 2>&1; then
    composer require filament/filament:"^4.0"
    php artisan filament:install
    php artisan make:filament-panel Staff
fi

echo "Setup complete!"