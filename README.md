# Answer the following questions in the README.md in the root folder (please modify the README.md you previously created; add subheadings for each assignment):

## Explain why we need to create a model to retrieve or send JSON data. Will an error occur if we don't create a model first?

Creating a model is like making a template or blueprint for the data we expect to receive or send, for example imagine you're ordering a piece of furniture online, knowing its dimensions, color, and material helps you visualize and plan where to place it in your home, similarly, a model in our app defines the structure of the data, what pieces of information we'll have, like names, dates, or numbers

When our app communicates with a web service, the data is often in JSON format, which is a way of structuring data that's easy for computers to read and write, however, raw JSON data can be messy and hard to work with directly in the app, therefore by creating a model, we can neatly convert this JSON data into objects that are easy to use within our app

If we don't create a model first, it would be like trying to assemble furniture without instructions or a picture of the final product, even if it is technically possible, it's much more difficult, and without a model, our app might not understand how to handle the data properly, which could lead to errors when trying to display or manipulate the information

## Explain the function of the http library that you implemented for this task.

The http library acts like a mail carrier between our app and the web service/server, just as a mail carrier delivers letters and packages between people, the http library sends requests to and receives responses from the server over the internet

When our app needs to fetch data (like getting the latest news or user information), it uses the http library to send a request to the server, which the server then sends back the data, and the http library helps our app receive and understand it

In short, the http library enables our flutter and django app to communicate with each other over the internet, making it possible to retrieve information from django web services and display it to the user via flutter and even retrive information from the flutter app and inputting it to the django server, enabling user to experience the full feature of the website while still being mobile at the same time

## Explain the function of CookieRequest and why it’s necessary to share the CookieRequest instance with all components in the Flutter app.

CookieRequest is like a personal assistant that keeps track of our session when we're interacting with a website or service, it manages cookies, which are small pieces of data stored on our device that help websites remember who we are, like staying logged in or keeping items in a shopping cart

In our app, CookieRequest handles sending requests to the server and managing these cookies, therefore by sharing the same CookieRequest instance with all parts of the app, we make sure that every component is on the same page regarding the user's session

This is important because:

- It helps with consistency between all parts of the app, because all parts of the app access the same session information, therefore the user can stay logged in across different pages
- It helps in maintaining the user's authentication state (logged in or out) throughout the app
- Sharing a single instance simplifies the code and avoids the need to pass around session information manually

Without sharing CookieRequest, different parts of the app might not recognize that the user is logged in, leading to a confusing experience where some features require re-authentication or do not work as expected

## Explain the mechanism of data transmission, from input to display in Flutter.

Let's think of the app as a two-way communication system between the user's flutter app and the django server:

1. The user interacts with the app by filling out a form, typing a message, or pressing a button
2. The app takes this input and packages it into a request and using tools like the http library or CookieRequest, it sends this request over the internet to the server
3. The server receives the request, processes the data (maybe saving it to a database or performing some calculations), and make a response
4. The app receives the server's response, which is often in JSON format
5. The app uses models to convert this raw data into usable objects, like unwrapping a package and organizing its contents
6. Finally, the app updates the user interface to display the new information, this could be showing a confirmation message, updating a list of items, or navigating to a new screen

Throughout this process, the app and server work together to handle data securely and efficiently, providing a smooth experience for the user

## Explain the authentication mechanism from login, register, to logout. Start from inputting account data in Flutter to Django’s completion of the authentication process and display of the menu in Flutter.

Authentication is like the security process of entering a building where you need to prove who you are to gain access.

Login:

1. The user opens the flutter app and enters their username and password into the login form
2. When they tap the "Login" button, the app sends these credentials to the django server using CookieRequest
3.The server receives the credentials and compare them with its database:
- If the username and password match a registered user, the server recognizes the user, then it will sends back a success message along with session information, after that the app notes that the user is now logged in and navigates to the main menu or home screen
- If not, the server responds with an error message explaining the issue

Register:

