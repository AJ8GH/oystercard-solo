```flow

alias u="user"
alias o="OysterCard"
alias j="Journey"
alias s="Station"

# complete journey
u->o: "touch_in(station)"
o->j: "new_journey(station)"
j-->o: "new_journey"
u->o: "touch_out(station)"
o->o: "journey.exit_station = station"
o->o: "journeys << journey"
```
