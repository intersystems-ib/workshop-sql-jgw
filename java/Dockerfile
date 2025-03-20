### jgw: java gateway server
FROM intersystemsdc/jgw:latest

# copy java src code to $APP_HOME
ARG APP_HOME=/tmp/app
WORKDIR $APP_HOME

COPY lib/*.jar $GWDIR

