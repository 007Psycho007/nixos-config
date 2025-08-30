#!/bin/bash

print_data() {
    cat << EOF
{
	"id": "00000",
	"distribution": "Debian",
	"version": "12",
	"cpu": "i7 0000",
	"memory": "128",
	"disk": "125"
}
EOF
}

curl -X POST http://localhost:5000/label \
     -H "Content-Type: application/json" \
     -d "$(print_data)"
