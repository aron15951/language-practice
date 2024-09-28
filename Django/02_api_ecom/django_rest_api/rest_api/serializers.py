from rest_framework import serializers
from .models import *

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password', 'address', 'phone', 'created_at']

class StoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = Store
        fields = ['id', 'userId', 'name', 'created_at']

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields =['id', 'title', 'description0', 'storeId', 'cotegory','price', 'thumbnail', 'stock', 'condition','rating', 'created_at']
class ProductImgSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductImg
        fields = ['id', 'productId', 'url']

class CartSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cart
        fields = ['id', 'userId','quantity']

class CartItemSerializer(serializers.ModelSerializer):
    class Meta:
        fields = ['id', 'cartId', 'productId', 'quantity', 'created_at']

class FileUploadSerializer(serializers.ModelSerializer):
    class Meta:
        fields = ['imgFile']

class JoinSerializers(serializers.ModelSerializer):
    product_details = ProductSerializer(source='productId')
    class Meta:
        model = CartItem
        fields = ['id', 'cartId', 'productId','quantity', 'product_details', 'created_at']
