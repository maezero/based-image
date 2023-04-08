FROM centos:centos7.9.2009
RUN yum install -y docker git curl unzip zip wget && curl -LO https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && chmod +x kubectl && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install
ENTRYPOINT ["/bin/sh"]