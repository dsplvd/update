#!/bin/bash
clear
echo 'Introduzca Mall:'
read mall
echo 'Introduzca carpeta sistema:'
read mcorto
echo 'Introduza IDTotem:'
read totem
echo 'Introduzca Posicion Totem en X:'
read totemx
echo 'Introduzca Posicion Totem en Y:'
read totemy
echo 'Introduzca Piso del Totem:'
read totempiso
echo 'Introduzca Orientacion Totem:'
read totemo
echo 'Introduzca Puerto SSH del Totem:'
read totemssh
cat > totem.js << EOL
exports.mall = '${mall}';
exports.totem = '${totem}';
exports.postotem = { x: ${totemx}, y: ${totemy} };
exports.pisototem = ${totempiso};
exports.ototem = '${totemo}'
EOL
cat > rabbitmq.config << EOL
[
 {rabbitmq_shovel,
    [ {shovels, [ {${mcorto}${totem}, [ {sources, [{broker,"amqp://guest:guest@localhost:5672"}]}
                , {destinations, [{broker,"amqp://guest:guest@192.168.1.40:5672"}]}
                , {queue, <<"totem">>}
                , {ack_mode, on_confirm}
                , {publish_properties, [{delivery_mode, 2}]}
                , {reconnect_delay, 5}
                ]}
                ]}
    ]}
].
EOL
cat > tunnel << EOL
#!/bin/sh
AUTOSSH_GATE=0
export AUTOSSH_GATETIME
sudo su -c "sudo autossh -M 0 -N -R ${totemssh}:localhost:22 -o 'ServerAliveInterval 60' -o 'ServerAliveCountMax 3' -o 'StrictHostKeyChecking=no' -o 'BatchMode=yes' -i /home/ddmallplaza/.ssh/id_rsa uber@futura.bigbox.info" ddmallplaza
EOL
sudo rm /etc/rabbitmq/rabbitmq.config
sudo rm /etc/network/if-up.d/tunnel
sudo rm /home/ddmallplaza/mall/${mcorto}/totem.js
sudo cp rabbitmq.config /etc/rabbitmq/rabbitmq.config
sudo chown root:root /etc/rabbitmq/rabbitmq.config
sudo cp tunnel /etc/network/if-up.d/tunnel
sudo chown root:root /etc/network/if-up.d/tunnel
sudo chmod +x /etc/network/if-up.d/tunnel
cp totem.js /home/ddmallplaza/mall/${mcorto}/totem.js
rm totem.js
rm tunnel
rm rabbitmq.config
