#!/bin/bash
curl "http://localhost:3689/login?pairing-guid=0x1&request-session-id=50"
curl "http://localhost:3689/ctrl-int/1/playpause?session-id=50"
curl "http://localhost:3689/logout?session-id=50"
