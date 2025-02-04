FROM maven:3.8.6-openjdk-11

# Définir le répertoire de travail
WORKDIR /usr/src/tests

# Copier le fichier `pom.xml`
COPY pom.xml /usr/src/tests/

# Télécharger les dépendances Maven sans exécuter les tests
RUN mvn dependency:resolve

# Monter le code source après pour éviter d'invalider le cache des dépendances
COPY src /usr/src/tests/src

# Créer un fichier de log Maven
RUN echo "logfile=mvn_output.log" > /usr/src/tests/logs.properties

# Commande par défaut pour compiler sans exécuter les tests, puis tail sur le fichier de log
CMD mvn install -DskipTests > /usr/src/tests/mvn_output.log 2>&1 && tail -f /usr/src/tests/mvn_output.log
