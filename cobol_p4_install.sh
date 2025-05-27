apt-get update -y
apt-get upgrade -y
apt-get install wget xz-utils make libdb5.3++-dev git gnupg2 lsb-release -y
apt-get install gnucobol3 -y
apt-get remove gnucobol3 -y

wget "https://downloads.sourceforge.net/project/gnucobol/gnucobol/3.1/gnucobol-3.1.2.tar.xz?ts=gAAAAABoNUSgqLcqvFvmy084kmiQUJRkGY7UiXVrNxhawDuBa8uZHEoVTUYHyItdEMMMH7o40xGbO9oK5qZtNfGxK_x5a3aPdw%3D%3D&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fgnucobol%2Ffiles%2Fgnucobol%2F3.1%2Fgnucobol-3.1.2.tar.xz%2Fdownload" -O gnucobol.tar.xz
tar -xf gnucobol.tar.xz
cd gnucobol-3.1.2
./configure
make install
cd ..

rm -rf gnucobol.tar.xz gnucobol-3.1.2

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
apt update
apt install postgresql-15 postgresql-client-15 -y
cp pg_hba.conf /etc/postgresql/15/main/pg_hba.conf
systemctl enable postgresql
systemctl start postgresql
git clone https://github.com/opensourcecobol/Open-COBOL-ESQL.git
cd Open-COBOL-ESQL

apt install libpq-dev -y
apt install automake libtool pkg-config bison flex -y

./configure LIBPQ_CFLAGS="-I/usr/include/postgresql" LIBPQ_LIBS="-lpq"
aclocal
autoconf
automake --add-missing
./configure
make
make install
echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> $ACTUAL_HOME/.bashrc
echo 'export COB_LDFLAGS="-Wl,--no-as-needed"' >> $ACTUAL_HOME/.bashrc
mkdir $ACTUAL_HOME/Copybook
cp copy/sqlca.cbl $ACTUAL_HOME/Copybook/.
echo "export COBCPY=$ACTUAL_HOME/Copybook/" >> $ACTUAL_HOME/.bashrc
cd ..
# ocesql testoce.cbl testoce.cob
# cobc -x -locesql -o run testoce.cob
# ./run