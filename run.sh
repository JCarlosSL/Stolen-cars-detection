#!/usr/bin/env bash
cd

rm /home/xavier/deepstream-5.1/samples/models/Secondary_CarColor/labels.txt
rm /home/xavier/deepstream-5.1/samples/models/Secondary_CarMake/labels.txt
rm /home/xavier/deepstream-5.1/samples/models/Secondary_VehicleTypes/labels.txt

ln -s /home/xavier/Test/Stolen-cars-detection/yolo/files/Secondary_CarColor/labels.txt /home/xavier/deepstream-5.1/samples/models/Secondary_CarColor/
ln -s /home/xavier/Test/Stolen-cars-detection/yolo/files/Secondary_CarMake/labels.txt  /home/xavier/deepstream-5.1/samples/models/Secondary_CarMake/
ln -s /home/xavier/Test/Stolen-cars-detection/yolo/files/Secondary_VehicleType/labels.txt  /home/xavier/deepstream-5.1/samples/models/Secondary_VehicleTypes/

cd /home/xavier/Test/Stolen-cars-detection

python manage.py runserver 192.168.2.2:8000
