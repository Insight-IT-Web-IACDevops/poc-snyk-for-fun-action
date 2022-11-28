#!/usr/bin/env bash

# JAVA env
JV="microsoft-jdk-11.0.17-linux-x64" 
JD="jdk-11.0.17+8" 
JDST="${JV}.tar.gz" 
JAVA_HOME="${GITHUB_WORKSPACE}/${JD}" 
JB="${JAVA_HOME}/bin" 
# NODE env
NV="v18.12.1" 
ND="node-${NV}-linux-x64.tar.xz" 
NH="${GITHUB_WORKSPACE}/node-${NV}-linux-x64" 
NB="${NH}/bin" 
# MAVEN env
MV="3.8.6" 
MVL="apache-maven-${MV}" 
MD="${MVL}-bin.tar.gz" 
M2_HOME="${GITHUB_WORKSPACE}/${MVL}" 
M2="${M2_HOME}/bin" 
MAVEN_OPTS=" -Xms256m -Xmx512m " 
MAVEN_ARGS=" -U -X " 
PATH="${M2}:${JB}:${NB}:${PATH}"
# Print out env 
echo "PATH=${PATH}" 
echo "JV=${JV}" 
echo "JD=${JD}"
echo "JDST=${JDST}"
echo "JAVA_HOME=${JAVA_HOME}"
echo "JB=${JB}"
echo "NV=${NV}"
echo "ND=${ND}"
echo "NH=$NH"
echo "NB=${NB}"
echo "MV=${MV}"
echo "MVL=${MVL}"
echo "MD=${MD}"
echo "M2_HOME=${M2_HOME}"
echo "M2=${M2}"
echo "MAVEN_OPTS=${MAVEN_OPTS}"
echo "MAVEN_ARGS=${MAVEN_ARGS}" 
echo "PATH=${PATH}"
# Removal of conflicting files
rm -Rfv ./.config
rm -Rfv ./.env
rm -Rfv ./__MACOSX
rm -Rfv ./.m2
rm -Rfv ./.mvn 
rm -Rfv ./${JDST}
rm -Rfv ./${JV}
rm -Rfv ./${MD}
rm -Rfv ./${MVL}
rm -Rfv ./${ND}
rm -Rfv ./${NVL}
rm -Rfv ./snyk-cli
rm -Rfv ./snyk-jira
rm -Rfv ./package-lock.json
# Making blanks
mkdir -pv ./.m2
mkdir -pv ./.config/jgit
touch ./.env
# Fetching vendors
wget -O ./${JDST} https://aka.ms/download-jdk/${JDST}
tar xf ./${JDST}
wget -O ./${MD} https://dlcdn.apache.org/maven/maven-3/${MV}/binaries/${MD}
tar xf ./${MD}
wget -O ./${ND} https://nodejs.org/dist/${NV}/${ND}
tar xf ./${ND}
wget -O ./snyk-cli https://github.com/snyk/cli/releases/download/v1.1061.0/snyk-linux
chmod a+x ./snyk-cli
wget -O ./snyk-jira https://github.com/snyk-tech-services/jira-tickets-for-new-vulns/releases/download/4.40.2/snyk-jira-sync-linux
chmod a+x ./snyk-jira
# Listing
ls -lah
# Running versions
 $(java -version | grep version)"
echo "??? java: $(java -version | grep version)"
echo "??? mvn: $(mvn -v)"
echo "??? node: $(node -v)"
echo "??? npm: $(npm -v)"
echo "??? snyk-cli: $(./snyk-cli -v)"
echo "??? snyk-jira: $(find `$(pwd)`/ -type f -name snyk-jira -exec echo "found$@" '{}' \;)"
# EXAMPLE: mvn clean package -Dgib.enabled=false -Dmaven.test.skip=true

