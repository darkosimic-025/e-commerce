
# E-Commerce

You can access the production version at: [https://e-commerce-yqvj.onrender.com/](https://e-commerce-yqvj.onrender.com/)

The route for admin login is `/admin/sign_in`.  
Credentials are:  
**Email**: `admin@example.com`  
**Password**: `password123`

## Running in the development environment

To start the application, run the following command:

```bash
docker-compose up --build
```

**Note**: The application requires all tests to pass for a successful startup.

## Running tests separately

To run the tests separately, use the following command:

```bash
docker-compose run web bin/rails test
```