1. The user opens the flutter app and fills out the registration form with their desired username and password
2. When they tap the "Register" button, the app sends this information to the django server's registration endpoint using CookieRequest
3. The server processes the registration:
- If the username is not already taken and the passwords match and meet security requirements, the server creates a new user account and sends back a success message
- If there's an issue (like the username already exists or passwords don't match), the server responds with an error message explaining the problem
4. How the app handles the server's response:
- Success: The app informs the user that registration was successful and may redirect them to the login screen
- Failure: The app displays the error message so the user can correct the issue

Logout:

1. The user chooses to log out by tapping the "Logout" button in the flutter app
2. The app sends a logout request to the django server using CookieRequest
3. The server processes the request by ending the user's session and clearing any session data
4. The server sends back a confirmation that the user has been logged out
5. The app updates its state to reflect that the user is no longer logged in and navigates back to the login screen or a public area of the app

Throughout the Process:

- CookieRequest handles session cookies, ensuring that the django server recognizes the user's session across different requests
- By sharing the CookieRequest instance with all components, the flutter app maintains a consistent understanding of whether the user is logged in or out
- The app provides feedback at each step—informing the user of successful actions or errors that need attention


# Explain how you implement the checklist above step by step! (not just following the tutorial).

### Ensure the deployment of your Django project is running smoothly. For issues related to PWS, which cannot yet be integrated with Flutter, the Teaching Assistant Team will provide further information later. In the meantime, you are allowed to perform integration on localhost only.
    
## Implement the registration feature in the Flutter project.

I added a registration feature to allow new users to create accounts directly from the Flutter app

- I created a new file named register.dart in the lib/screens/ directory of the Flutter project, this page contains a form where users can input their desired username and password

- In register.dart, I imported the necessary packages, including pbp_django_auth for handling authentication and provider for state management
```
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bonbon_shop/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
```

- The RegisterPage class defines the registration page, with controllers to handle input from the username and password fields
```
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // UI code for the registration form
  }
}
```
The main function of this code is to create a user interface for registration and to handle user input through text fields

- When the user taps the "Register" button, the app captures the inputted username and passwords, then it sends a POST request to the Django server's registration endpoint to create a new user
```
ElevatedButton(
  onPressed: () async {
    String username = _usernameController.text;
    String password1 = _passwordController.text;
    String password2 = _confirmPasswordController.text;

    // Sending the registration data to the server
    final response = await request.postJson(
      "http://127.0.0.1:8000/auth/register/",
      jsonEncode({
        "username": username,
        "password1": password1,
        "password2": password2,
      }),
    );

    if (context.mounted) {
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully registered!'),
          ),
        );
        // Navigate to the login page after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to register!'),
          ),
        );
      }
    }
  },
  // Button styling code
)
```
This code handles the main function of sending registration data to the server and processing the server's response. If registration is successful, it shows a success message and navigates the user to the login page. If it fails, it displays an error message

- Implementing the Registration View in Django: On the Django side, I needed to handle the registration request and create a new user. In my bonbon_shop project, the registration view is defined in views.py
```
from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def register(request):
    form = UserCreationForm()

    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Your account has been successfully created!')
            return redirect('main:login')
    context = {'form': form}
    return render(request, 'register.html', context)
```
The main function of this code is to handle user registration:
- It checks if the request method is POST.
- It uses UserCreationForm to validate and save the new user data.
- If the form is valid, it saves the new user and redirects to the login page.
- If the form is invalid or the method is not POST, it renders the registration page with the form.

Updating URLs in Django: I added the registration endpoint in bonbon_shop/urls.py:
```
from django.urls import path
from .views import register

urlpatterns = [
    # other paths
    path('register/', register, name='register'),
    # other paths
]
```
This makes the registration endpoint accessible at /register/

## Create a login page in the Flutter project.

I implemented a login page to allow existing users to access their accounts

- I created a new file named login.dart in the lib/screens/ directory, this page contains a form for users to enter their username and password

- In login.dart, I imported necessary packages and created controllers for the input fields
```
import 'package:bonbon_shop/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bonbon_shop/screens/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // UI code for the login form
  }
}

```
The main function of this code is to create a user interface for login and to handle user input through text fields

