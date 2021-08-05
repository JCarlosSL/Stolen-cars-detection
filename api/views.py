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

class RegisterView(generics.GenericAPIView):
    serializer_class = DataSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        task = threading.Thread(target=predictionYolo,args=[user])
        task.setDaemon(True)
        task.start()


        return Response(serializer.data, status=status.HTTP_200_OK)


def predictionYolo(user):
    #output = os.popen('flutter doctor {0}'.format('file')).read()
    #print(output)
    f = File(open('yolo/input.png'),'rb')

    datapred = DataPrediction(user=user)
    datapred.image = 'input.png'
    datapred.save()

class DetailPrediction(APIView):
    #serializer_class = DataViewSerializer

    def get(self,request, pk=None):
        user = DataFormulario.objects.get(pk=pk)

        pre_image = DataPrediction.objects.filter(user=user)

        detail_serializer = DataViewSerializer(pre_image,many=True)
        return Response(detail_serializer.data,status=status.HTTP_200_OK)