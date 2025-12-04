# Base JRE maintenue
FROM eclipse-temurin:11-jre

# Version d'OpenRefine
ENV REFINE_VERSION=3.8.2

# Télécharger et extraire le binaire officiel
RUN apt-get update && apt-get install -y wget ca-certificates && \
    wget -q https://github.com/OpenRefine/OpenRefine/releases/download/${REFINE_VERSION}/openrefine-linux-${REFINE_VERSION}.tar.gz && \
    tar -xzf openrefine-linux-${REFINE_VERSION}.tar.gz && \
    rm openrefine-linux-${REFINE_VERSION}.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Répertoire de travail
WORKDIR /openrefine-${REFINE_VERSION}

# Exposer le port interne par défaut (Railway utilise sa propre variable PORT)
EXPOSE 3333

# Mémoire (modifiable via ENV Railway si besoin)
ENV REFINE_MEMORY=1400M
ENV REFINE_MIN_MEMORY=512M

# PORT dynamique fourni par Railway
ENV PORT=3333

# Commande de démarrage avec port dynamique
CMD ["sh", "-c", "./refine -i 0.0.0.0 -d /data -p $PORT"]
