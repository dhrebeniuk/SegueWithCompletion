# SegueWithCompletion

SegueWithCompletion is UIViewController extension that provides ability perform segue and clarify setup viewcontroller parameters without override prepareForSegue method.

## Installation
Via [CocoaPods](http://cocoapods.org):
```ruby
pod 'SegueWithCompletion', :git => "https://github.com/dhrebeniuk/SegueWithCompletion.git"

```

## Storyboard Usage

### Present UIViewContreoller


Change perform your's segues from this:

```swift

func openFooScreen() {
    self.performSegue(withIdentifier: "fooSegue", sender: nil);
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let fooController = segue.destination as? FooViewController, segue.identifier == "fooSegue" {
        fooController.settings = Settings()
    }
}


```

To this:

```swift

func openFooScreen() {
    self.perform(segue: "fooSegue") { (fooController: FooViewController) in
		fooController.settings = Settings()
    }
}

```

### Present UIViewContreoller with UINavigationController


Change perform your's segues from this:

```swift

func openBarScreen() {
    self.performSegue(withIdentifier: "barSegue", sender: nil);
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let barNavigationController = segue.destination as? UINavigationController, segue.identifier == "fooSegue" {
        if let barController = barNavigationController.topViewController as? BarViewController {
            barController.settings = Settings()
        }
    }
}


```

To this:

```swift

func openBarScreen() {
    self.performWithNavigationController(segue: "barSegue") { (barController: BarViewController) in
        barController.settings = Settings()
    })
}

```

## Compatibility/Restrictions
* iOS8+ only
