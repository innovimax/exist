#!/bin/bash
#unset LANG

if [ -z "$EXIST_HOME" ]; then
    EXIST_HOME_1=`dirname "$0"`
    EXIST_HOME=`dirname "$EXIST_HOME_1"`
fi

if [ ! -f "$EXIST_HOME/conf.xml" ]; then
    EXIST_HOME_1="$EXIST_HOME/.."
    EXIST_HOME=$EXIST_HOME_1
fi

if [ -z "$EXIST_BASE" ]; then
    EXIST_BASE=$EXIST_HOME
fi

LOCALCLASSPATH=$JAVA_HOME/lib/tools.jar:$EXIST_BASE/exist.jar:$EXIST_BASE/examples.jar
JARS=`ls -1 $EXIST_BASE/lib/core/*.jar $EXIST_BASE/lib/optional/*.jar`
for jar in $JARS
do
   LOCALCLASSPATH=$jar:$LOCALCLASSPATH ;
done

# use xerces as SAX parser
SAXFACTORY=org.apache.xerces.jaxp.SAXParserFactoryImpl

LOCALCLASSPATH=$CLASSPATH:$LOCALCLASSPATH

if [ -z "$JAVA_OPTS" ]; then
    JAVA_OPTS="-Xms64000k -Xmx128000k -Dfile.encoding=UTF-8"
fi

JAVA_ENDORSED_DIRS="$EXIST_HOME"/lib/endorsed

$JAVA_HOME/bin/java $PROF $JAVA_OPTS \
	-Djavax.xml.parsers.SAXParserFactory=$SAXFACTORY \
	-Djava.endorsed.dirs=$JAVA_ENDORSED_DIRS \
	-Dexist.home=$EXIST_HOME -classpath $LOCALCLASSPATH $*
