#FROM ubuntu:latest
FROM java:8
MAINTAINER Silva Song "silva.song@aliyun.com"

WORKDIR /code
ADD README.md /code/README.md

#安装JDK8
#添加ppa
#RUN apt-get update -y                             && \
#    apt-get install software-properties-common python-software-properties -y && \
#    add-apt-repository ppa:webupd8team/java -y    && \
#    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
#    apt-get update -y                             && \
#    apt-get install oracle-java8-installer -y
#RUN java -version

#挂载宿主机目录到容器
#VOLUME ~/smilepy/Downloads/dockersoft

#安装tomcat
#RUN mkdir /var/tmp/tomcat
#RUN wget -P /var/tmp/tomcat http://mirrors.hust.edu.cn/apache/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz
#RUN mv ~/smilepy/Downloads/dockersoft/apache-tomcat-9.0.0.M10.tar.gz /var/tmp/tomcat
#RUN tar xzf /var/tmp/tomcat/apache-tomcat-9.0.0.M10.tar.gz -C /var/tmp/tomcat
#RUN rm -rf /var/tmp/tomcat/apache-tomcat-9.0.0.M10.tar.gz

#安装maven
#RUN mkdir /var/tmp/maven

#RUN wget -P /var/tmp/maven http://mirrors.cnnic.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
#RUN mv  ~/smilepy/Downloads/dockersoft/apache-maven-3.3.9-bin.tar /var/tmp/maven
#RUN tar xzf /var/tmp/maven/apache-maven-3.3.9-bin.tar -C /var/tmp/maven
#RUN rm -rf /var/tmp/maven/apache-maven-3.3.9-bin.tar
#设置maven环境变量
#ENV MAVEN_HOME=/var/tmp/maven/apache-maven-3.3.9
#ENV PATH=$MAVEN_HOME/bin:$PATH



RUN mkdir /var/tmp/webapp
ADD ./ /var/tmp/webapp
RUN cd /var/tmp/webapp && mvn package && cp /var/tmp/webapp/target/CIJD.war /var/tmp/tomcat/apache-tomcat-9.0.0/webapps

EXPOSE 8080

CMD ["./var/tmp/tomcat/apache-tomcat-9.0.0/bin/catalina.sh","run"]

