#!/bin/bash

kubectl patch service my-app-green -p '{"spec":{"selector":{"version":"v1.0.0"}}}'