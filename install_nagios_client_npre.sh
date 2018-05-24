rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y nrpe nagios-plugins-all

read -p "Enter your server host private IP Address" ser_pip

echo -e "\nModify the NRPE configuration file to accept the connection from the Nagios server, Edit the /etc/nagios/nrpe.cfg file.

allowed_hosts=127.0.0.1,$ser_pip

"
systemctl start nrpe
systemctl enable nrpe