# protobuf

https://developers.google.com/protocol-buffers

## Usage

```
docker run --rm -v `pwd`/protobuf/:/protobuf -v `pwd`/generated/:/generated chatwork/protobuf:2.5.0 protoc /protobuf/[YOUR_PROTO_FILE].proto --java_out=/generated/ --proto_path=/protobuf/
```