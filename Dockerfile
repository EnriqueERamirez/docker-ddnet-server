# Usa una imagen base de Debian, ya que DDNet generalmente funciona bien en Debian
FROM debian:latest

# Instalar las dependencias necesarias
RUN apt-get update && apt-get install -y \
    wget \
    libstdc++6 \
    libgcc1 \
    xz-utils \
    libcurl4 \
    && rm -rf /var/lib/apt/lists/*

# Define el directorio de trabajo
WORKDIR /ddnet

# Descarga el servidor DDNet
#RUN wget https://ddnet.tw/downloads/DDNet-Server-<VERSION>.tar.xz
RUN wget https://ddnet.org/downloads/DDNet-17.3-linux_x86_64.tar.xz
RUN tar -xf DDNet-17.3-linux_x86_64.tar.xz
RUN rm DDNet-17.3-linux_x86_64.tar.xz
RUN mv ./DDNet-17.3-linux_x86_64 ./DDNet-Server
RUN rm -R ./DDNet-Server/data
RUN mkdir ./DDNet-Server/data
# Descomprime el archivo
#RUN tar -xf DDNet-Server-<VERSION>.tar.xz

# Limpia el archivo comprimido
#RUN rm DDNet-Server-<VERSION>.tar.xz

# Expone el puerto predeterminado del servidor DDNet
EXPOSE 8303/udp

# Configura el volumen para la configuración personalizada y los mapas
VOLUME ["/ddnet/data"]

# Define el comando para ejecutar el servidor
CMD ["./DDNet-Server/DDNet-Server"]

