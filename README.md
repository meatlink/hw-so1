Start vagrant, run provision.sh, then tasks in separate folders are ready to be
examined.

```
vagrant destroy -f # if cleanup required
vagrant up
vagrant ssh

sudo -i
cd /vagrant
ls
./provision.sh  # decided not to run it automatically using Vagrant for flexibility


cd task1
./setup.sh
./append_n_non_matching_records.sh 10
./trigger.sh # No trigger

./append_matching_record.sh # 1
./append_n_non_matching_records.sh 10
./trigger.sh # No trigger

./append_matching_record.sh # 2
./append_n_non_matching_records.sh 10
./trigger.sh # No trigger

./append_matching_record.sh # 3
./append_n_non_matching_records.sh 10
./trigger.sh # Trigger!

./cleanup.sh


cd ../task2
./setup.sh

./create_right_topic.sh
./trigger.sh # No trigger.

./create_wrong_topic.sh
./trigger.sh # Trigger!

./cleanup.sh


cd ../task3/
./setup.sh
./build.sh
./deploy.sh   # Would also pring curl command
# curl localhost:32335/all/create 
# curl localhost:32335/all/
./cleanup.sh
```

