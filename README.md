# Inno Video Converter iOS

## Installation

### Cocoapods

To integrate InnoVideoConverteriOS into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'InnoVideoConverteriOS', :git => 'https://github.com/mncinnovation/inno-video-converter-ios.git'
```


## How to use it

Init the class with configurations for the result video

### Simple initialization

```swift
let converter = InnoVideoConverter(videoSourcePath: "PATH",
                                   videoResultName: "VideoResult")
```

### Custom initialization

```swift
let converter = InnoVideoConverter(videoSourcePath: "PATH",
                                   videoResultName: "VideoResult",
                           convertResultVideoScale: CGSize(width: -2, height: 720),
                                               tag: 0,
                                    convertQuality: .medium,
                            convertResultVideoType: .mpeg4,
                                      convertSpeed: .fast)
```

### Convert video

You can call convert method after initialization

```swift
converter.convert()
```

### Cancel converting video

You can call cancel method for cancel the process

```swift
converter.cancel()
```

### Delegate

```swift
converter.delegate = self
```

Implement **InnoVideoConverterDelegate**

```swift
func innoVideoConverter(inProgressAtConverter converter: InnoVideoConverter, percentage: Int) {
    // Progress while video is being converted
}
    
func innoVideoConverter(didSuccessAtConverter converter: InnoVideoConverter, videoPath: String) {
    // Convert video is successful
}
    
// MARK: - Optional InnoVideoConverterDelegate's methods
    
func innoVideoConverter(beginExecuteAtConverter converter: InnoVideoConverter) {
    // Video starts converting
}

func innoVideoConverter(didReceivedLogAtConverter converter: InnoVideoConverter, log: String) {
    // Log while video is being converted
}

func innoVideoConverter(didErrorAtConverter converter: InnoVideoConverter, error: String) {
    // Convert video failed and return error string
}
```
