@echo off
chcp 65001
setlocal enabledelayedexpansion

echo [DEBUG] เริ่มต้นการทำงาน...
echo [DEBUG] ไฟล์ที่ส่งมาคือ: "%~1"

if "%~1" == "" (
    echo [!] ข้อผิดพลาด: ไม่พบไฟล์ถูกส่งมา กรุณาลากไฟล์ .ttf มาวางทับไฟล์ .bat นี้
    pause
    exit /b
)

set "filename=%~n1"
set "extension=%~x1"

echo [DEBUG] ชื่อไฟล์: %filename%
echo [DEBUG] นามสกุล: %extension%

if /i not "%extension%"==".ttf" (
    echo [!] ข้อผิดพลาด: ไฟล์นี้ไม่ใช่ .ttf
    pause
    exit /b
)

if not exist "msdf-atlas-gen\msdf-atlas-gen.exe" (
    echo [!] ไม่พบโปรแกรมใน: msdf-atlas-gen\msdf-atlas-gen.exe
    pause
    exit /b
)

echo [PROCESS] กำลังประมวลผล...
"msdf-atlas-gen\msdf-atlas-gen.exe" -font "%~1" -charset "msdf-atlas-gen\charset_thai.txt" -type msdf -minsize 10.5 -pxrange 4 -dimensions 512 512 -yorigin top -imageout "%filename%.png" -json "%filename%.json"

if not exist "font_fix" mkdir "font_fix"
move /Y "%filename%.png" "font_fix\"
move /Y "%filename%.json" "font_fix\"

echo [FINISH] ทำงานเสร็จสิ้น!
pause