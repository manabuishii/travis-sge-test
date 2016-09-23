docker run --hostname sgemaster --name sgemaster -d -v $PWD/master_script.sh:/usr/local/bin/master_script.sh  manabuishii/docker-sge-master:0.1.0 /usr/local/bin/master_script.sh
docker run -d -ti --hostname sgeclient --name sgeclient --link sgemaster:sgemaster -v $PWD/act_qmaster:/var/lib/gridengine/default/common/act_qmaster -v $PWD/work:/work --entrypoint=/bin/bash manabuishii/docker-sge-client:0.1.0
# wait to sge master
sleep 10

SGECLIENT=$(docker exec sgeclient cat /etc/hosts | grep sgeclient)
docker exec sgemaster bash -c "echo ${SGECLIENT} >> /etc/hosts"
docker exec sgemaster qconf -as sgeclient

docker exec sgeclient bash -c "echo 'hostname ; date' | qsub -o /tmp/a.txt"
# wait to finish job
sleep 10
echo "--- sgemaster cat /tmp/a.txt"
docker exec sgemaster cat /tmp/a.txt
echo "--- sgemaster cat /tmp/a.txt and grep"
docker exec sgemaster cat /tmp/a.txt | grep sgeclient
RET=$?
echo "RET=[${RET}]"

docker stop sgemaster
docker rm sgemaster
docker stop sgeclient
docker rm sgeclient

exit ${RET}
