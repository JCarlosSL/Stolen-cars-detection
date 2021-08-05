from django.urls import path, include
from api.views import RegisterView,DetailPrediction

urlpatterns = [
    path('register/', RegisterView.as_view(), name='Register'),
    path('detail/<int:pk>/',DetailPrediction.as_view(),name='detail prediction'),
]
