#!/bin/bash

cat <<'EOT' > /startapp.sh
#!/bin/bash
MediaElch
EOT

cat <<'EOT' > /etc/my_init.d/04_MediaElch_config.sh
#!/bin/bash
## Create Directories needed
[[ ! -d /config/config/ ]] && mkdir /config/config -p
[[ ! -d /config/log/ ]] && mkdir -p /config/log/
 [[ ! -d /config/images/ ]] && mkdir -p  /config/images/
[[ ! -d /nobody/.config/kvibes/ ]] && mkdir -p /nobody/.config/kvibes/
[[ ! -d /nobody/.local/share/kvibes/MediaElch/ ]] && mkdir -p /nobody/.local/share/kvibes/MediaElch/ 
## Copy needed config files
[[ ! -e /config/config/MediaElch.conf ]] && cp /MediaElch_Config/MediaElch.conf /config/config/MediaElch.conf
[[ ! -e /config/MediaElch.sqlite ]] && cp /MediaElch_Config/MediaElch.sqlite /config/MediaElch.sqlite
[[ ! -e /config/config/advancedsettings.xml ]] && cp /MediaElch_Config/advancedsettings.xml /config/advancedsettings.xml
[[ ! -e /config/log/MediaElch.log ]]  && touch /config/log/MediaElch.log
## Create symlinks to files and directories used by MediaElch
[[ ! -L /nobody/.config/kvibes/MediaElch.conf ]] && ln -s /config/config/MediaElch.conf /nobody/.config/kvibes/MediaElch.conf
[[ ! -L /nobody/.local/share/kvibes/MediaElch/MediaElch.sqlite ]] && ln -s /config/MediaElch.sqlite /nobody/.local/share/kvibes/MediaElch/MediaElch.sqlite
[[ ! -L /nobody/.local/share/kvibes/MediaElch/advancedsettings.xml ]] && ln -s /config/config/advancedsettings.xml  /nobody/.local/share/kvibes/MediaElch/advancedsettings.xml 
[[ ! -L /nobody/.local/share/kvibes/MediaElch/images ]] && ln -s /config/images/ /nobody/.local/share/kvibes/MediaElch/
[[ ! -L /nobody/.local/share/kvibes/MediaElch/export_themes ]] && ln -s /config/export_themes/ /nobody/.local/share/kvibes/MediaElch/

chown -R nobody:users /config /nobody
EOT

# Add repository for kvibe MediaElch  
add-apt-repository ppa:kvibes/mediaelch 
## Apt-Get MediaElch
apt-get update -qq && apt-get install -qqy mediaelch

#Copy startapp.sh script
chmod +x /startapp.sh
chmod -R +x /etc/my_init.d/

# Move Config Files for setup
mv /tmp/conf/ /MediaElch_Config/

#cleanup apt-get
apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

exit