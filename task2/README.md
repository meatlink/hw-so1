
Setup
=====

```
./setup.sh
```

it would deploy kafka using helm, download and extract kafka distr, so that
scripts can be used.



Trigger
=======

```
./trigger.sh
```

trigger can be tested with scripts `create_right_topic.sh`/`create_wrong_topic.sh`

Trigger should react if any wrong topic was created.



Cleanup
=======

```
./cleanup.sh
```
