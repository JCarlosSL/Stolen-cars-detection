from django.shortcuts import render
from api.serializers import DataSerializer, DataViewSerializer
from rest_framework import generics, status
from rest_framework.response import Response
from django.core.files.storage import FileSystemStorage
from django.core.files import File
import os
import threading
from api.models import DataFormulario, DataPrediction
from rest_framework.views import APIView
from django.http import Http404

from os import getcwd, scandir
from os.path import abspath
import time

class RegisterView(generics.GenericAPIView):
    serializer_class = DataSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        task = threading.Thread(target=predictionYolo,args=[user])
        task.setDaemon(True)
        task.start()

        task1 = threading.Thread(target=loadImageToDataBase,args=[user])
        task1.setDaemon(True)
        task1.start()

        return Response(serializer.data, status=status.HTTP_200_OK)

class DataListView(APIView):
    def get(self, request, *args, **kwargs):
        data = DataFormulario.objects.all()
        data_serializer = DataSerializer(data, many=True)

        return Response(data_serializer.data, status=status.HTTP_200_OK)

def ls(ruta = getcwd()):
    return [arch.name for arch in scandir(ruta) if arch.is_file()]

def predictionYolo(user):
    output = os.popen('sh /home/xavier/deepstream.sh').read()
    #print(output)
    #f = File(open('yolo/input.png'),'rb')
    print("")

def loadImageToDataBase(user):
    time.sleep(0.3)
    if os.listdir('yolo/imagen/'):
        files = ls('yolo/imagen')
        for _file in files:
            datapred = DataPrediction(user=user)
            datapred.image = 'imagen/' + _file
            datapred.save()

class DetailPrediction(APIView):
    #serializer_class = DataViewSerializer

    def get(self,request, pk=None):
        user = DataFormulario.objects.get(pk=pk)

        pre_image = DataPrediction.objects.filter(user=user)

        detail_serializer = DataViewSerializer(pre_image,many=True)
        return Response(detail_serializer.data,status=status.HTTP_200_OK)
