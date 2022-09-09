#!/bin/bash


sources_file_path=/etc/apt/sources.list;
sudo cp $sources_file_path $sources_file_path.bkp;
sudo sed -i 's/br./uy./g' $sources_file_path;