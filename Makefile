.PHONY: clean download-libs

CC=javac
HOME_DIR=.
TARGET=$(HOME_DIR)/build
SOURCE=$(HOME_DIR)/src/main/java/db/*.java ./src/main/java/*.java
LIB=$(HOME_DIR)/lib
URL=https://repo1.maven.org/maven2

clean:
	rm -rf $(TARGET) $(LIB)

compile: $(SOURCE) download-libs
	$(CC) $(SOURCE) -d $(TARGET) -cp $(LIB)/\*

download-libs:
	mkdir -p $(LIB)
	curl -L -o $(LIB)/javax.faces-api-2.3.jar \
      $(URL)/javax/faces/javax.faces-api/2.3/javax.faces-api-2.3.jar
	curl -L -o $(LIB)/cdi-api-1.2.jar \
      $(URL)/javax/enterprise/cdi-api/1.2/cdi-api-1.2.jar
	curl -L -o $(LIB)/hibernate-core-5.3.1.Final.jar \
      $(URL)/org/hibernate/hibernate-core/5.3.1.Final/hibernate-core-5.3.1.Final.jar
	curl -L -o $(LIB)/javax.persistence-api-2.2.jar \
      $(URL)/javax/persistence/javax.persistence-api/2.2/javax.persistence-api-2.2.jar
	curl -L -o $(LIB)/icefaces-ace-4.3.0.jar \
      $(URL)/org/icefaces/icefaces-ace/4.3.0/icefaces-ace-4.3.0.jar
	curl -L -o $(LIB)/postgresql-42.7.4.jar \
      $(URL)/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar
	curl -L -o $(LIB)/validation-api-2.0.1.Final.jar \
      $(URL)/javax/validation/validation-api/2.0.1.Final/validation-api-2.0.1.Final.jar
