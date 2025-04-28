.PHONY: clean download-libs

APP_NAME=app.war

JAVAC=javac
JAVA=java
JAR=jar
JAR_FLAGS=-cvf
HOME_DIR=$(PWD)
TARGET=$(HOME_DIR)/build
SOURCE=$(HOME_DIR)/src/main/java/db/*.java ./src/main/java/*.java
WEBAPP=$(HOME_DIR)/src/main/webapp
LIB=$(TARGET)/lib
CLASS_PATH=$(TARGET)/classes
WAR_COMPONENTS=$(TARGET)/war/components
WAR_TARGET=$(TARGET)/war/target
URL=https://repo1.maven.org/maven2

clean:
	rm -rf $(TARGET)

compile: $(SOURCE) download-libs
	$(JAVAC) $(SOURCE) -d $(CLASS_PATH) -cp $(LIB)/\*

build: compile
	mkdir -p $(WAR_COMPONENTS)/WEB-INF/classes/
	cp -r $(CLASS_PATH)/* $(WAR_COMPONENTS)/WEB-INF/classes
	mkdir -p $(WAR_COMPONENTS)/WEB-INF/lib/
	cp -r $(LIB)/* $(WAR_COMPONENTS)/WEB-INF/lib
	cp -r $(WEBAPP)/* $(WAR_COMPONENTS)
	$(JAR) $(JAR_FLAGS) $(WAR_TARGET)/$(APP_NAME) -C $(WAR_COMPONENTS) . && echo "Successfully builded to " $(WAR_TARGET)/$(APP_NAME)

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
