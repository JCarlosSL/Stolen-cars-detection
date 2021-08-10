from rest_framework import serializers
from api.models import DataFormulario, DataPrediction

color = {
    'black' : 'black;;;;;;;;;;;',
    'blue' : ';blue;;;;;;;;;;',
    'brown' : ';;brown;;;;;;;;;',
    'gold' : ';;;gold;;;;;;;;',
    'green' : ';;;;green;;;;;;;',
    'grey' : ';;;;;grey;;;;;;',
    'maroon' : ';;;;;;maroon;;;;;',
    'orange' : ';;;;;;;orange;;;;',
    'red' : ';;;;;;;;red;;;',
    'silver' : ';;;;;;;;;silver;;',
    'white' : ';;;;;;;;;;white;',
    'yellow' : ';;;;;;;;;;;yellow',
}

marca = {
    'acura' : 'acura;;;;;;;;;;;;;;;;;;;',
    'audi' : ';audi;;;;;;;;;;;;;;;;;;',
    'bmw' : ';;bmw;;;;;;;;;;;;;;;;;',
    'chevrolet' : ';;;chevrolet;;;;;;;;;;;;;;;;',
    'chrysler' : ';;;;chrysler;;;;;;;;;;;;;;;',
    'dodge' : ';;;;;dodge;;;;;;;;;;;;;;',
    'ford' : ';;;;;;ford;;;;;;;;;;;;;',
    'gmc' : ';;;;;;;gmc;;;;;;;;;;;;',
    'honda' : ';;;;;;;;honda;;;;;;;;;;;',
    'hyundai' : ';;;;;;;;;hyundai;;;;;;;;;;',
    'infiniti' : ';;;;;;;;;;infiniti;;;;;;;;;',
    'jeep' : ';;;;;;;;;;;jeep;;;;;;;;',
    'kia' : ';;;;;;;;;;;;kia;;;;;;;',
    'lexus' : ';;;;;;;;;;;;;lexus;;;;;;',
    'mazda' : ';;;;;;;;;;;;;;mazda;;;;;',
    'mercedes' : ';;;;;;;;;;;;;;;mercedes;;;;',
    'nissan' : ';;;;;;;;;;;;;;;;nissan;;;',
    'subaru' : ';;;;;;;;;;;;;;;;;subaru;;',
    'toyota' : ';;;;;;;;;;;;;;;;;;toyota;',
    'volkswagen' : ';;;;;;;;;;;;;;;;;;;volkswagen',

}

tipo = {
    'couple' : 'coupe;;;;;',
    'largevehicle' : ';largevehicle;;;;',
    'sedan' : ';;sedan;;;',
    'suv' : ';;;suv;;',
    'truck' : ';;;;truck;',
    'van' : ';;;;;van',
}

class DataSerializer(serializers.ModelSerializer):
    email = serializers.EmailField()
    class Meta:
        model = DataFormulario
        fields = '__all__'

    def create(self, validated_data):
        data = DataFormulario(**validated_data)
        data.save()
        f = open('yolo/files/Secondary_CarColor/labels.txt','w')
        f.write(color[validated_data['color']])
        f.close()
        f = open('yolo/files/Secondary_CarMake/labels.txt','w')
        f.write(marca[validated_data['marca']])
        f.close()
        f = open('yolo/files/Secondary_VehicleType/labels.txt','w')
        f.write(tipo[validated_data['tipo']])
        f.close()
        return data

class DataViewSerializer(serializers.ModelSerializer):
    image = serializers.ImageField()
    class Meta:
        model = DataPrediction
        fields = ('lugar','image')

