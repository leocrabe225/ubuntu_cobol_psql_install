       IDENTIFICATION DIVISION.
       PROGRAM-ID. testoce.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  NOM-PERSONNE   PIC X(100).
       01  USERNAME       PIC X(30) VALUE "cobol".
       01  PASSWD         PIC X(30) VALUE "mdp".
       01  DBNAME         PIC X(10) VALUE "testdb".
       EXEC SQL END DECLARE SECTION END-EXEC.
       
       EXEC SQL INCLUDE SQLCA END-EXEC.
       
       PROCEDURE DIVISION.
           
           DISPLAY "Connexion à PostgreSQL...".
           
           
           EXEC SQL
            CONNECT :USERNAME IDENTIFIED BY :PASSWD USING :DBNAME
           END-EXEC.
           
           IF SQLCODE NOT = 0
            DISPLAY "Erreur de connexion SQLCODE: " SQLCODE
            STOP RUN
           END-IF.
           
           DISPLAY "Connexion réussie !".
           
           EXEC SQL
            SELECT nom INTO :NOM-PERSONNE
            FROM personnes
            WHERE id = 1
           END-EXEC.
           

           DISPLAY "Nom trouvé : " NOM-PERSONNE
           
           DISPLAY "Déconnexion réussie."
           
           STOP RUN.