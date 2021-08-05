from django.db import models

def logo_dir_path(instance, filename):
    extension = filename.split('.')[-1]
    og_filename = filename.split('.')[0]
    new_filename = "yolo/%s_%s.%s" % (instance.lugar,instance.user, extension)
    return new_filename

class DataFormulario(models.Model):

    dni = models.PositiveIntegerField()
    email = models.EmailField(max_length=200, db_index=True)
    placa = models.CharField(max_length=200, blank=True, null=True)
    marca = models.CharField(max_length=200, blank=True, null=True)
    modelo = models.CharField(max_length=200, blank=True, null=True)
    tipo = models.CharField(max_length=200, blank=True, null=True)
    color = models.CharField(max_length=200, blank=True, null=True)
    tEstimate1 = models.CharField(max_length=200, blank=True, null=True)
    tEstimate2 = models.CharField(max_length=200, blank=True, null=True)
    tEstimate3 = models.CharField(max_length=200, blank=True, null=True)

class DataPrediction(models.Model):
    lugar = models.CharField(max_length=200, blank=True, null=True)
    user = models.ForeignKey(to=DataFormulario, on_delete=models.CASCADE)
    image = models.FileField(upload_to=logo_dir_path)
