@setlocal EnableDelayedExpansion
@color 02
@for /F "usebackq delims=?" %%a in (`dir /s /b *-test.scm`) do @(
  @echo %%a
  @gsi "%%a"
  @if errorlevel 1 @color 04 && @echo FAILED: !errorlevel!
  @if not errorlevel 1 @echo OK
)
@endlocal
