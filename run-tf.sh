#!/bin/bash

tflocal init
tflocal plan
tflocal apply -auto-approve