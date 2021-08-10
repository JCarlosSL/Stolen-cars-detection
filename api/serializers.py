from rest_framework import serializers
from api.models import DataFormulario, DataPrediction

class DataSerializer(serializers.ModelSerializer):
    email = serializers.EmailField()
    class Meta:
        model = DataFormulario
        fields = '__all__'

    def create(self, validated_data):
        data = DataFormulario(**validated_data)
        data.save()
        f = open('yolo/files/Secondary_CarColor/labels.txt','w')
        f.write(validated_data['color'])
        f.close()
        f = open('yolo/files/Secondary_CarMake/labels.txt','w')
        f.write(validated_data['marca'])
        f.close()
        f = open('yolo/files/Secondary_VehicleType/labels.txt','w')
        f.write(validated_data['tipo'])
        f.close()
        return data

class DataViewSerializer(serializers.ModelSerializer):
    image = serializers.ImageField()
    class Meta:
        model = DataPrediction
        fields = ('lugar','image')

