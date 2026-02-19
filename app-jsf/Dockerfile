FROM quay.io/wildfly/wildfly:37.0.0.Final-jdk21
COPY target/app-jsf.war /opt/jboss/wildfly/standalone/deployments/ROOT.war

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]