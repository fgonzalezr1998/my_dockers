#! /bin/sh

docker run --rm -it --name fercraft --hostname fercraft \
--volume /home/fernando/Github_Repos/Minecraft_Server:/home/fernando/Minecraft_Server \
fgonzalezr1998/fercraftserver