kubectl apply -f mysql.yaml

echo "Waiting for mysql to enter running phase"
while ! test "$( kubectl get pod/mysql-0 -o jsonpath='{.status.phase}' )" = "Running" ; do
	echo -n "."
	sleep 5
done
echo ; echo "Done"

