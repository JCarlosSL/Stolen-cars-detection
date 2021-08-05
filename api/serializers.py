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
        f = open('yolo/input.txt','w')
        f.write(validated_data['placa']+'\n')
        f.write(validated_data['marca']+'\n')
        f.write(validated_data['modelo']+'\n')
        f.write(validated_data['tipo']+'\n')
        f.write(validated_data['color']+'\n')
        f.close()
        return data

class DataViewSerializer(serializers.ModelSerializer):
    image = serializers.ImageField()
    class Meta:
        model = DataPrediction
        fields = ('lugar','image')

