@echo off
for /r %%i in (Dockerfile*) do (
    hadolint %%i
)