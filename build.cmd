@echo off

for %%P in (Win32 Win64) do (
  for %%F in (%%P/*.dll) do (
    call :rc_res %%P %%F

    debian run pigz -c -z --best %%P/%%F > %%P/%%F.zz
    call :rc_res %%P %%F.zz
    del %%P\%%F.zz
  )
)
exit /b

:rc_res
echo %~n2 RCDATA %2 > temp.rc
cgrc -I %1 -fo%1\%2.res temp.rc
del temp.rc
exit /b