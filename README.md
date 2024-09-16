# Network
A simple way to fetch RESFUL resources.

## Usage

Import the framework:

```swift
import Network
```

Define your entity:

```swift
struct Album: Decodable {
    let id: Int
    let title: String
}
```

Create the RemoteResource:

```swift
let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
let resource = RemoteResource<[Album]>(url: url)
```

Now we are ready to make the call:

```swift
let albums = try? await Network.RequestSender.shared().request(resource: resource)
```
