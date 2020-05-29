
Deploy mysql
============

Initially my idea was to use helm chart to quickly deploy HA mysql.
But I faced the problem, that this application does not work on mysql of version >= 8.
So I just abandon this helm setup and decided to go create manifests manually.

To setup mysql:

```
./setup.sh
```

I use stateful set with one replica, few supporting objects and ClusterIP service to
expose it to app.


Build
=====

First app needs to be built. For this I use my own Dockerfile as want to build jar in
separate build container as I do not want it to depend on anything except of my files
and docker.

Also I have to edit config during build phase as it is packed inside jar file. Which
I would not consider the best practice probably, I would prefer externalize config or
ideally to have option to specify configuration using env variables.

So to build image:

```
./build.sh
```

it would build the image and push it to registry, localhost:5000 - very default docker
registry started by provisioning script.

Using minikube it is probably not required, but to simulate bigger k8s, it maybe makes
some sense to have it.

Also it seems that application tries to use TLS to connect to mysql. I disabled this as
I don't think it really makes a lot of sense for inter cluster communications.



Deploy
======

Manifest is `mysql-users.yaml`. To deploy it:

```
./deploy.sh
```

It would also return curl command that can be used to test stuff.

```
curl localhost:31357/all/create
```

example:

```
root@ubuntu-bionic:/vagrant/task3# ./deploy.sh 
deployment.apps/mysql-users unchanged
service/mysql-users unchanged
curl localhost:31357
root@ubuntu-bionic:/vagrant/task3# curl localhost:31357/all/create
[{"id":1,"name":"Sam","salary":3400,"teamName":"Development"}]root@ubuntu-bionic:/vagrant/task3# 
root@ubuntu-bionic:/vagrant/task3# curl localhost:31357/all/
[{"id":1,"name":"Sam","salary":3400,"teamName":"Development"}]root@ubuntu-bionic:/vagrant/task3# 
```

For this phase I use Deployment and NodePort Service to expose it to the world.



Cleanup
=======

```
./cleanup.sh
```

