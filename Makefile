include .env

KIOTA_ARGS := generate -d spec.yml -o lib/generated -l Dart

gen:
	dotnet kiota $(KIOTA_ARGS)

genproj:
	dotnet run --project ${KIOTA_PATH} --framework net8.0 -- $(KIOTA_ARGS)

watchproj:
	dotnet watch --project ${KIOTA_PATH} --framework net8.0 -- $(KIOTA_ARGS)

run:
	dart run
