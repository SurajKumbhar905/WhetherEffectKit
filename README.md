# WhetherEffectKit

Bring stunning weather effects to your iOS apps effortlessly!

## 🌦 Overview

**WhetherEffectKit** is a lightweight and powerful iOS framework designed to add realistic weather effects to your app with just a few lines of code. Whether you want gentle snowfall or a dramatic thunderstorm, this framework has you covered.

## 🚀 Features

- 🌧 **Rain Effect** with adjustable intensity: *light, moderate, heavy*
- ⚡ **Lightning Bolts** (available in moderate and heavy rain for realism)
- ❄ **Snow Effect** for a peaceful winter ambiance
- 🌍 **Ground Effect** to enhance the rain interaction
- 📱 **Easy Integration** – just import and use!

## 📦 Installation

### Swift Package Manager (Recommended)

1. Open Xcode and navigate to **File > Add Packages**.
2. Enter the repository URL:

   ```
   https://github.com/yourusername/WhetherEffectKit.git
   ```

3. Choose **Add Package** and you're ready to go!

## 🛠 Usage

### Importing the Framework

```swift
import WhetherEffectKit
```

### Adding Weather Effects

#### 🌧 Rain or Snowfall Effect

```swift
WeatherEffectView(effectType: .rain, intensity: .heavy)
```

#### ❄ Snow Effect

```swift
WeatherEffectView(effectType: .snow, intensity: .heavy)
```

#### ⚡ Enabling Lightning (for Rain)

Lightning bolts automatically appear in **moderate and heavy rain** modes for a more realistic stormy effect.

#### 🌍 Enabling Ground Effect for Rain

The framework includes a **ground interaction effect** that enhances realism.

### 🌧 Rainfall or Snowfall Landing Effect

```swift
RoundedRectangle(cornerRadius: 6)
    .frame(width: 100, height: 200)
    .overlay(
        WeatherEffectView(effectType: .rainLanding //.snowLanding, intensity: .moderate) // or .snowLanding
    )
```

## 🏆 Why Use WhetherEffectKit?

✅ **Simple and lightweight**  
✅ **Customizable weather intensity**  
✅ **Realistic lightning and ground effects**  
✅ **Plug-and-play integration**  
✅ **Perfect for immersive UI experiences**  

Give **WhetherEffectKit** a try and elevate your iOS app with mesmerizing weather effects! 🌦⚡❄
