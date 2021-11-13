# Instruqt stuff

* First level:  [Pathways](https://github.com/openshift-labs/learn-katacoda/blob/master/using-the-cluster-pathway.json)->[Topics](https://play.instruqt.com/openshift/topics/using-the-cluster)
* Second level: [Courses](https://github.com/openshift-labs/learn-katacoda/blob/master/introduction/cluster-access/index.json)->[Tracks](https://play.instruqt.com/openshift/tracks/logging-in-to-an-openshift-cluster)
* Third level: [Steps](https://github.com/openshift-labs/learn-katacoda/tree/master/introduction/cluster-access)->[Challenges/Assignments](https://play.instruqt.com/openshift/tracks/logging-in-to-an-openshift-cluster/challenges/logging-in-via-the-web-console/assignment)


## Run the script


```bash
git submodule update --init
python kataklisma.py
```

For each generated directory representing the pathway->topic, inside subfolders with tracks:

```
instruqt track validate && instruqt track push
```

Bulk validate

```
for d in `ls -d */ | grep -v learn-katacoda`; do 
  echo $d;
  cd $d;
  for dd in `ls -d */`; do 
    echo $dd;
    cd $dd; 
    instruqt track validate; 
    cd ..; 
  done;
  cd ..; 
done 
```

Bulk validate and push

```
for d in `ls -d */ | grep -v learn-katacoda`; do 
  cd $d;
  echo $d;
  for dd in `ls -d */`; do 
    echo $dd;
    cd $dd; 
    instruqt track validate && instruqt track push --force;
    cd ..;
  done;
  cd ..; 
done

```

