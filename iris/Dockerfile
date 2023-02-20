ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2023.1.0.185.0
FROM $IMAGE

USER root

WORKDIR /opt/irisapp
RUN chown -R irisowner:irisowner /opt/irisapp

USER irisowner

# create output folder and file
RUN mkdir /tmp/out
WORKDIR /tmp/out
RUN chown -R irisowner:irisowner /tmp/out

RUN echo "" > patients.txt


# copy files to image
WORKDIR /opt/irisapp
#COPY --chown=irisowner:irisowner /iris/iris.script iris.script
COPY --chown=irisowner:irisowner src src

COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP /iris/irissession.sh /
RUN chmod +x /irissession.sh

SHELL ["/irissession.sh"]

RUN \
  zn "USER" \
  do ##class(Ens.Config.Credentials).SetCredential("MySQL_User","root","SYS") \
  # load & compile source code
  do $SYSTEM.OBJ.LoadDir("/opt/irisapp/src/Test", "ck", , 1) \
  # do ##class(%File).RemoveDirectoryTree("/tmp") \
  # start production
  set production = "Test.Production" \
  set ^Ens.Configuration("csp","LastProduction") = production \
  do ##class(Ens.Director).SetAutoStart(production) \
  set sc = 1

# run iris.script
# RUN iris start IRIS \
#   && iris session IRIS < /opt/irisapp/iris.script \
#   && iris stop IRIS quietly