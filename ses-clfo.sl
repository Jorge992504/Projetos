           SELECT SES-CLFO
                ASSIGN TO "SES-CLFO.DAT"
                ORGANIZATION INDEXED
                ACCESS MODE DYNAMIC
                LOCK MODE AUTOMATIC
                RECORD KEY CLFO-CHAVE
                ALTERNATE RECORD KEY CLFO-CHAVE-1
                   WITH DUPLICATES
                ALTERNATE RECORD KEY CLFO-CHAVE-2
                   WITH DUPLICATES
                ALTERNATE RECORD KEY CLFO-CHAVE-3
                   WITH DUPLICATES
                ALTERNATE RECORD KEY CLFO-CHAVE-EXT-1 = CLFO-CD-TECNICO
                   CLFO-CD-CLIFOR
                FILE STATUS FS-SES-CLFO.
