FROM centos:7

MAINTAINER "Björn Dieding" <bjoern@xrow.de>

ADD RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
ADD epel.repo /etc/yum.repos.d/epel.repo

USER root
RUN yum install -y ansible dbus
RUN yum -y install python-pip redis
RUN pip install redis
ADD test.yml test.yml
RUN echo "[ezcluster]" > /etc/ansible/hosts  
RUN echo "localhost" >> /etc/ansible/hosts
RUN ansible-playbook -c local test.yml -vvvv
CMD ["/bin/bash"]

# Run it
# docker build -f Dockerfile -t bash .
# docker run --privileged -d bash:latest