- When the "Login" button is tapped, the app sends the entered credentials to the Django server for authentication
```
ElevatedButton(
  onPressed: () async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Sending login credentials to the server
    final response = await request.login(
      "http://127.0.0.1:8000/auth/login/",
      {
        'username': username,
        'password': password,
      },
    );

    if (request.loggedIn) {
      String message = response['message'];
      String uname = response['username'];
      if (context.mounted) {
        // Navigate to the home page after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text("$message Welcome, $uname.")),
          );
      }
    } else {
      if (context.mounted) {
        // Show error message if login fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: Text(response['message']),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    }
  },
  // Button styling code
)

```
This code performs the main function of authenticating the user. It sends the username and password to the server, and depending on the server's response, it either logs the user in and navigates to the home page or displays an error message

- Implementing the Login View in Django: In bonbon_shop/views.py, I defined the login view.
```
from django.shortcuts import render, redirect
from django.contrib.auth.forms import AuthenticationForm
from django.contrib import messages
from django.contrib.auth import authenticate, login
from django.http import HttpResponseRedirect
from django.urls import reverse
import datetime

def login_user(request):
    if request.method == 'POST':
        form = AuthenticationForm(data=request.POST)

        if form.is_valid():
            user = form.get_user()
            login(request, user)
            response = HttpResponseRedirect(reverse("main:show_main"))
            response.set_cookie('last_login', str(datetime.datetime.now()))
            return response
        else:
            messages.error(request, "Invalid username or password. Please try again.")
    else:
        form = AuthenticationForm(request)
    context = {'form': form}
    return render(request, 'login.html', context)
```
The main function of this code is to authenticate users:
- It checks if the request method is POST.
- It uses AuthenticationForm to validate the credentials.
- If valid, it logs the user in and redirects to the main page.
- It sets a cookie to record the last login time.
- If invalid, it displays an error message.

Updating URLs in Django: I added the login endpoint in bonbon_shop/urls.py:
```
from django.urls import path
from .views import login_user

urlpatterns = [
    # other paths
    path('login/', login_user, name='login'),
    # other paths
]
```
This makes the login endpoint accessible at /login/

## Integrate the Django authentication system with the Flutter project.

Integration was achieved by ensuring that the Flutter app could communicate with the Django server and maintain session state

- I used the pbp_django_auth package to handle authentication and session management between Flutter and Django

- In the main.dart file, I set up a Provider to share an instance of CookieRequest with all components of the app
```
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bonbon_shop/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Bonbon\'s Shop',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.orange,
          ).copyWith(secondary: Colors.deepOrangeAccent),
        ),
        home: LoginPage(),
      ),
    );
  }
}

```
The main function of this code is to provide the CookieRequest instance to the entire app, allowing all parts of the app to access session information and maintain authentication state

- In each page where authenticated requests are needed, I accessed the CookieRequest instance using context.watch<CookieRequest>()
```
@override
Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();
  // Rest of the build method
}
```
This allows the app to include session cookies in HTTP requests, ensuring that the server recognizes the user's session

- Configuring CORS and CSRF in Django

In settings.py, I added configurations to handle CORS and CSRF settings to allow communication from the Flutter app
```
INSTALLED_APPS = [
    # other apps
    'corsheaders',
    'main',
    'authentication',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'corsheaders.middleware.CorsMiddleware',
]

CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```
These settings enable the Flutter app to communicate with the Django backend by allowing cross-origin requests and properly handling cookies

## Create a custom model according to your Django application project.

- In bonbon_shop/models.py, I defined the ProductEntry model.
```
from django.db import models
import uuid
from django.contrib.auth.models import User

class ProductEntry(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=255)
    time = models.DateField(auto_now_add=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    description = models.CharField(max_length=255)

    def __str__(self):
        return self.name
```
This model represents the product data in the database, including fields like user, name, time, price, and description

I also created a custom model in Flutter to match the data structure of the Django models, facilitating data handling in the app

- I used Quicktype to generate Dart model code based on a sample JSON response from the Django endpoint

