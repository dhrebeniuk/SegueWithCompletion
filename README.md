# SegueWithCompletion

SegueWithCompletion is UIViewController extension that provides ability perform segue and clarify setup viewcontroller parameters without override prepareForSegue method.

## Installation
Via [CocoaPods](http://cocoapods.org):
```ruby
pod 'SegueWithCompletion', :git => "https://github.com/dhrebeniuk/SegueWithCompletion.git"

```

## Usage

### Storyboard Usage

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

Done!

## Compatibility/Restrictions
* iOS8+ only
