# Sequence Diagrams

## actors
```flow
alias u="user"
alias o="OysterCard"
alias j="Journey"
alias s="Station"
```

## complete journey
```flow
u->o: "touch_in(station)"
o->j: "new_journey(station)"
j-->o: "new_journey"
u->o: "touch_out(station)"
o->o: "journey.exit_station = station"
o->o: "journeys << journey"
```

## no touch in
```flow
u->o: "touch_out(station)"
o->o: "unless current_journey?"
o->j: "Journey.new(exit_station)"
j-->o: "incomplete journey"
o->o: "journeys << incomplete journey"
```

## no touch in
```flow
u->o: "touch_in(station)"
o->o: "journeys << current_journey if current_journey"
o->j: "Journey.new(entry_station)"
j-->o: "journey"
o->o: "self.current_journey = journey"
```
