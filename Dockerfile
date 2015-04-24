FROM centos:6
MAINTAINER HJay <trixism@qq.com>

RUN echo 'HISTFILE=/dev/null' >> ~/.bashrc ; \
 HISTSIZE=0 ; \
 cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ; \
 echo "ip_resolve=4" >> /etc/yum.conf ; \
 sed -i -e 's/^#baseurl=/baseurl=/g' -e 's/^mirrorlist=/#mirrorlist=/g' -e 's/mirror.centos.org/mirrors.ustc.edu.cn/g' /etc/yum.repos.d/CentOS-Base.repo ; \
 echo -e "[epel]\nname=epel\nbaseurl=http://mirrors.ustc.edu.cn/epel/6/\$basearch\nenabled=1\ngpgcheck=0" > /etc/yum.repos.d/epel-tmp.repo ; \
 yum clean all ; \
 yum makecache ; \
 yum -y update ; \
 yum -y install \
 epel-release \
 wget supervisor python-setuptools openswan pwgen \
 ; \ 
 easy_install mr.laforge ; \
 rm -f /etc/yum.repos.d/epel-tmp.repo

ADD sbin /root/sbin
ADD template /root/template

RUN chmod +x /root/sbin/init.sh

EXPOSE 500/udp 80/tcp

ENTRYPOINT ["/root/sbin/init.sh"]
