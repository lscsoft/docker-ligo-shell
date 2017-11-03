FROM ligo/software:stretch

LABEL name="LIGO Software Environment for Debian 9 'stretch' with user shell" \
      maintainer="Tom Downes <thomas.downes@ligo.org>" \
      date="2017-11-03" \
      support="Reference Platform"

COPY /environment/bash/ligo.sh /etc/profile.d/ligo.sh
COPY /environment/etc/fstab /etc/fstab
COPY /environment/sudoers.d/albert /etc/sudoers.d/albert
COPY /entrypoint/startup /usr/local/bin/startup

RUN apt-get update && \
    apt-get install --assume-yes \
      ldg-client \
      emacs-nox \
      sudo \
      vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#      cvmfs \
#      cvmfs-config-osg \
#      cvmfs-x509-helper \

#RUN mkdir /cvmfs/config-osg.opensciencegrid.org && \
#    mkdir /cvmfs/oasis.opensciencegrid.org && \
#    mkdir /cvmfs/singularity.opensciencegrid.org && \
#    mkdir /cvmfs/ligo.osgstorage.org && \

#RUN sed -i 's/#[[:space:]]*user_allow_other/user_allow_other/' /etc/fuse.conf

RUN mkdir /container \
    && useradd -m -d /container/albert -s /bin/bash albert
USER albert
WORKDIR /container/albert
ENTRYPOINT [ "/usr/local/bin/startup" ]
CMD ["/bin/bash", "-l" ]
