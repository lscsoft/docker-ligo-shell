FROM ligo/software:jessie

LABEL name="LIGO Software Environment for Debian Jessie with user shell" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170605" \
      support="Reference Platform"

RUN useradd -ms /bin/bash albert
USER albert
WORKDIR /home/albert
CMD /bin/bash -l
