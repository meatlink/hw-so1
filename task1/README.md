TL;DR;
=====

```
./setup.sh

./append_n_non_matching_records.sh 20
./append_matching_record.sh
./append_n_non_matching_records.sh 10
./append_matching_record.sh
./append_n_non_matching_records.sh 10

./trigger.sh
# Would say 'No trigger.'

./append_n_non_matching_records.sh 20
./append_matching_record.sh
./append_n_non_matching_records.sh 10
./append_matching_record.sh
./append_n_non_matching_records.sh 10

./trigger.sh
# Would say 'Trigger!'

./uninstall.sh
```

Setup
=====

First we will install elasticsearch.

I chose to use helm as we already have task that requires kubernetes.

To setup everything required, just run `setup.sh`

```
./setup.sh
```

it would deploy very simple all-default elastic in default NS and create config for trigger:




Adding test records
===================

There are two scripts:

  - `append_matching_record.sh` to write recored that would match
  - `append_n_non_matching_records.sh` to write N records that would not match

Example:

```
./append_n_non_matching_records.sh 20
./append_matching_record.sh
./append_n_non_matching_records.sh 10
./append_matching_record.sh
./append_n_non_matching_records.sh 10
```

42 records would be written to elastic. 2 matching, 40 non-matching


Running trigger
===============

Just run `trigger.sh`

```
./trigger.sh
```

If there are >=3 matching records it would say `Trigger!` and `No trigger.` otherwise.


CLEANUP
=======

To cleanup just run `cleanup.sh`

```
./cleanup.sh
```
