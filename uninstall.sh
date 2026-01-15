sed -i '1i\hello world\nhello dünya' file1.txt
TARGETLINE1="helloworld"
TARGETLINE2="merhabacihan"
KVANTUM_CONFIG="file1.txt"
sed -i -e "$ a $TARGETLINE1\n$TARGETLINE2=true" $KVANTUM_CONFIG
