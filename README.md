
# Django Project – Django ArsMagica Seasons

A **Django web application** that demonstrates clean application structure, database modeling, and testing. This project is connected with my flask project which handles blogs. This project takes care of the endpoint "/" and "seasons/". The project uses **MySQL** as the backend database (but it can easily be switched to another mysql database by editing a single configuration class).

This project has been adapted and extended to work with my Flask project for further development by **Joakim Kvistholm** to work with a 'real' mysql database and to make seasonal work easier for ArsMagica. In this project I use a mysql server for both the test and production database which are running by docker on my windows machine and I am using HeidiSQL as an extra database handler. On the Ubuntu server mysql is running as a service and is not dockerized. All of this brings the project closer to a production-ready web application, deployed with a real MySQL server.  

This project uses **GitHub Actions** for automated deployment to my Ubuntu production server. Whenever new code is pushed to the `main` branch, the workflow defined in `.github/workflows/deploy.yml` runs automatically and updates my server with this new code.

---

## Features  

- User authentication with hashed passwords.  
- Seasonal work posts with users, timestamps, summary and description.
- The summary from the description is made by openai's ChatGPT if it is left out.  
- Relational database schema with proper foreign keys.  
- Django database migrations.  
- Configurable database connection via `SecretVault` class.  
- Uses Django tests that tests towards 'real' mysql databases.  
- Structured project layout for maintainability.  

## Extra Information

All users can create a password that has at least 8 letters. Two superusers: 'admin' and 'joakim' should be created, see 'pip_install_info.txt'. At least one more user will be a good addition to the superusers, but you can easily create them with the web page. It is recommended to look at 'pip_install_info.txt' here is a lot of important information and useful commands if you want to use the project. Remember that for superusers you kan use the admin page, since my domain is 'kvistholm.net' at the time of creating this project the admin page can be reached by 'kvistholm.net/admin' or something similar if you use your domain name.

## Project Structure  

A simplified overview:

- The main folder: -> 'django_arsmagica_seasons'.

- 'arsmagica_seasons/arsmagica_seasons_app': -> The main Django application package.

- Inside 'arsmagica_seasons/arsmagica_seasons_app':

- 'templates': -> With the folders 'auth', 'seasons' and 'home'.

- 'tests': -> Integration tests.

## Database  

The application uses **MySQL 8.1+**.  
Tables include:  

- **user** – stores usernames, hashed passwords, UUIDs, and API keys.  
- **seasonalwork** – information about the ArsMagica seasonal work.  
- **django_migrations** – versioning for database migrations.  

## Installation guide and running the server

On windows 11 (and an ubuntu server):

- Install nginx and get the certificate for https (for your hostname). Use my 'blogs_seasons.conf' (on ubuntu server in '/etc/nginx/sites-available' and in this project in 'nginx' folder). This is the final version of this '.conf' file 'after' the certificate is issued and you need to adapt it to your own server. The 'blogs_and_seasons_temp.conf' is the 'blogs_seasons.conf' file before you retrieve your needed certificate and it may need to be adapted to your own server. Note that for the 'Flask' and 'Django' project 'blogs_seasons.conf' is the same file that is stored on the ubuntu server.

- The python package 'pymemcache' is already set in 'requirements.txt' and is used to cache various results on some of the dynamic web pages. On the ubuntu server you need to make the following installation steps to use 'memcached': ["sudo apt update", "sudo apt install memcached libmemcached-tools -y", "sudo systemctl enable memcached", "sudo systemctl start memcached", ("sudo systemctl status memcached")]. If you have 'Docker Desktop' installed on windows 11 (on your local machine using debug mode) the following steps can be taken to use 'memcache': [docker run -d --name memcached_local -p 11211:11211 memcached:latest]. This command can be used in 'Powershell'.

- To start the virtual environment: python -m venv venvdjango1

- To enable scripts (if necessary): Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

- To activate script and environment: venvdjango1\Scripts\activate

- To install packages: pip install -r requirements.txt

- If you want to install all the package manually then the file 'pip_install_info.txt' can be of use. 

- Don't forget to populate your mysql database, here you can also use 'HeidiSQL'.

- To start the server (in debug mode on your local windows machine and not on your ubuntu production server): python manage.py runserver

- Then write the following in a web browser: localhost:8000 or your own "server adress".

- The django app is running in a docker and the endpoint 'blogs/' by my other program in a containarized Flask app. The nginx and the mysql database is run on a Ubuntu server, they are not dockerized and are run with services on the Ubuntu server. The file 'blogs_seasons.conf' with the use of nginx is needed to configure the different ports that are used to run the programs (the containarized apps: the 'Django app' and the 'Flask app').

## Databases and '.sql' scripts

- In the folder 'heidisql' I have two '.sql' scripts: 'db_arsmagica1_start.sql' (for the database 'db_arsmagica1') and 'db_arsmagica1_test_start.sql' (for the database 'db_arsmagica1_test'). These scripts are used to create the initial tables and populate them with data in the corresponding database (works for the test and production database for your local computer and for your server). Run the .sql script in the corresponding database as an query (past in the text (in a query) from the corresponding script which you can find in the heidisql folder).

- You will need to change the password (or delete and create the users again) by using HeidiSQL or a similar program for the superusers 'admin' and 'joakim' (you will also need to change the password for 'kalle' and / or remove him with his data by logging in as superuser 'joakim'). You will need to keep the superuser 'joakim' since he exists in many places in the code. Do not change the passwords for the test users (and do not delete the following test users): 'test_user_intruder' and 'test_user_gpt_real'. Their passwords are set in the code and should not be changed and you should not delete these users if you want to be able to run the tests in this project on your local machine.

## Environmental variables and secrets

These secrets in your repository must be set (stored in your github repository):
- The secrets in 'deploy.yml' (where 'secrets.' has been added to the code): secrets.SERVER_IP (Ubuntu server ip), secrets.SERVER_ROOT_USERNAME (the username for root, often root) and secrets.SSH_PRIVATE_KEY (your ssh key to connect to the server). They are stored in '.django_env', see '.django_env.example', for how it can look. The 'SecretVault' class (in the file 'secret_vault_class.py') handles these secrets. On the Ubuntu server they are stored in '/etc/secrets/mysql/keys/.django_env'.

## Running pytests

The following Django tests can be run (in 'arsmagica_seasons' folder):

- python manage.py test arsmagica_seasons_app.tests.integration_test --keepdb --verbosity=2

- The file 'integration_test.py' contains the tests to be run on the mysql databases on your local windows machine and not on your Ubuntu server. The tests should not be run on the ubuntu server as not to effect your real production database and if the test works on your local windows machine they will work on the ubuntu server, since they are using the same authorizations and the same endpoints.

## Author

This project is made by Joakim Kvistholm.
