.PHONY: clean download-libs help

APP_NAME=app.war

SCP_SERVER=se.ifmo.ru
SCP_USERNAME=s409853
SPC_PATH=~/wildfly-20.0.1.Final/standalone/deployments
SCP_PORT=2222

TARGET_VERSION=8
JAVAC=javac
JAVA=java
JAR=jar
JAR_FLAGS=-cvf
HOME_DIR=$(PWD)
JAVAC_FLAGS=--release $(TARGET_VERSION)
TARGET=$(HOME_DIR)/build
SOURCE=$(HOME_DIR)/src/main/java/db/*.java ./src/main/java/*.java
WEBAPP=$(HOME_DIR)/src/main/webapp
LIB=$(TARGET)/lib
USR_LIB=$(HOME_DIR)/usr_lib
CLASS_PATH=$(TARGET)/classes
WAR_COMPONENTS=$(TARGET)/war/components
WAR_TARGET=$(TARGET)/war/target
URL=https://repo1.maven.org/maven2

help:
	@echo "Available targets:"
	@echo " - clean"
	@echo " - compile"
	@echo " - build"
	@echo " - music"

clean:
	rm -rf $(TARGET)

compile: $(SOURCE) download-libs
	$(JAVAC) $(JAVAC_FLAGS) $(SOURCE) -d $(CLASS_PATH) -cp $(LIB)/\*

build: compile
	mkdir -p $(WAR_COMPONENTS)/WEB-INF/classes/
	cp -r $(CLASS_PATH)/* $(WAR_COMPONENTS)/WEB-INF/classes
	mkdir -p $(WAR_COMPONENTS)/WEB-INF/lib/
	cp -r $(LIB)/* $(WAR_COMPONENTS)/WEB-INF/lib
	cp -r $(WEBAPP)/* $(WAR_COMPONENTS)
	$(JAR) $(JAR_FLAGS) $(WAR_TARGET)/$(APP_NAME) -C $(WAR_COMPONENTS) . && echo "Successfully built to " $(WAR_TARGET)/$(APP_NAME)

music: build
	@echo "🎵"
	@sleep 1
	@echo "🎵"
	@sleep 1
	@echo "🎵"

scp: build
	scp -P $(SCP_PORT) $(WAR_TARGET)/$(APP_NAME) $(SCP_USERNAME)@$(SCP_SERVER):$(SPC_PATH)/$(APP_NAME)

test: build
	# TODO: 

download-libs:
	mkdir -p $(LIB)
	@test -f $(LIB)/javax.faces-api-2.3.jar || curl -L -o $(LIB)/javax.faces-api-2.3.jar \
		$(URL)/javax/faces/javax.faces-api/2.3/javax.faces-api-2.3.jar
	@test -f $(LIB)/cdi-api-1.2.jar || curl -L -o $(LIB)/cdi-api-1.2.jar \
    $(URL)/javax/enterprise/cdi-api/1.2/cdi-api-1.2.jar
	@test -f $(LIB)/hibernate-core-5.3.1.Final.jar || curl -L -o $(LIB)/hibernate-core-5.3.1.Final.jar \
    $(URL)/org/hibernate/hibernate-core/5.3.1.Final/hibernate-core-5.3.1.Final.jar
	@test -f $(LIB)/javax.persistence-api-2.2.jar || curl -L -o $(LIB)/javax.persistence-api-2.2.jar \
    $(URL)/javax/persistence/javax.persistence-api/2.2/javax.persistence-api-2.2.jar
	@test -f $(LIB)/icefaces-ace-4.3.0.jar || curl -L -o $(LIB)/icefaces-ace-4.3.0.jar \
    $(URL)/org/icefaces/icefaces-ace/4.3.0/icefaces-ace-4.3.0.jar
	@test -f $(LIB)/postgresql-42.7.4.jar || curl -L -o $(LIB)/postgresql-42.7.4.jar \
    $(URL)/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar
	@test -f $(LIB)/validation-api-2.0.1.Final.jar || curl -L -o $(LIB)/validation-api-2.0.1.Final.jar \
    $(URL)/javax/validation/validation-api/2.0.1.Final/validation-api-2.0.1.Final.jar
	@test -f $(LIB)/antlr-2.7.7.jar || curl -L -o $(LIB)/antlr-2.7.7.jar \
		$(URL)/antlr/antlr/2.7.7/antlr-2.7.7.jar
	@test -f $(LIB)/byte-buddy-1.8.12.jar || curl -L -o $(LIB)/byte-buddy-1.8.12.jar \
		$(URL)/net/bytebuddy/byte-buddy/1.8.12/byte-buddy-1.8.12.jar
	@test -f $(LIB)/checker-qual-3.42.0.jar || curl -L -o $(LIB)/checker-qual-3.42.0.jar \
		$(URL)/org/checkerframework/checker-qual/3.42.0/checker-qual-3.42.0.jar
	@test -f $(LIB)/classmate-1.3.4.jar || curl -L -o $(LIB)/classmate-1.3.4.jar \
		$(URL)/com/fasterxml/classmate/1.3.4/classmate-1.3.4.jar
	@test -f $(LIB)/icefaces-4.3.0.jar || curl -L -o $(LIB)/icefaces-4.3.0.jar \
		$(URL)/org/icefaces/icefaces/4.3.0/icefaces-4.3.0.jar
	@test -f $(LIB)/javassist-3.22.0-GA.jar || curl -L -o $(LIB)/javassist-3.22.0-GA.jar \
		$(URL)/org/javassist/javassist/3.22.0-GA/javassist-3.22.0-GA.jar
	@test -f $(LIB)/jboss-logging-3.3.2.Final.jar || curl -L -o $(LIB)/jboss-logging-3.3.2.Final.jar \
		$(URL)/org/jboss/logging/jboss-logging/3.3.2.Final/jboss-logging-3.3.2.Final.jar
	@test -f $(LIB)/jboss-transaction-api_1.2_spec-1.1.1.Final.jar || curl -L -o $(LIB)/jboss-transaction-api_1.2_spec-1.1.1.Final.jar \
		$(URL)/org/jboss/spec/javax/transaction/jboss-transaction-api_1.2_spec/1.1.1.Final/jboss-transaction-api_1.2_spec-1.1.1.Final.jar
	@test -f $(LIB)/jandex-2.0.3.Final.jar || curl -L -o $(LIB)/jandex-2.0.3.Final.jar \
		$(URL)/org/jboss/jandex/2.0.3.Final/jandex-2.0.3.Final.jar
	cp -r $(USR_LIB)/* $(LIB) # dom4j-whatever and hibernate-bla-bla-bla are probably not from maven central so lets just copy them
	@#dependencies for test
	@test -f $(LIB)/junit-4.13.2.jar || curl -L -o $(LIB)/junit-4.13.2.jar \
		$(URL)/junit/junit/4.13.2/junit-4.13.2.jar
	@test -f $(LIB)/hamcrest-core-1.3.jar || curl -L -o $(LIB)/hamcrest-core-1.3.jar \
		$(URL)/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar
