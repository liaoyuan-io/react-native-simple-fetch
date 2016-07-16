# react-native-simple-fetch
A partial yet simpler implementation of the `fetch` API for React Native. Currently iOS only.

## Install

1. Run `npm install --save liaoyuan-io/react-native-simple-fetch` .

2. Add `RCTSimpleFetch.xcodeproj` to your iOS project.

3. Add `libRCTSimpleFetch.a` to your `Link Binary with Libraries` section in `Build Phases` .

## Usage

```javascript
import {fetch} from 'react-native-simple-fetch';

fetch("http://api.blahblah.com/msg/123123123", {
    method: 'put',          // upper or lower case
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'User-Agent': 'SuperGreatApp/1.0',
    },
    body: '{"msg": "This is body, possibly text or JSON."}',
    gzipRequest: true       // Will compress request with gzip.
}).then((res)=>{
    console.log("Is OK? ", res.ok);
    console.log("Status Code: ", res.status);
    return res.json();      // or `res.text();`
}).then((obj)=>{
    console.log("Response object is: ", obj);
});
```