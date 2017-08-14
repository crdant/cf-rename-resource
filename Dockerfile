FROM concourse/buildroot:base

ADD cf /usr/bin/cf

ADD check /opt/resource/check
ADD out /opt/resource/out
ADD in /opt/resource/in
