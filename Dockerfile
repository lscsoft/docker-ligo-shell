FROM ligo/software:el7

LABEL name="LIGO Software Environment for Enterprise Linux 7 with user shell" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170607" \
      support="Reference Platform"

COPY /environment/bash/ligo.sh /etc/profile.d/ligo.sh

RUN useradd -ms /bin/bash albert
USER albert
WORKDIR /home/albert
CMD /bin/bash -l
