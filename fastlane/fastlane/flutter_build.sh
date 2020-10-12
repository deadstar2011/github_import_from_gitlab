#!/bin/bash
cd ../../
   echo "Running clean..."
   flutter clean
   echo "install dependency..."
   flutter pub get
   echo "Building AAB..."
   flutter build appbundle
