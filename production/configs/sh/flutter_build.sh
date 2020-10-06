#!/bin/bash
cd ../../
if [ "$1" == "--build" ]
then
   echo "Running clean..."
   flutter clean
   echo "install dependency..."
   flutter pub get
   echo "build abb..."
   flutter build appbundle
else
   echo "Skipping..."
fi

