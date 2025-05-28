sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install wget xz-utils make libdb5.3++-dev git gnupg2 lsb-release -y
sudo apt-get install gnucobol3 -y
sudo apt-get remove gnucobol3 -y

tar -xf gnucobol.tar.xz
cd gnucobol-3.1.2
mkdir $ACTUAL_HOME/temp_install
./configure --prefix=$ACTUAL_HOME/temp_install
make install
cd ..

rm -rf $ACTUAL_HOME/temp_install
rm -rf gnucobol.tar.xz gnucobol-3.1.2

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install postgresql-15 postgresql-client-15 -y

sudo cp pg_hba_trust.conf /etc/postgresql/15/main/pg_hba.conf
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo systemctl restart postgresql

psql -U postgres -a -f change_password.sql
export PGPASSWORD=mdp

sudo cp pg_hba_final.conf /etc/postgresql/15/main/pg_hba.conf
sudo systemctl restart postgresql

psql -U postgres -a -f test.sql

git clone https://github.com/opensourcecobol/Open-COBOL-ESQL.git
cd Open-COBOL-ESQL

sudo apt install libpq-dev -y
sudo apt install automake libtool pkg-config bison flex -y

./configure LIBPQ_CFLAGS="-I/usr/include/postgresql" LIBPQ_LIBS="-lpq"
aclocal
autoconf
automake --add-missing
mkdir $ACTUAL_HOME/temp_install
./configure --prefix=$ACTUAL_HOME/temp_install
make
make install
sudo cp -rf $ACTUAL_HOME/temp_install/* /usr/local
rm -rf $ACTUAL_HOME/temp_install
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export COB_LDFLAGS="-Wl,--no-as-needed"
export COBCPY="$ACTUAL_HOME/Copybook/"
echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> $ACTUAL_HOME/.bashrc
echo 'export COB_LDFLAGS="-Wl,--no-as-needed"' >> $ACTUAL_HOME/.bashrc
mkdir $ACTUAL_HOME/Copybook
cp copy/sqlca.cbl $ACTUAL_HOME/Copybook/.
echo "export COBCPY=$ACTUAL_HOME/Copybook/" >> $ACTUAL_HOME/.bashrc
cd ..
ocesql testoce.cbl testoce.cob
cobc -x -locesql -o run testoce.cob
./run
echo "Please note that the postgres db user password is 'mdp', and should be changed"
echo "You must restart the shell (Terminal) before trying to compile with ocesql."