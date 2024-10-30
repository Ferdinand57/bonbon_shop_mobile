## Assignment Answers

### 1. Explain what are stateless widgets and stateful widgets, and explain the difference between them.

In Flutter, widgets are like the legos that make up the app's UI (User Interface [what's showed to the user])

- **Stateless widgets** are like rigid lego pieces, they are used for parts of the app that don't need to update dynamically

- **Stateful widgets** are like interactive lego pieces, they can change and update in response to user actions or data changes, they are used when the app needs to react to changes

The key difference is that stateless widgets remain the same once built, while stateful widgets can rebuild themselves when their state changes, and both play an important part in creating a better interface for the user

### 2. Mention the widgets that you have used for this project and its uses.

- **MaterialApp**: Sets up the app's basic configurations, including the theme and home screen
- **Scaffold**: Provides a structure for the app, including app bar and body
- **AppBar**: Displays the app bar at the top with the shop's name
- **Text**: Displays text on the screen
- **GridView**: Creates a grid layout to display the buttons
- **Material**: Applies Material Design styling to widgets
- **InkWell**: Makes widgets respond to touch (used to create tappable buttons)
- **Icon**: Displays an icon from the Material Icons library
- **SnackBar**: Shows brief messages at the bottom of the screen in response to user actions

### 3. What is the use-case for setState()? Explain the variable that can be affected by setState().

**setState()** is used in stateful widgets to inform the app that some data has changed and the UI needs to update to reflect this change, it's like telling the app to refresh a part of the screen

Variables that can be affected by **setState()** are those that are part of the widget's state and can change over time, such as counters, form inputs, or any dynamic data

(In this project, we used stateless widgets, so **setState()** was not used)

### 4. Explain the difference between const and final keyword.

- **const**: Indicates that a value is constant and unchangeable, it must be known at compile time, it's like setting something in stone, it cannot be altered

- **final**: Means that a variable can be set once and cannot be changed afterward, the value can be determined at runtime, it's like filling a jar, you can put something in it once, and then it's sealed

Both are used to create variables that shouldn't change, but **const** is more restrictive and requires the value to be known ahead of time


# 5. Explain how you implemented the checklist above step-by-step.


1. Created a new Flutter application named bonbon_shop.

- Used the flutter create command to set up the project structure.

2. Modified main.dart to change the app title to "Bonbon's Shop" and adjusted the theme colors to shades of orange to match the shop's branding.

3. Created menu.dart in the lib directory to organize the main menu code separately from main.dart for better code management.

4. Moved MyHomePage from main.dart to menu.dart, adjusting it to be a stateless widget since we didn't need to manage any changing state.

5. Declared a variable for the shop name inside MyHomePage to display the shop's name in the app bar.

6. Created a list of buttons by defining the ItemHomepage class and adding instances for "View Product List", "Add Product", and "Logout", each with an icon and a unique color.

7. Created the ItemCard class to display each button as a tappable card. When tapped, it shows a SnackBar with a message specific to the button pressed.

8. Integrated the ItemCard into MyHomePage by updating the build method to display the buttons in a grid layout using GridView.count.

9. Enabled web support by running flutter config --enable-web to ensure the app can run on Chrome.

## Create a new Flutter application with the E-Commerce theme that matches the previous assignments.

- Open terminal or command prompt.
- Run the following commands to create a new Flutter project and navigate into it:
```
flutter create bonbon_shop
cd bonbon_shop
```
(This creates a new Flutter application in a folder named bonbon_shop.)

- Open the lib/main.dart file in your code editor, and modify it to the following:
```
import 'package:flutter/material.dart';
import 'package:bonbon_shop/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonbon\'s Shop',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has an orange toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
        ).copyWith(secondary: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
```
(This sets the app title to "Bonbon's Shop" and applies an orange theme)

## Create three simple buttons with icons and texts for:

### Viewing the product list (View Product List)

