FROM openjdk:11-jre-slim

# --- Version d'OpenRefine à récupérer ---
ENV REFINE_VERSION=3.8.2

# --- Téléchargement du binaire officiel ---
RUN apt-get update && apt-get install -y wget ca-certificates && \
    wget -q https://github.com/OpenRefine/OpenRefine/releases/download/${REFINE_VERSION}/openrefine-linux-${REFINE_VERSION}.tar.gz && \
    tar -xzf openrefine-linux-${REFINE_VERSION}.tar.gz && \
    rm openrefine-linux-${REFINE_VERSION}.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# --- Répertoire de travail ---
WORKDIR /openrefine-${REFINE_VERSION}

# --- Ports ---
EXPOSE 3333

# --- Mémoire (compatible Railway) ---
ENV REFINE_MEMORY=1400M
ENV REFINE_MIN_MEMORY=512M

# --- Dossier pour stocker les projets OpenRefine ---
VOLUME /data

# --- Commande de démarrage ---
CMD ["./refine", "-i", "0.0.0.0", "-d", "/data", "-p", "3333"]
