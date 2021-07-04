from rest_framework_simplejwt.views import TokenRefreshView
from core.views import CustomTokenObtainPairView
from django.urls import path

urlpatterns = [
    path('auth/token/', CustomTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('auth/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]

