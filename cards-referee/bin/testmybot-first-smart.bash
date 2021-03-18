 #!/usr/bin/bash

raco exe -o mybot ../../lib/santorini-player-main.rkt
./tournament --cards Artemis Demeter mybot play-search

