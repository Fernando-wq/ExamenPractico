#!/usr/bin/bash 
listado=$(yum list installed | grep '^clamav')
version=$(grep 'VERSION_ID' /etc/os-release)

echo '-------------------------------revisando la version-------------------------------'
if [[ $version = 'VERSION_ID="8"' ]];
then
 
  echo -e "-------------------------------es CentOS v8-------------------------------"
  
  if [[ $listado = "" ]];
  then
    echo -e "-------------------------------instalando clamAV-------------------------------"
    sudo yum -y install https://www.clamav.net/downloads/production/clamav-0.104.1.linux.x86_64.rpm

  else
    echo -e "-------------------------------clamAV ya esta instalado, se desinstalara para reinstalarlo-------------------------------"
    sudo yum -y erase clamav*
    sudo yum -y install https://www.clamav.net/downloads/production/clamav-0.104.1.linux.x86_64.rpm
  fi

elif [[ $version = 'VERSION_ID="7"' ]];
then
  echo -e "-------------------------------es CentOS v7-------------------------------"
  echo -e "-------------------------------instalando EPEL-------------------------------"
  sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
 
 if [[ $listado = "" ]];
  then
    echo -e "-------------------------------instalando clamAV-------------------------------"
    sudo yum -y install clamav
 
  else
    echo -e "-------------------------------clamAV ya esta instalado, se desinstalara para reinstalarlo-------------------------------"
    sudo yum -y erase clamav*
    sudo yum -y install clamav
  fi
fi

if [[ $(yum check-update -q | awk '{print $1}') = "" ]];
then
  echo -e "-------------------------------No hay paquetes que ocupen actualizarse-------------------------------" 
else
  echo -e "-------------------------------los siguientes paquetes necesitan actualizarse-------------------------------" 
    sudo yum check-update -q | awk '{print $1}'
  for line in $(yum check-update -q | awk '{print $1}');
  do
    sudo yum -y update $line
done
echo '------------------------------------------------------------------------------'
echo '------------------------------------------------------------------------------'
echo '------------------------------------------------------------------------------'
echo '-------------------------------fin del programa-------------------------------'
echo '------------------------------------------------------------------------------'
echo '------------------------------------------------------------------------------'
echo '------------------------------------------------------------------------------'
exit 0
fi
