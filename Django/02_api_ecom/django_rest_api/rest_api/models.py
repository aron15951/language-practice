from enum import unique
from django.db import models
from datetime import datetime

from django.db.models.base import CASCADE
from django.db.models.fields import EmailField
from django.db.models.functions.text import CharField
from django.db.models.query import DateField

# Create your models here.

class User(models.Model):
    username = models.CharField(max_length=50)
    email = models.EmailField(max_length=100, unique=True)
    password = models.CharField(max_length=100)
    address = models.TextField(max_length=500)
    phone = models.IntegerField()
    create_at = models.DateTimeField(auto_now_add=True)

class Store(models.Model):
    userId = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    create_at = models.DateTimeField(auto_now_add=True)

class Product(models.Model):
    title = models.CharField(max_length=500)
    description = models.TextField(max_length=500)
    storeId = models.ForeignKey(Store, on_delete=models.CASCADE)
    category = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    thumbnail = models.CharField(max_length = 100)
    stock = models.IntegerField()
    condition = models.CharField(max_length = 100)
    rating = models.IntegerField()
    create_at = models.DateTimeField(auto_now_add=True)

class ProductImg(models.Model):
    productId = models.ForeignKey(Product, on_delete=models.CASCADE)
    url = models.CharField(max_lentgh=200)
    
class Cart(models.Model):
    userId = models.ForeignKey(User, on_delete=models.CASCADE)
    quantity = models.IntegerField()

class CartItem(models.Model):
    cartId = models.ForeignKey(Cart, on_delete=models.CASCADE)
    productId = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField
    create_at = models.DateTimeField(auto_now_add=True)

def upload_location(instance, filename):
    ext = filename.split(".")[-1]
    return "%s/%s.%s" % ("img", datetime.now(), ext)

class FileUpdate(models.Model):
    imgFile = models.ImageField(upload_to=upload_location)
