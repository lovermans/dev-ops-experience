- Update Package
```sh
pkg update && upgrade -y
```

- Install Required Package
```sh
pkg install php composer git unzip proot -y
```

- Create Laravel Project
```sh
composer create-project laravel/laravel octane-app
```

- Enter Laravel Project Directory
```sh
cd octane-app
```

- Add Laravel Octane Dependency
```sh
composer require laravel/octane
```

- Install Laravel Octane (Choose Roadrunner)
```sh
php artisan octane:install
```

- Go To Termux Home Directory
```sh
cd
```

- Mock Somaxconn File
```sh
echo 128 > ~/.somaxconn
```

- Go To Laravel Project Directory
```sh
cd octane-app
```

- Start Laravel Octane (Roadrunner)
```sh
proot -b ~/.somaxconn:/proc/sys/net/core/somaxconn php artisan octane:start --server=roadrunner --host=0.0.0.0 --port=8000
```

> [!NOTE]  
> - If You still have the somaxconn error the try this solution bellow.

- On Your Laravel Project Directory
```sh
echo 128 > /tmp/somaxconn_fake_file_128
```

- Patch Roadrunner Binary
```sh
sed -i 's|/proc/sys/net/core/somaxconn|/tmp/somaxconn_fake_file_128|g' rr
```

- Rerun Laravel Octane
```sh
php artisan octane:start --server=roadrunner --host=0.0.0.0 --port=8000
```