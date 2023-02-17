ARG IMAGE=intersystemsdc/irishealth-community:2022.1.0.209.0-zpm
FROM $IMAGE

USER root

# create output folder and file
RUN mkdir /tmp/out
WORKDIR /tmp/out
RUN chown -R irisowner:irisowner /tmp/out

RUN echo "" > patients.txt

WORKDIR /opt/irisapp
RUN chown -R irisowner:irisowner /opt/irisapp

USER irisowner
# copy files to image
WORKDIR /opt/irisapp
COPY --chown=irisowner:irisowner /iris/iris.script iris.script
COPY --chown=irisowner:irisowner src src

# run iris.script
RUN iris start IRIS \
    && iris session IRIS < /opt/irisapp/iris.script \
    && iris stop IRIS quietly