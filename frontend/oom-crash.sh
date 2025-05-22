#!/bin/sh
echo "💥 Simulating memory overload..."
python3 -c "a = ['A' * 1024 * 1024] * 1000"
