# Ubuntu_COBOL_psql_install
This .sh script installs a lot of packages needed to install and compile :
- GnuCOBOL 3.1.2
- psql & Postgresql
- Open-COBOL-ESQL

It also changes the password of postgresql db user to 'mdp', you should change it afterwards.
It sets the connecting mode if postgresql to md5 instead of peer.
It appends a few exports to .bashrc so ocesql works properly.
It creates a database, a test table and a few rows, to test a .cbl.
It copies a .cob Copybook to ~/Copybook, and adds that PATH (actually $COBCPY) to the env.
It then precompiles, compiles, and executes a COBOL x ESQL program to verify that everything works properly.
