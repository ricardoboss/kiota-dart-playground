gen:
	dotnet kiota generate -d spec.yml -o lib/generated -l Dart

run:
	dart run