- I created a new file named product_entry.dart in the lib/models/ directory
```
import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  String model;
  String pk;
  Fields fields;

  ProductEntry({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int user;
  String name;
  DateTime time;
  String price;
  String description;

  Fields({
    required this.user,
    required this.name,
    required this.time,
    required this.price,
    required this.description,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    name: json["name"],
    time: DateTime.parse(json["time"]),
    price: json["price"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "name": name,
    "time": "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
    "price": price,
    "description": description,
  };
}

```
The main function of this code is to define the structure of the product data. It provides methods to convert JSON data into Dart objects (fromJson) and vice versa (toJson), making it easier to work with product data in the app

## Create a page containing a list of all items available at the JSON endpoint in Django that you have deployed.

I created a product list page to display all products retrieved from the Django backend

- I created a new file named list_productentry.dart in the lib/screens/ directory
```
import 'package:flutter/material.dart';
import 'package:bonbon_shop/models/product_entry.dart';
import 'package:bonbon_shop/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bonbon_shop/screens/product_detail.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  State<ProductEntryPage> createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    // Fetching product data from the Django server
    final response = await request.get('http://127.0.0.1:8000/json/');
    var data = response;
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // UI code to display the list of products
  }
}

```
The main function of this code is to fetch product data from the server and display it in a list

- In bonbon_shop/views.py, I added a view to return the list of products in JSON format.
```
from django.http import HttpResponse
from django.core import serializers
from .models import ProductEntry
from django.contrib.auth.decorators import login_required

@login_required(login_url='/login')
def show_json(request):
    data = ProductEntry.objects.filter(user=request.user)
    return HttpResponse(serializers.serialize("json", data), content_type="application/json")
```
This view serializes the product data and returns it as JSON, filtering products by the current user.

Updating URLs in Django: I added the JSON endpoint in bonbon_shop/urls.py:
```
from django.urls import path
from .views import show_json

urlpatterns = [
    # other paths
    path('json/', show_json, name='show_json'),
    # other paths
]
```

### Display the name, price, and description of each item on this page.

In the ListView.builder, I displayed the name, price, and description of each product
```
return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (_, index) => GestureDetector(
    onTap: () {
      // Navigate to the product detail page when tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: snapshot.data![index],
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${snapshot.data![index].fields.name}",
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text("${snapshot.data![index].fields.description}"),
          const SizedBox(height: 10),
          Text("Price: ${snapshot.data![index].fields.price}"),
        ],
      ),
    ),
  ),
);

```
This code performs the main function of displaying the product details in a list format. Each item includes the product name, description, and price

## Create a detail page for each item listed on the Product list page.

I implemented a detail page to show all attributes of a product when it is selected from the list

- This page can be accessed by tapping on any item on the Product list page.
- Display all attributes of your item model on this page.
- Add a button to return to the item list page.

I created a new file named product_detail.dart in the lib/screens/ directory
```
import 'package:flutter/material.dart';
import 'package:bonbon_shop/models/product_entry.dart';
import 'package:bonbon_shop/screens/list_productentry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.fields.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Description:",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              product.fields.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Price: ${product.fields.price}",
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Date Added: ${product.fields.time.toLocal()}",
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the product list page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductEntryPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                "Back to Product List",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

The main function of this code is to display all details of a selected product, including name, description, price, and date added. It also provides a button to return to the product list page

- In list_productentry.dart, I added navigation to the detail page when a product is tapped
```
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailPage(
        product: snapshot.data![index],
      ),
    ),
  );
},

```
This allows users to tap on a product in the list and view its detailed information

## Filter the item list page to display only items associated with the currently logged-in user.

To ensure that users see only their own products, I made changes to both the backend and frontend

- In the Django view that returns the JSON data, I filtered the products by the logged-in user
```
@login_required(login_url='/login')
def show_json(request):
    data = ProductEntry.objects.filter(user=request.user)
    return HttpResponse(serializers.serialize("json", data), content_type="application/json")

```
The main function of this code is to retrieve only the products that belong to the authenticated user, ensuring that users see only their own data

Since the backend now returns only the user's products, the Flutter app automatically displays only those items in the product list page
