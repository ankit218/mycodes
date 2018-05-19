#!/bin/bash

java -version

if [ $? = 0 ]
then
echo "ok to proceed..java is installed.."
else
echo "Install Java & try again"
exit 1
fi

if [ -f /usr/bin/wget ]
then
echo "ok to proceed..wget is installed.."
else
echo "wget is not installed..installing it now.."
yum install wget -y
fi


cd /data/
mv jenkins jenkins_bak

setup_tomcat()
{
mkdir -p /data
cd /data
#wget http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.31/bin/apache-tomcat-8.5.31.tar.gz
wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.31/bin/apache-tomcat-8.5.31.tar.gz
tar -zxvf apache-tomcat-8.5.31.tar.gz
mv /data/apache-tomcat-8.5.31 /data/jenkins
rm /data/apache-tomcat-8.5.31.tar.gz
sed -i.orig.bak 's/8080/8002/g' /data/jenkins/conf/server.xml
}

set_war()
{
cd /data/jenkins/webapps
wget "https://updates.jenkins-ci.org/latest/jenkins.war"
}

set_context_file()
{
echo -e "\n
<Context>
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>\${catalina.base}/conf/web.xml</WatchedResource>
    <Resources cachingAllowed=\"true\" cacheMaxSize=\"100000\" />
</Context>
\n
" > /data/jenkins/conf/context.xml
}

start_jenkins()
{
cd /data/jenkins/bin
./startup.sh
echo -e "\nJenkins installation is complete - http://<Client_IP>:8002/jenkins\n"
}

setup_jenkins()
{
setup_tomcat
set_war
set_context_file
start_jenkins
}

setup_jenkins

