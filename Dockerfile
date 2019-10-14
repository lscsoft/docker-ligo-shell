FROM containers.ligo.org/docker/software:el7

LABEL name="LIGO Software Environment for Enterprise Linux 7 with user shell" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      support="Reference Platform"

RUN yum -y install \
      cvmfs \
      cvmfs-x509-helper \
      ldg-client \
      sudo \
      vim && \
    yum clean all

COPY /environment/bash/ligo.sh /etc/profile.d/ligo.sh
COPY /environment/etc/fstab /etc/fstab
COPY /environment/cvmfs/default.local /etc/cvmfs/default.local
COPY /environment/sudoers.d/albert /etc/sudoers.d/albert
COPY /entrypoint/startup /usr/local/bin/startup

# ensure sudoers.d/albert has the correct permissions
RUN chmod 440 /etc/sudoers.d/albert

RUN mkdir -p /cvmfs/config-osg.opensciencegrid.org && \
    mkdir /cvmfs/oasis.opensciencegrid.org && \
    mkdir /cvmfs/singularity.opensciencegrid.org && \
    mkdir /cvmfs/ligo.osgstorage.org && \
    mkdir /container

RUN useradd -m -d /container/albert -s /bin/bash albert
USER albert
WORKDIR /container/albert
ENTRYPOINT [ "/usr/local/bin/startup" ]
CMD ["/bin/bash", "-l" ]
