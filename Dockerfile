FROM fedora
MAINTAINER "Brent Baude" <bbaude@redhat.com>
ENV container docker
RUN dnf -y update && dnf clean all
RUN dnf -y install systemd
RUN dnf -y install virt-viewer virt-install libvirt-client && dnf clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*

VOLUME [ "/var/lib/libvirt/" ]
CMD ["/usr/sbin/init"]

RUN echo 'uri_default = "qemu+tcp://libvirtd/system"' >> /etc/libvirt/libvirt.conf

RUN dnf -y install xorg-x11-xauth && dnf clean all
