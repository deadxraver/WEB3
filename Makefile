.PHONY: clean download-libs help test xml

APP_NAME=app.war

DIFF_FILE=diff.txt
ALT_FILE=alt.txt
ALT_FILE1=alt1.txt

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
ALT_TARGET=$(TARGET)/alt
SOURCE_DIR=$(HOME_DIR)/src
SOURCE=$(SOURCE_DIR)/main/java/db/*.java $(SOURCE_DIR)/main/java/*.java
ALT_SOURCE_DIR=$(HOME_DIR)/srcalt
ALT_SOURCE=$(ALT_SOURCE_DIR)/main/java/db/*.java $(ALT_SOURCE_DIR)/main/java/*.java
TEST_SOURCE=$(HOME_DIR)/src/test/java
TEST_TARGET=$(TARGET)/test
WEBAPP=$(HOME_DIR)/src/main/webapp
LIB=$(TARGET)/lib
RESOURCES=$(HOME_DIR)/src/main/resources
USR_LIB=$(HOME_DIR)/usr_lib
CLASS_PATH=$(TARGET)/classes
WAR_COMPONENTS=$(TARGET)/war/components
WAR_TARGET=$(TARGET)/war/target
URL=https://repo1.maven.org/maven2
PYTHON=python3.12
UTIL=$(HOME_DIR)/util
REPORT_PATH=/dev/stdout

help:
	@echo "Available targets:"
	@echo " - clean"
	@echo " - compile"
	@echo " - build"
	@echo " - music"
	@echo " - scp"
	@echo " - test"
	@echo " - native2ascii"
	@echo " - xml"
	@echo " - alt"
	@echo " - diff"
	@echo " - report"

clean:
	rm -rf $(TARGET) $(ALT_SOURCE_DIR) $(RESOURCES)/localization_copy.properties

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
	@echo "Some music now!"
	@echo -n "🎵"
	@sleep 1
	@echo -n "🎵"
	@sleep 1
	@echo "🎵"

native2ascii:	$(SOURCE)
	native2ascii $(RESOURCES)/localization.properties $(RESOURCES)/localization_copy.properties

xml:
	$(PYTHON) $(UTIL)/xml_validator.py $(HOME_DIR)/src

alt:
	@test -f $(ALT_FILE) || echo '$(ALT_FILE): no such file, create it or set the ALT_FILE in Makefile'
	@test -f $(ALT_FILE)
	@[ -s $(ALT_FILE) ] || echo 'warning! $(ALT_FILE) is empty!'
	mkdir -p $(ALT_SOURCE_DIR)
	cp -r $(SOURCE_DIR)/* $(ALT_SOURCE_DIR)/
	find $(ALT_SOURCE_DIR) -type f -depth -exec sed -i "s/$$(cat $(ALT_FILE))/g" {} +
	cd $(ALT_SOURCE_DIR)/main/java && mv $$(cat $(HOME_DIR)/$(ALT_FILE1)) || \
		cd $(ALT_SOURCE_DIR)/main/java/db && mv $$(cat $(HOME_DIR)/$(ALT_FILE1)) \
		|| echo 'Nothing to replace'
	make build SOURCE=$(ALT_SOURCE) TARGET=$(ALT_TARGET)

diff:
	@(test -e $(DIFF_FILE)) && \
		([ -s $(DIFF_FILE) ]) && \
		(git diff | grep -E $$(cat $(DIFF_FILE)) > /dev/null && \
		echo "there are changes in files from $(DIFF_FILE)" || \
		(echo 'OK, committing...' && git add . && git commit -m 'auto-commit from diff task') ) || \
		echo '$(DIFF_FILE): no such file or it is empty, please set DIFF_FILE variable in Makefile correctly'

report:	$(SOURCE) $(TEST_SOURCE)
	echo '<test-res>' > $(HOME_DIR)/report.xml
	make test REPORT_PATH=$(HOME_DIR)/report.xml && echo '</test-res>' >> $(HOME_DIR)/report.xml \
		&& echo "Successfully written to $(HOME_DIR)/report.xml" \
		&& git add $(HOME_DIR) && git commit -m "Successful test" || echo 'not all tests pass!'

scp: build
	scp -P $(SCP_PORT) $(WAR_TARGET)/$(APP_NAME) $(SCP_USERNAME)@$(SCP_SERVER):$(SPC_PATH)/$(APP_NAME)


build-test:	build download-libs $(TEST_SOURCE) $(SOURCE)
	mkdir -p $(TEST_TARGET)
	$(JAVAC) -d $(TEST_TARGET) $(TEST_SOURCE)/* -cp $(CLASS_PATH):$(LIB)/\*

test:	build-test
	$(JAVA) -cp $(TEST_TARGET):$(CLASS_PATH):$(LIB)/\* \
		org.junit.runner.JUnitCore $$(ls -1 $(TEST_TARGET) | sed 's/\.class//') >> $(REPORT_PATH)


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
	@test -f $(LIB)/ant-junit-1.10.12.jar || curl -L -o $(LIB)/ant-junit-1.10.12.jar \
		$(URL)/org/apache/ant/ant-junit/1.10.12/ant-junit-1.10.12.jar
