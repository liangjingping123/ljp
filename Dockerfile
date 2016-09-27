#FROM ubuntu:latest
FROM java:8
MAINTAINER smilepy "peiyu617@163.com"


#安装JDK8
#添加ppa
#RUN apt-get update -y                             && \
#    apt-get install software-properties-common python-software-properties -y && \
#    add-apt-repository ppa:webupd8team/java -y    && \
#    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
#    apt-get update -y                             && \
#    apt-get install oracle-java8-installer -y
#RUN java -version


#安装tomcat
RUN mkdir /var/tmp/tomcat
RUN wget -P /var/tmp/tomcat http://mirror.bjtu.edu.cn/apache/tomcat/tomcat-9/v9.0.0.M6/bin/apache-tomcat-9.0.0.M6.tar.gz
RUN tar xzf /var/tmp/tomcat/apache-tomcat-9.0.0.M6.tar.gz -C /var/tmp/tomcat
RUN rm -rf /var/tmp/tomcat/apache-tomcat-9.0.0.M6.tar.gz

#安装maven
RUN mkdir /var/tmp/maven
RUN wget -P /var/tmp/maven http://mirror.bjtu.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar xzf /var/tmp/maven/apache-maven-3.3.9-bin.tar.gz -C /var/tmp/maven
RUN rm -rf /var/tmp/maven/apache-maven-3.3.9-bin.tar.gz

#设置maven环境变量
ENV MAVEN_HOME=/var/tmp/maven/apache-maven-3.3.9
ENV PATH=$MAVEN_HOME/bin:$PATH



RUN mkdir /var/tmp/webapp
ADD ./ /var/tmp/webapp
RUN cd /var/tmp/webapp && mvn package && cp /var/tmp/webapp/target/CIJD.war /var/tmp/tomcat/apache-tomcat-9.0.0.M6/webapps

EXPOSE 8080

CMD ["./var/tmp/tomcat/apache-tomcat-9.0.0.M6/bin/catalina.sh","run"]

