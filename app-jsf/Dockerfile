FROM quay.io/wildfly/wildfly:latest

COPY app-jsf/target/app-jsf.war /opt/jboss/wildfly/standalone/deployments/ROOT.war
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]