# build servlet and create war file
FROM maven:latest AS warfile
WORKDIR /usr/src/testdemo
COPY pom.xml .
RUN mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
COPY . .
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package

FROM tomcat:9.0-jre8-alpineINTAINER Sophia Parafina <sophia.parafina@docker.com>

# build servlet and create war file
FROM maven:latest AS warfile
WORKDIR /usr/src/testdemo
COPY pom.xml .
RUN mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
COPY . .
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package

FROM tomcat:9.0-jre8-alpine
# ADD tomcat/catalina.sh $CATALINA_HOME/bin/
WORKDIR /usr/local/tomcat/bin
COPY run.sh run.sh
RUN chmod +x run.sh
#Copy war file
WORKDIR /usr/local/tomcat/webapps
COPY  --from=warfile /usr/src/testdemo/target/testDeploy.war testDeploy.war

# ADD tomcat/catalina.sh $CATALINA_HOME/bin/
WORKDIR /usr/local/tomcat/bin
COPY run.sh run.sh
RUN chmod +x run.sh
#Copy war file
WORKDIR /usr/local/tomcat/webapps
COPY  --from=warfile /usr/src/catweb/testdemo/testDeploy.war testDeploy.war
# Expose ports
ENV JPDA_ADDRESS="8000"
ENV JPDA_TRANSPORT="dt_socket"
EXPOSE 8080                                                                                                                  29,1          Top
