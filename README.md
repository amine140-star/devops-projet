# TP DevOps – Projet Angular avec Docker & CI/CD

Ce projet met en œuvre une application Angular conteneurisée avec Docker et automatisée avec GitHub Actions.  
📁 Nom du dépôt GitHub : `devops-projet`

---

## 1. Initialisation du projet Git

```bash
git init
git remote add origin https://github.com/amine140-star/devops-projet.git
git add .
git commit -m "Initial commit"
git push -u origin main
➡️ Le fichier .gitignore exclut node_modules, /dist, .vscode/, *.log, etc.

🐳 2. Conteneurisation avec Docker
 #Dockerfile
dockerfile
Copy
Edit
FROM nginx:alpine
COPY ./dist/projet-angular-main /usr/share/nginx/html
 Ce fichier copie le build Angular dans un serveur Nginx léger.

  #docker-compose.yml
yaml
Copy
Edit
version: '3'
services:
  angular-app:
    build: .
    ports:
      - "4200:80"
Ce fichier permet de lancer facilement le conteneur avec docker-compose up.

 #Commandes utiles
bash
Copy
Edit
docker build -t angular-ci .        # Build manuel de l’image
docker run -p 4200:80 angular-ci    # Tester manuellement
docker-compose up                   # Lancer avec Docker Compose
 #3. Automatisation avec GitHub Actions (CI/CD)
.github/workflows/ci.yml
yaml
Copy
Edit
name: CI Angular Docker

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Récupérer le code
        uses: actions/checkout@v3

      - name: Installer Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18

      - name: Installer les dépendances
        run: npm install

      - name: Build Angular app
        run: npm run build --prod

      - name: Build Docker image
        run: docker build -t angular-ci .

      - name: Connexion à Docker Hub
        run: echo "${{ secrets.DOCKER_PASSWORD }}" | docker login -u "${{ secrets.DOCKER_USERNAME }}" --password-stdin

      - name: Push de l’image Docker
        run: |
          docker tag angular-ci amine/angular-ci:latest
          docker push amine/angular-ci:latest

      - name: Fin du pipeline
        run: echo "Build et push terminés"
 #Résumé :

- Récupère le code

- Installe les dépendances

- Compile l’app Angular

- Crée une image Docker

- Push sur Docker Hub automatiquement

- 4. Tests
Test du pipeline CI/CD
Déclenché automatiquement sur push ou pull_request vers main

Suivi via l’onglet Actions de GitHub

Test manuel de l’image Docker
bash
Copy
Edit
docker pull amine/angular-ci:latest
docker run -p 4200:80 amine/angular-ci
➡️ Ouvrir http://localhost:4200




# Twin4Project

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 13.3.0.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The application will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI Overview and Command Reference](https://angular.io/cli) page.

✅ Pipeline test déclenché le 15 avril



