# Start from the Red Hat Universal Base Image with Apache httpd 2.4
FROM  --platform=linux/amd64 registry.access.redhat.com/ubi8/httpd-24

# installed required software
USER root
RUN dnf -y update
RUN dnf -y install tar wget nano net-tools procps


# (Optional) Copy your custom web content into the default document root.
COPY index.html /var/www/html/index.html

# Disable the SSL configuration for testing currently. Import the certificate if using SSL
#(rename it so it won't be loaded)
RUN mv /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.disabled

# Add ServerName directive to suppress the warning
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf


# AppDynamics configuration
# Copying the custom config file for AppD agent
COPY ./appdynamics_agent.conf /etc/httpd/conf/appdynamics_agent.conf

# Expose HTTP port 8080
EXPOSE 8080

WORKDIR /appd

#Copy the agent files
COPY ./appdynamics-sdk-native-nativeWebServer-64bit-linux-24.11.0.2449.tgz ./

# Extracting the file downloaded
RUN tar -xzvf appdynamics*.tgz -C /opt

# Specifying the path for the required libraries
#ENV LD_LIBRARY_PATH="/opt/appdynamics-sdk-native/sdk_lib/lib/"
ENV LD_LIBRARY_PATH="/opt/appdynamics-sdk-native/sdk_lib/lib/:$LD_LIBRARY_PATH"

# Including the appdynamics config file into the original httpd configuration
RUN echo "Include /etc/httpd/conf/appdynamics_agent.conf" >> /etc/httpd/conf/httpd.conf

# Running apache agent installation script
RUN /opt/appdynamics-sdk-native/install.sh

# Running the httpd server in foreground
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
