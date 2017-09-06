# SegueWithCompletion

SegueWithCompletion is UIViewController extension that provides ability perform segue and clarify setup viewcontroller parameters without override prepareForSegue method.

## Installation
Via [CocoaPods](http://cocoapods.org):
```ruby
pod 'SegueWithCompletion', :git => "https://github.com/dhrebeniuk/SegueWithCompletion.git"

```

## Usage

### Storyboard Usage

Change change perform your's segues from this:

```swift

func openFooScreen() {

	self.performSegue(withIdentifier: "fooSegue", sender: nil);
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

	if let fooController = segue.destination as? FooViewController, 
	 segue.identifier == "fooSegue" 
	{
		let settings = Settings()
		fooController.settings = settings
	}
}


```

To this:

```swift

func openFooScreen() {

	self.perform(segue: "fooSegue") { (fooController: FooViewController) in
		let settings = Settings()
		fooController.settings = settings
	}
}

```

Done!

## Compatibility/Restrictions
* iOS8+ only
