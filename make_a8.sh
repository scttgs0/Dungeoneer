
mkdir -p obj/

#--------------------------------------

64tass  --m65xx \
        --atari-xex \
        --export-labels \
        -o obj/dungeoneer.xex \
        --list=obj/dungeoneer.lst \
        --labels=obj/dungeoneer.lbl \
        dungeoneer.asm
