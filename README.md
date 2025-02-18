This repository is meant to used for testing [kiota](https://aka.ms/kiota) with [Dart](https://dart.dev/), specifically it's features for Multipart requests.

## Setup

You will need to have [Dart](https://dart.dev/) & [.NET](https://dotnet.microsoft.com/en-us/download) installed on your machine.

First, clone this repository:

```bash
git clone https://github.com/ricardoboss/kiota-dart-multipart.git
```

Then, install the dependencies:

```bash
dart pub get
dotnet tool restore
```

## Development

Run kiota using the Makefile:

```bash
make gen
```

You can then run the Dart bin:

```bash
make run # or dart run
```

To debug kiota, you can run do the following:

Create a `.env` file with the following content:

```
KIOTA_PATH=<path to your local kiota.csproj file>
```

Then, run:

```bash
make genproj
```

Or, if you want to run it in watch mode:

```bash
make watchproj
```
