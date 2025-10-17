
# Django Project – Django ArsMagica Seasons

A **Django web application** that demonstrates clean application structure, database modeling, and testing. This project is connected with my flask project which handles blogs. This project takes care of the endpoint "/" and "seasons/". The project uses **MySQL** as the backend database (but it can easily be switched to another mysql database by editing a single configuration class).

This project has been adapted and extended from the Flask project for further development by **Joakim Kvistholm** to work with 'real' mysql database and to make seasonal work easier for ArsMagica. In this project I use a mysql server for both the test and production database which are running by docker and I am using HeidiSQL as an extra database handler. All this takes the program one step closer to work as a 'real' web page with a 'real' production database on a server.  

---

## Features  

- User authentication with hashed passwords.  
- Seasonal work posts with users, timestamps, summary and description.
- The summary from the description is made by openai's ChatGPT if it is left out.  
- Relational database schema with proper foreign keys.  
- Django database migrations.  
- Configurable database connection via `DatabaseConnectionData`.  
- Uses Django tests that tests towards 'real' mysql databases.  
- Structured project layout for maintainability.  

## Extra Information

All users can create a password that has at least 8 letters. Two superusers admin and another name should be created, see 'pip_install_info.txt'. At least one more users will be a good addition to the superusers, but you can easily create them with the web page.

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

- Install nginx and get the certificate for https (for your hostname). Use my 'blogs_seasons.conf' (on ubuntu server in '/etc/nginx/sites-available' and in this project in 'nginx' folder). This is the final version of this file 'after' the certificate is issued and you need to adapt it to your own server. The 'blogs_and_seasons_temp.conf' is the 'blogs_seasons.conf' file before you retrieve your needed certificate and it may need to be adapted to your own server. Note that for the Flask and Django project 'blogs_seasons.conf' is the same file that is stored on the ubuntu server.

- To start the virtual environment: python -m venv venvdjango1

- To enable scripts (if necessary): Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

- To activate script and environment: venvdjango1\Scripts\activate

- To install packages: pip install -r requirements.txt

- If you want to install all the package manually then the file 'pip_install_info.txt' can be of use. 

- Don't forget to populate your mysql database, here you can also use 'HeidiSQL'.

- To start the server (in debug mode on your local windows machine and not on your ubuntu production server): python manage.py runserver

- Then write the following in a web browser: localhost:8000 or your own "server adress".

- The django app is running in a docker and the endpoint 'blogs/' by my other program in a containarized Flask app. The nginx and the mysql database is run on a ubuntu server, they are not dockerized and are run with services on the ubuntu server. The file 'blogs_seasons.conf' is needed to configure the different ports that are used to run the programs (the containarized apps: the 'Django app' and the 'Flask app').

## Environmental variables and secrets

There are two environmental variables which are recommended to be set on the Ubunbtu server:
- MYSQL_GIT_JK_USERNAME and MYSQL_GIT_JK_PASSWORD which is your username and password for the none root user for mysql.

These secrets in your repository must be set (stored in your github repository):
- The secrets in 'deploy.yml' (where 'secrets.' has been added to the code): secrets.SERVER_IP (Ubuntu server ip), secrets.SERVER_ROOT_USERNAME (the username for root, often root) and secrets.SSH_PRIVATE_KEY (your ssh key to connect to the server). They are stored in '.django_env', see '.django_env.example', for how it can look. The 'SecretVault' class (in the file 'secret_vault_class.py') handles these secrets.

## Running pytests

The following Django tests can be run (in 'arsmagica_seasons' folder):

- python manage.py test arsmagica_seasons_app.tests.integration_test --keepdb --verbosity=2

- The file 'integration_test.py'

## Author

This project is made by Joakim Kvistholm.
