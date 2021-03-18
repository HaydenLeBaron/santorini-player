 #!/usr/bin/bash

raco exe -o mybot ../../lib/santorini-player-main.rkt
./tournament --cards Artemis Demeter play-random mybot

