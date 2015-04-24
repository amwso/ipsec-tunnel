FROM centos:6
MAINTAINER HJay <trixism@qq.com>

RUN echo 'HISTFILE=/dev/null' >> /.bashrc ; \
 HISTSIZE=0 ; \
 yum makecache; \
 cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ; \
 sed -i 's/UTC=yes/UTC=no/' /etc/default/rcS ; \
 yum install -y openswan ; \

ADD sbin /root/sbin
ADD template /root/template

EXPOSE 500
