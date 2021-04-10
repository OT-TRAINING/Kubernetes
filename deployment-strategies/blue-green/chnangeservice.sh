#!/bin/bash

kubectl patch service my-app-green -p '{"spec":{"selector":{"version":"v2.0.0"}}}'