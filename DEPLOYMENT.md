# Deployment Guide for VPS Fedora 43 with Nginx

## Prerequisites
- Fedora 43 server
- Root or sudo access
- Domain pointed to server IP

## 1. Update System
```bash
sudo dnf update -y
```

## 2. Install Required Packages
```bash
# Install nginx, PHP 8.3, MySQL/MariaDB, Redis
sudo dnf install -y nginx php php-fpm php-mysqlnd php-redis php-xml php-mbstring php-curl php-zip php-gd php-intl php-bcmath mariadb-server redis

# Enable and start services
sudo systemctl enable nginx php-fpm mariadb redis
sudo systemctl start nginx php-fpm mariadb redis
```

## 3. Configure MySQL/MariaDB
```bash
sudo mysql_secure_installation
# Create database and user
sudo mysql -u root -p
CREATE DATABASE skpi;
CREATE USER 'skpi_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON skpi.* TO 'skpi_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

## 4. Configure PHP-FPM
Edit `/etc/php-fpm.d/www.conf`:
- Ensure `listen = /run/php-fpm/www.sock`
- Set user/group to nginx or appropriate user

## 5. Deploy Application
```bash
# Clone or upload code to /var/www/digital-skip
cd /var/www
git clone <your-repo> digital-skip
cd digital-skip/backend

# Install dependencies
composer install --no-dev --optimize-autoloader
npm install --production
npm run build

# Set permissions
sudo chown -R nginx:nginx /var/www/digital-skip
sudo chmod -R 755 /var/www/digital-skip
sudo chmod -R 775 storage bootstrap/cache

# Copy and configure .env
cp .env.example .env
# Edit .env with production values:
# APP_ENV=production
# APP_DEBUG=false
# DB_HOST=localhost
# DB_DATABASE=skpi
# DB_USERNAME=skpi_user
# DB_PASSWORD=your_password
# REDIS_HOST=localhost
# CACHE_STORE=redis
# QUEUE_CONNECTION=redis

# Run setup
./setup.sh
```

## 6. Configure Nginx
Copy the updated nginx config to server:
```bash
sudo cp /var/www/digital-skip/docker/nginx/default.conf /etc/nginx/conf.d/skpi.conf
# Edit /etc/nginx/conf.d/skpi.conf:
# - Uncomment fastcgi_pass unix:/run/php-fpm/www.sock;
# - Comment out fastcgi_pass laravel_app:9000;
# - Update server_name to your domain
sudo nginx -t
sudo systemctl reload nginx
```

## 7. Configure SSL (Optional but Recommended)
```bash
sudo dnf install -y certbot python3-certbot-nginx
sudo certbot --nginx -d skpi.dwijacode.my.id
```

## 8. Setup Queue Worker and Scheduler
```bash
# Queue worker (using supervisor or systemd)
# Scheduler: Add to crontab
echo "* * * * * cd /var/www/digital-skip/backend && php artisan schedule:run >> /dev/null 2>&1" | sudo crontab -
```

## 9. Additional Security
- Configure firewall (firewalld)
- Set up fail2ban
- Regular backups
- Monitor logs

## Troubleshooting
- Check nginx error logs: `sudo tail -f /var/log/nginx/error.log`
- Check PHP-FPM logs: `sudo tail -f /var/log/php-fpm/error.log`
- Check Laravel logs: `tail -f storage/logs/laravel.log`