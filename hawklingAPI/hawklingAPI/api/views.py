from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
# Create your views here.


class HelloView(APIView):
    permission_classes = (IsAuthenticated,)

    def get(self, request):
        content = {'message': 'Hello, Hawkling!'}
        return Response(content)

class HomeView(APIView):
    def get(self, request):
        content = {'detail': 'Hawkling API, a minimal API, is meant to showcase' \
             'username/password + jwt authentication for configuring HawkScan.'}
        return Response(content)