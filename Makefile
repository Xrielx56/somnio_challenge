gen:
	dart run build_runner build --delete-conflicting-outputs

loc:
	flutter gen-l10n

format:
	dart format --line-length=80 --set-exit-if-changed .

pre-commit: 
	fvm flutter test
	dart format --line-length=80 --set-exit-if-changed .
	fvm flutter analyze

# Debes tener instalado lcov (brew install lcov)
check-coverage:
	fvm flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html