### Adding a product (Add Product)

### Logout (Logout)

In the lib directory, create a new file named menu.dart.

At the top of menu.dart, add the following import statement:
```
import 'package:flutter/material.dart';
```


Move the MyHomePage widget to menu.dart and adjust it with the following:

- Cut the MyHomePage class from main.dart and paste it into menu.dart.

- In main.dart, ensure you have the following import:
```
import 'package:bonbon_shop/menu.dart';
```

In menu.dart, declare the variables npm, name, and className:

```
class MyHomePage extends StatelessWidget {
  final String npm = '2306256324'; // NPM
  final String name = 'Ferdinand Bonfilio Simamora'; // Name
  final String className = 'PBP KKI'; // Class
  final List<ItemHomepage> items = [
    ItemHomepage("View Product List", Icons.list, Colors.orangeAccent),
    ItemHomepage("Add Product", Icons.add, Colors.deepOrange),
    ItemHomepage("Logout", Icons.logout, Colors.orange),
  ];
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure of the page with the AppBar and body.
    return Scaffold(
      // AppBar is the top part of the page that displays the title.
      appBar: AppBar(
        // The title of the application "Bonbon's Shop" with white text and bold font.
        title: const Text(
          'Bonbon\'s Shop',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // The background color of the AppBar is obtained from the application theme color scheme.
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Body of the page with paddings around it.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Place the widget vertically in a column.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row to display 3 InfoCard horizontally.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: name),
                InfoCard(title: 'Class', content: className),
              ],
            ),

            // Give a vertical space of 16 units.
            const SizedBox(height: 16.0),

            // Place the following widget in the center of the page.
            Center(
              child: Column(
                // Place the text and grid item vertically.

                children: [
                  // Display the welcome message with bold font and size 18.
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Welcome to Bonbon\'s Shop',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // Grid to display ItemCard in a 3 column grid.
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    // To ensure that the grid fits its height.
                    shrinkWrap: true,

                    // Display ItemCard for each item in the items list.
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
(The items list now includes different orange-themed colors for each button to maintain variety)

Create the InfoCard class:
```
class InfoCard extends StatelessWidget {
  // Card information that displays the title and content.

  final String title;  // Card title.
  final String content;  // Card content.

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Create a card box with a shadow.
      elevation: 2.0,
      child: Container(
        // Set the size and spacing within the card.
        width: MediaQuery.of(context).size.width / 3.5, // Adjust with the width of the device used.
        padding: const EdgeInsets.all(16.0),
        // Place the title and content vertically.
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}
```

Create the ItemHomepage class to define the buttons:
```
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}
```

Create the ItemCard class to display each button:
```
class ItemCard extends StatelessWidget {
  // Display the card with an icon and name.

  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // Specify the background color of the application theme.
      color: item.color,
      // Round the card border.
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        // Action when the card is pressed.
        onTap: () {
          // Display the SnackBar message when the card is pressed.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("You have pressed the ${item.name} button!"))
            );
        },
        // Container to store the Icon and Text
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              // Place the Icon and Text in the center of the card.
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## Implement different colors for each button (View Product List, Add Product, and Logout).

We have already done this when we declare variable in MyHomePage class with the following code:
```
final List<ItemHomepage> items = [
  ItemHomepage("View Product List", Icons.list, Colors.orangeAccent),
  ItemHomepage("Add Product", Icons.add, Colors.deepOrange),
  ItemHomepage("Logout", Icons.logout, Colors.brown),
];
```

## Display a Snackbar with the following messages:
### "You have pressed the View Product List button" when the View Product List button is pressed.
### "You have pressed the Add Product button" when the Add Product button is pressed.
### "You have pressed the Logout button" when the Logout button is pressed.

We have already done this inside the creation of ItemCard class with the following bit of code:
```
onTap: () {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text("You have pressed the ${item.name} button!"))
    );
},
```


