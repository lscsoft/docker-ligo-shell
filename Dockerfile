FROM containers.ligo.org/docker/software:stretch

LABEL name="LIGO Software Environment for Debian 9 'stretch' with user shell" \
      maintainer="Shawn Kwang <shawn.kwang@ligo.org>" \
      date="20190909" \
      support="Reference Platform"

COPY /environment/bash/ligo.sh /etc/profile.d/ligo.sh
COPY /environment/etc/fstab /etc/fstab
COPY /environment/sudoers.d/albert /etc/sudoers.d/albert
COPY /entrypoint/startup /usr/local/bin/startup

RUN apt-get update && \
    apt-get install --assume-yes \
      cvmfs \
      cvmfs-config-osg \
      cvmfs-x509-helper \
      ldg-client \
      emacs-nox \
      sudo \
      vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY /environment/cvmfs/default.local /etc/cvmfs/default.local

RUN mkdir -p /cvmfs/config-osg.opensciencegrid.org && \
    mkdir /cvmfs/oasis.opensciencegrid.org && \
    mkdir /cvmfs/singularity.opensciencegrid.org && \
    mkdir /cvmfs/gwosc.osgstorage.org && \
    mkdir /container

RUN useradd -m -d /container/albert -s /bin/bash albert
USER albert
WORKDIR /container/albert
ENTRYPOINT [ "/usr/local/bin/startup" ]
CMD ["/bin/bash", "-l" ]
