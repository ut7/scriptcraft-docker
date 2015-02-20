FROM itzg/ubuntu-openjdk-7

EXPOSE 25565

RUN useradd -M -s /bin/false --uid 1000 minecraft \
  && mkdir /data \
  && mkdir -p /data/plugins \
  && mkdir -p /data/config/worlds/default \
  && chown -Rh minecraft:minecraft /data

ADD src/start /data/start
RUN chmod +x /data/start

USER minecraft
WORKDIR /data

ADD out/canarymod.jar canarymod.jar
ADD out/scriptcraft.jar plugins/scriptcraft.jar
ADD out/world.cfg config/worlds/default/default_NORMAL.cfg

RUN cd /data; java -jar canarymod.jar noControl

RUN cd /data \
  && sed -i 's/false/true/' eula.txt \
  && sed -i '/^player-idle-timeout=/ s/=.*$/=120/'       config/server.cfg \
  && sed -i '/^server-locale=/       s/=.*$/=fr_FR/'     config/server.cfg \
  && sed -i '/^motd=/                s/=.*$/=Gnancraft/' config/server.cfg

CMD [ "/data/start"] 
