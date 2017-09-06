# SegueWithCompletion

SegueWithCompletion is UIViewController extension that provides ability use performSegue method and clarify setup parameters without override prepareForSegue method.

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
		fooController.gaugeDecibelMeterViewModel = settings
	}
}


```

To this:

```swift

func openFooScreen() {

	self.perform(segue: "fooSegue") { (fooController: FooViewController) in
			let settings = Settings()
			fooController.gaugeDecibelMeterViewModel = settings
		}
}

```

Done!

## Compatibility/Restrictions
* iOS8+ only
