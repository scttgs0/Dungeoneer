
mkdir -p obj/

#--------------------------------------

64tass  --c256-pgx \
        -o obj/dungeoneer.pgx \
        --list=obj/dungeoneer.lst \
        --labels=obj/dungeoneer.lbl \
        dungeoneer.asm
