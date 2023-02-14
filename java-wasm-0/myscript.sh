#!/bin/sh
git clone https://github.com/cameronmcnz/java-in-the-browser.git
cd java-in-the-browser
docker run --rm -it -p 8080:8080 -v ${pwd}:/src maven:3-jdk-8 /bin/bash
cd src
mvn package