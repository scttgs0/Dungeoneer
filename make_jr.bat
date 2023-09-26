
@REM PATH=<path_to_64tass>;%PATH%

mkdir obj

64tass.exe  --c256-pgx ^
            -o obj\dungeoneer.bin ^
            --list=obj\dungeoneer.lst ^
            --labels=obj\dungeoneer.lbl ^
            dungeoneer.asm
